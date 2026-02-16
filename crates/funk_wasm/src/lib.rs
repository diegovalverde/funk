use funk_vm::bytecode::OpCode;
use funk_vm::vm::Value;
use funk_vm::{load_bytecode_from_bytes, run_function_with_host, run_with_host, Bytecode, VmError, VmHost};
use js_sys::Array;
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

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = globalThis, js_name = __funk_host_call, catch)]
    fn js_host_call(name: &str, args: JsValue) -> Result<JsValue, JsValue>;
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

    fn call_host(&mut self, name: &str, args: &[Value]) -> Result<Value, VmError> {
        let js_args = Array::new();
        for arg in args {
            js_args.push(&vm_value_to_js(arg));
        }
        let js_result = js_host_call(name, js_args.into()).map_err(|err| {
            VmError::new(
                "E_EFFECT",
                format!("host effect '{}' failed: {}", name, js_error_to_string(&err)),
            )
        })?;
        js_to_vm_value(&js_result).map_err(|msg| {
            VmError::new(
                "E_EFFECT",
                format!("host effect '{}' returned unsupported value: {}", name, msg),
            )
        })
    }
}

#[wasm_bindgen]
pub fn run_bytecode(
    bytecode_bytes: &[u8],
    fuel: Option<u32>,
    max_output_bytes: Option<u32>,
    allow_host_effects: Option<bool>,
) -> JsValue {
    let fuel_budget = fuel.unwrap_or(DEFAULT_FUEL);
    let output_cap = max_output_bytes.unwrap_or(DEFAULT_OUTPUT_LIMIT);
    let host_effects_allowed = allow_host_effects.unwrap_or(false);

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

    if let Some(err) = reject_disallowed_effects(&bytecode, host_effects_allowed) {
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
pub fn call_function(
    bytecode_bytes: &[u8],
    function_name: &str,
    args: JsValue,
    fuel: Option<u32>,
    max_output_bytes: Option<u32>,
    allow_host_effects: Option<bool>,
) -> JsValue {
    let fuel_budget = fuel.unwrap_or(DEFAULT_FUEL);
    let output_cap = max_output_bytes.unwrap_or(DEFAULT_OUTPUT_LIMIT);
    let host_effects_allowed = allow_host_effects.unwrap_or(false);

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

    if let Some(err) = reject_disallowed_effects(&bytecode, host_effects_allowed) {
        return serialize_payload(RunResultPayload {
            ok: false,
            output: String::new(),
            return_value: None,
            error: Some(err),
        });
    }

    let call_args = match js_args_to_vm_values(&args) {
        Ok(v) => v,
        Err(msg) => {
            return serialize_payload(RunResultPayload {
                ok: false,
                output: String::new(),
                return_value: None,
                error: Some(RunnerError {
                    code: "E4305".to_string(),
                    message: format!("invalid function arguments: {}", msg),
                }),
            })
        }
    };

    let mut host = BufferHost::new(output_cap as usize);
    match run_function_with_host(
        &bytecode,
        function_name,
        call_args,
        fuel_budget as u64,
        &mut host,
    ) {
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
pub fn check_bytecode(bytecode_bytes: &[u8], allow_host_effects: Option<bool>) -> JsValue {
    let host_effects_allowed = allow_host_effects.unwrap_or(false);
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

    if let Some(err) = reject_disallowed_effects(&bytecode, host_effects_allowed) {
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

fn reject_disallowed_effects(bytecode: &Bytecode, allow_host_effects: bool) -> Option<RunnerError> {
    for func in &bytecode.functions {
        for ins in &func.code {
            match ins.op {
                OpCode::CallBuiltin => match ins.id {
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
                },
                OpCode::CallHost => {
                    if !allow_host_effects {
                        return Some(RunnerError {
                            code: "E_EFFECT".to_string(),
                            message: "disallowed effect: host graphics/runtime effects are not available in browser safe mode".to_string(),
                        });
                    }
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

fn js_error_to_string(err: &JsValue) -> String {
    if let Some(s) = err.as_string() {
        return s;
    }
    "unknown JS host error".to_string()
}

fn vm_value_to_js(value: &Value) -> JsValue {
    match value {
        Value::Int(v) => JsValue::from_f64(*v as f64),
        Value::Float(v) => JsValue::from_f64(*v),
        Value::Bool(v) => JsValue::from_bool(*v),
        Value::String(s) => JsValue::from_str(s),
        Value::List(items) => {
            let array = Array::new();
            for item in items.iter() {
                array.push(&vm_value_to_js(item));
            }
            array.into()
        }
        Value::Unit => JsValue::UNDEFINED,
    }
}

fn js_to_vm_value(value: &JsValue) -> Result<Value, &'static str> {
    if value.is_undefined() || value.is_null() {
        return Ok(Value::Unit);
    }
    if let Some(v) = value.as_bool() {
        return Ok(Value::Bool(v));
    }
    if let Some(v) = value.as_string() {
        return Ok(Value::String(v));
    }
    if let Some(v) = value.as_f64() {
        let int_v = v as i64;
        if (int_v as f64 - v).abs() < f64::EPSILON {
            return Ok(Value::Int(int_v));
        }
        return Ok(Value::Float(v));
    }
    if Array::is_array(value) {
        let arr = Array::from(value);
        let mut out = Vec::with_capacity(arr.length() as usize);
        for idx in 0..arr.length() {
            let entry = arr.get(idx);
            out.push(js_to_vm_value(&entry)?);
        }
        return Ok(Value::List(std::rc::Rc::new(out)));
    }
    Err("only number/bool/string/list/undefined are supported")
}

fn js_args_to_vm_values(value: &JsValue) -> Result<Vec<Value>, &'static str> {
    if value.is_undefined() || value.is_null() {
        return Ok(Vec::new());
    }
    if !Array::is_array(value) {
        return Err("args must be a JS array");
    }
    let arr = Array::from(value);
    let mut out = Vec::with_capacity(arr.length() as usize);
    for idx in 0..arr.length() {
        out.push(js_to_vm_value(&arr.get(idx))?);
    }
    Ok(out)
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
