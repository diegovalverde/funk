use funk_vm::bytecode::OpCode;
use funk_vm::vm::Value;
use funk_vm::{load_bytecode_from_bytes, run_with_host, Bytecode, VmError, VmHost};
use serde::Serialize;
use wasm_bindgen::prelude::*;

const DEFAULT_FUEL: u32 = 10_000_000;
const DEFAULT_OUTPUT_LIMIT: u32 = 64 * 1024;

#[derive(Debug, Serialize)]
struct RunnerError {
    code: String,
    message: String,
}

#[derive(Debug, Serialize)]
struct RunResultPayload {
    ok: bool,
    output: String,
    return_value: Option<String>,
    error: Option<RunnerError>,
}

#[derive(Debug, Serialize, Default)]
struct SourceStats {
    comments: usize,
    numbers: usize,
    strings: usize,
    identifiers: usize,
}

struct BufferHost {
    out: String,
    max_output_bytes: usize,
}

impl BufferHost {
    fn new(max_output_bytes: usize) -> Self {
        Self {
            out: String::new(),
            max_output_bytes,
        }
    }

    fn push_text(&mut self, text: &str) -> Result<(), VmError> {
        let next = self.out.len() + text.len();
        if next > self.max_output_bytes {
            return Err(VmError::new(
                "E_OUTPUT_LIMIT",
                format!(
                    "output limit exceeded ({} bytes > {} bytes)",
                    next, self.max_output_bytes
                ),
            ));
        }
        self.out.push_str(text);
        Ok(())
    }
}

impl VmHost for BufferHost {
    fn write(&mut self, text: &str) -> Result<(), VmError> {
        self.push_text(text)
    }

    fn writeln(&mut self, text: &str) -> Result<(), VmError> {
        self.push_text(text)?;
        self.push_text("\n")
    }
}

#[wasm_bindgen]
pub fn run_bytecode(bytecode_bytes: &[u8], fuel: Option<u32>, max_output_bytes: Option<u32>) -> JsValue {
    let fuel_budget = fuel.unwrap_or(DEFAULT_FUEL);
    let output_cap = max_output_bytes.unwrap_or(DEFAULT_OUTPUT_LIMIT);

    let bytecode = match load_bytecode_from_bytes(bytecode_bytes) {
        Ok(v) => v,
        Err(e) => {
            return serialize_payload(RunResultPayload {
                ok: false,
                output: String::new(),
                return_value: None,
                error: Some(RunnerError {
                    code: e.code.to_string(),
                    message: e.message,
                }),
            })
        }
    };

    if let Some(err) = reject_disallowed_effects(&bytecode) {
        return serialize_payload(RunResultPayload {
            ok: false,
            output: String::new(),
            return_value: None,
            error: Some(err),
        });
    }

    let mut host = BufferHost::new(output_cap as usize);
    match run_with_host(&bytecode, fuel_budget as u64, &mut host) {
        Ok(result) => serialize_payload(RunResultPayload {
            ok: true,
            output: host.out,
            return_value: Some(render_value(&result.return_value)),
            error: None,
        }),
        Err(e) => {
            let mapped = map_vm_error(e);
            serialize_payload(RunResultPayload {
                ok: false,
                output: host.out,
                return_value: None,
                error: Some(mapped),
            })
        }
    }
}

#[wasm_bindgen]
pub fn check_bytecode(bytecode_bytes: &[u8]) -> JsValue {
    let bytecode = match load_bytecode_from_bytes(bytecode_bytes) {
        Ok(v) => v,
        Err(e) => {
            return serialize_payload(RunResultPayload {
                ok: false,
                output: String::new(),
                return_value: None,
                error: Some(RunnerError {
                    code: e.code.to_string(),
                    message: e.message,
                }),
            })
        }
    };

    if let Some(err) = reject_disallowed_effects(&bytecode) {
        return serialize_payload(RunResultPayload {
            ok: false,
            output: String::new(),
            return_value: None,
            error: Some(err),
        });
    }

    serialize_payload(RunResultPayload {
        ok: true,
        output: String::new(),
        return_value: None,
        error: None,
    })
}

#[wasm_bindgen]
pub fn source_stats(src: &str) -> JsValue {
    serialize_payload(scan_source_stats(src))
}

fn reject_disallowed_effects(bytecode: &Bytecode) -> Option<RunnerError> {
    for func in &bytecode.functions {
        for ins in &func.code {
            if ins.op != OpCode::CallBuiltin {
                continue;
            }
            match ins.id {
                Some(3) => {
                    return Some(RunnerError {
                        code: "E_EFFECT".to_string(),
                        message: "disallowed effect: process exit builtin is not available in browser".to_string(),
                    })
                }
                Some(46) => {
                    return Some(RunnerError {
                        code: "E_EFFECT".to_string(),
                        message: "disallowed effect: filesystem builtin is not available in browser".to_string(),
                    })
                }
                _ => {}
            }
        }
    }
    None
}

fn map_vm_error(err: VmError) -> RunnerError {
    let code = match err.code {
        "E4301" => "E_FUEL",
        "E_OUTPUT_LIMIT" => "E_OUTPUT_LIMIT",
        _ => err.code,
    };
    RunnerError {
        code: code.to_string(),
        message: err.message,
    }
}

fn render_value(value: &Value) -> String {
    match value {
        Value::Int(v) => v.to_string(),
        Value::Float(v) => v.to_string(),
        Value::Bool(v) => v.to_string(),
        Value::String(s) => s.clone(),
        Value::List(items) => {
            let mut out = String::from("[");
            for (i, item) in items.iter().enumerate() {
                if i > 0 {
                    out.push_str(", ");
                }
                out.push_str(&render_value(item));
            }
            out.push(']');
            out
        }
        Value::Unit => "()".to_string(),
    }
}

fn scan_source_stats(src: &str) -> SourceStats {
    let mut stats = SourceStats::default();
    let mut chars = src.chars().peekable();

    while let Some(ch) = chars.next() {
        if ch == '#' {
            stats.comments += 1;
            while let Some(c) = chars.peek() {
                if *c == '\n' {
                    break;
                }
                chars.next();
            }
            continue;
        }

        if ch == '"' {
            stats.strings += 1;
            let mut escaped = false;
            for c in chars.by_ref() {
                if escaped {
                    escaped = false;
                    continue;
                }
                if c == '\\' {
                    escaped = true;
                    continue;
                }
                if c == '"' {
                    break;
                }
            }
            continue;
        }

        if ch.is_ascii_digit() {
            stats.numbers += 1;
            while let Some(c) = chars.peek() {
                if c.is_ascii_digit() || *c == '.' {
                    chars.next();
                } else {
                    break;
                }
            }
            continue;
        }

        if ch.is_ascii_alphabetic() || ch == '_' {
            stats.identifiers += 1;
            while let Some(c) = chars.peek() {
                if c.is_ascii_alphanumeric() || *c == '_' {
                    chars.next();
                } else {
                    break;
                }
            }
        }
    }

    stats
}

fn serialize_payload<T: Serialize>(payload: T) -> JsValue {
    serde_wasm_bindgen::to_value(&payload).expect("serialize payload")
}

#[cfg(test)]
mod tests {
    use super::scan_source_stats;

    #[test]
    fn counts_basic_tokens() {
        let src = r#"
# hello
main():
    x <- 42
    y <- "hi"
    say(x + y)
"#;
        let stats = scan_source_stats(src);
        assert_eq!(stats.comments, 1);
        assert_eq!(stats.numbers, 1);
        assert_eq!(stats.strings, 1);
        assert!(stats.identifiers >= 5);
    }
}
