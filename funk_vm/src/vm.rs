use std::fmt;
use std::io::{self, Write};

use crate::bytecode::{
    op_name, require_bool_arg, require_f64_arg, require_i64_arg, require_u32_arg, Bytecode,
    BytecodeError, OpCode,
};

pub const DEFAULT_FUEL: u64 = 10_000_000;

#[derive(Debug, Clone, PartialEq)]
pub enum Value {
    Int(i64),
    Float(f64),
    Bool(bool),
    String(String),
    List(Vec<Value>),
    Unit,
}

#[derive(Debug, Clone)]
pub struct VmResult {
    pub return_value: Value,
}

#[derive(Debug, Clone)]
pub struct VmError {
    pub code: &'static str,
    pub message: String,
}

impl VmError {
    pub fn new(code: &'static str, message: impl Into<String>) -> Self {
        Self {
            code,
            message: message.into(),
        }
    }
}

impl fmt::Display for VmError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}: {}", self.code, self.message)
    }
}

impl std::error::Error for VmError {}

impl From<BytecodeError> for VmError {
    fn from(value: BytecodeError) -> Self {
        VmError::new(value.code, value.message)
    }
}

#[derive(Debug, Clone)]
struct Frame {
    fn_id: usize,
    ip: usize,
    locals: Vec<Value>,
}

pub fn run(bytecode: &Bytecode, fuel: u64) -> Result<VmResult, VmError> {
    bytecode.validate()?;
    let mut stack: Vec<Value> = Vec::new();
    let mut frames = vec![Frame {
        fn_id: bytecode.entry_fn as usize,
        ip: 0,
        locals: Vec::new(),
    }];
    let mut fuel_left = fuel;

    while let Some(frame) = frames.last_mut() {
        if fuel_left == 0 {
            return Err(VmError::new("E4301", "execution fuel exhausted"));
        }
        fuel_left -= 1;

        let func = &bytecode.functions[frame.fn_id];
        if frame.ip >= func.code.len() {
            return Err(VmError::new(
                "E4302",
                format!("function '{}' terminated without RETURN", func.name),
            ));
        }

        let ins = &func.code[frame.ip];
        frame.ip += 1;
        match ins.op {
            OpCode::PushInt => {
                let v = require_i64_arg(ins, "PUSH_INT")?;
                stack.push(Value::Int(v));
            }
            OpCode::PushFloat => {
                let v = require_f64_arg(ins, "PUSH_FLOAT")?;
                stack.push(Value::Float(v));
            }
            OpCode::PushBool => {
                let v = require_bool_arg(ins, "PUSH_BOOL")?;
                stack.push(Value::Bool(v));
            }
            OpCode::PushString => {
                let idx = require_u32_arg(ins, "PUSH_STRING")? as usize;
                let s = bytecode.strings.get(idx).ok_or_else(|| {
                    VmError::new("E4303", format!("PUSH_STRING index {} out of bounds", idx))
                })?;
                stack.push(Value::String(s.clone()));
            }
            OpCode::PushUnit => stack.push(Value::Unit),
            OpCode::LoadLocal => {
                let idx = require_u32_arg(ins, "LOAD_LOCAL")? as usize;
                let v = frame.locals.get(idx).ok_or_else(|| {
                    VmError::new(
                        "E4303",
                        format!("LOAD_LOCAL index {} out of bounds in '{}'", idx, func.name),
                    )
                })?;
                stack.push(v.clone());
            }
            OpCode::StoreLocal => {
                let idx = require_u32_arg(ins, "STORE_LOCAL")? as usize;
                let v = stack
                    .pop()
                    .ok_or_else(|| VmError::new("E4304", "stack underflow in STORE_LOCAL"))?;
                if frame.locals.len() <= idx {
                    frame.locals.resize(idx + 1, Value::Unit);
                }
                frame.locals[idx] = v;
            }
            OpCode::Pop => {
                stack
                    .pop()
                    .ok_or_else(|| VmError::new("E4304", "stack underflow in POP"))?;
            }
            OpCode::Jump => {
                let target = require_u32_arg(ins, "JUMP")? as usize;
                if target > func.code.len() {
                    return Err(VmError::new("E4303", "JUMP target out of bounds"));
                }
                frame.ip = target;
            }
            OpCode::JumpIfFalse => {
                let target = require_u32_arg(ins, "JUMP_IF_FALSE")? as usize;
                let cond = stack.pop().ok_or_else(|| {
                    VmError::new("E4304", "stack underflow in JUMP_IF_FALSE condition")
                })?;
                let should_jump = match cond {
                    Value::Bool(v) => !v,
                    _ => {
                        return Err(VmError::new(
                            "E4305",
                            "JUMP_IF_FALSE expects bool condition",
                        ))
                    }
                };
                if should_jump {
                    if target > func.code.len() {
                        return Err(VmError::new("E4303", "JUMP_IF_FALSE target out of bounds"));
                    }
                    frame.ip = target;
                }
            }
            OpCode::CallBuiltin => {
                let id = ins
                    .id
                    .ok_or_else(|| VmError::new("E4305", "CALL_BUILTIN missing id"))?;
                let argc = ins
                    .argc
                    .ok_or_else(|| VmError::new("E4305", "CALL_BUILTIN missing argc"))?
                    as usize;
                if stack.len() < argc {
                    return Err(VmError::new("E4304", "stack underflow in CALL_BUILTIN"));
                }
                let args = stack.split_off(stack.len() - argc);
                let result = call_builtin(id, &args)?;
                stack.push(result);
            }
            OpCode::CallFn => {
                let target_fn = require_u32_arg(ins, "CALL_FN")? as usize;
                let argc = ins
                    .argc
                    .ok_or_else(|| VmError::new("E4305", "CALL_FN missing argc"))?
                    as usize;
                let target = bytecode.functions.get(target_fn).ok_or_else(|| {
                    VmError::new("E4303", format!("CALL_FN function {} out of bounds", target_fn))
                })?;
                if target.captures != 0 {
                    return Err(VmError::new(
                        "E4305",
                        "CALL_FN cannot target closure-compiled function",
                    ));
                }
                if target.arity as usize != argc {
                    return Err(VmError::new(
                        "E4305",
                        format!(
                            "CALL_FN arity mismatch for '{}': expected {}, got {}",
                            target.name, target.arity, argc
                        ),
                    ));
                }
                if stack.len() < argc {
                    return Err(VmError::new("E4304", "stack underflow in CALL_FN"));
                }
                let args = stack.split_off(stack.len() - argc);
                frames.push(Frame {
                    fn_id: target_fn,
                    ip: 0,
                    locals: args,
                });
            }
            OpCode::Return => {
                let ret = stack
                    .pop()
                    .ok_or_else(|| VmError::new("E4304", "stack underflow in RETURN"))?;
                frames.pop();
                if frames.is_empty() {
                    return Ok(VmResult { return_value: ret });
                }
                stack.push(ret);
            }
            OpCode::Trap => {
                let idx = require_u32_arg(ins, "TRAP")? as usize;
                let msg = bytecode.strings.get(idx).ok_or_else(|| {
                    VmError::new("E4303", format!("TRAP string index {} out of bounds", idx))
                })?;
                return Err(VmError::new("E4306", msg.clone()));
            }
            OpCode::MkList => {
                let argc = ins
                    .argc
                    .ok_or_else(|| VmError::new("E4305", "MK_LIST missing argc"))?
                    as usize;
                if stack.len() < argc {
                    return Err(VmError::new("E4304", "stack underflow in MK_LIST"));
                }
                let items = stack.split_off(stack.len() - argc);
                stack.push(Value::List(items));
            }
            OpCode::GetIndex => {
                let idx_val = stack
                    .pop()
                    .ok_or_else(|| VmError::new("E4304", "stack underflow in GET_INDEX"))?;
                let list_val = stack
                    .pop()
                    .ok_or_else(|| VmError::new("E4304", "stack underflow in GET_INDEX"))?;
                let idx = match idx_val {
                    Value::Int(v) if v >= 0 => v as usize,
                    _ => return Err(VmError::new("E4305", "GET_INDEX expects non-negative integer index")),
                };
                match list_val {
                    Value::List(items) => {
                        let item = items.get(idx).ok_or_else(|| {
                            VmError::new("E4303", "GET_INDEX list index out of bounds")
                        })?;
                        stack.push(item.clone());
                    }
                    _ => return Err(VmError::new("E4305", "GET_INDEX expects list value")),
                }
            }
            OpCode::Len => {
                let value = stack
                    .pop()
                    .ok_or_else(|| VmError::new("E4304", "stack underflow in LEN"))?;
                let len = match value {
                    Value::List(items) => items.len() as i64,
                    Value::String(s) => s.chars().count() as i64,
                    _ => return Err(VmError::new("E4305", "LEN expects list or string")),
                };
                stack.push(Value::Int(len));
            }
        }
    }

    Err(VmError::new("E4302", "program terminated without RETURN"))
}

fn call_builtin(id: u8, args: &[Value]) -> Result<Value, VmError> {
    match id {
        1 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "print expects one argument"));
            }
            print!("{}", render_value(&args[0]));
            io::stdout()
                .flush()
                .map_err(|e| VmError::new("E4305", format!("print flush failed: {e}")))?;
            Ok(Value::Unit)
        }
        2 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "println expects one argument"));
            }
            println!("{}", render_value(&args[0]));
            Ok(Value::Unit)
        }
        20 => {
            let (a, b) = int2(args, "+")?;
            a.checked_add(b)
                .map(Value::Int)
                .ok_or_else(|| VmError::new("E4305", "integer overflow in +"))
        }
        21 => {
            let (a, b) = int2(args, "-")?;
            a.checked_sub(b)
                .map(Value::Int)
                .ok_or_else(|| VmError::new("E4305", "integer overflow in -"))
        }
        22 => {
            let (a, b) = int2(args, "*")?;
            a.checked_mul(b)
                .map(Value::Int)
                .ok_or_else(|| VmError::new("E4305", "integer overflow in *"))
        }
        23 => {
            let (a, b) = int2(args, "/")?;
            if b == 0 {
                return Err(VmError::new("E4305", "division by zero"));
            }
            a.checked_div(b)
                .map(Value::Int)
                .ok_or_else(|| VmError::new("E4305", "integer overflow in /"))
        }
        24 => {
            let (a, b) = int2(args, "%")?;
            if b == 0 {
                return Err(VmError::new("E4305", "division by zero"));
            }
            a.checked_rem(b)
                .map(Value::Int)
                .ok_or_else(|| VmError::new("E4305", "integer overflow in %"))
        }
        25 => cmp_eq(args, true),
        26 => cmp_eq(args, false),
        27 => cmp_i64(args, |a, b| a < b, "<"),
        28 => cmp_i64(args, |a, b| a <= b, "<="),
        29 => cmp_i64(args, |a, b| a > b, ">"),
        30 => cmp_i64(args, |a, b| a >= b, ">="),
        31 => bool2(args, "and").map(|(a, b)| Value::Bool(a && b)),
        32 => bool2(args, "or").map(|(a, b)| Value::Bool(a || b)),
        33 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "not expects one bool arg"));
            }
            let v = match args[0] {
                Value::Bool(v) => v,
                _ => return Err(VmError::new("E4305", "not expects bool arg")),
            };
            Ok(Value::Bool(!v))
        }
        34 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "neg expects one integer arg"));
            }
            let v = match args[0] {
                Value::Int(v) => v,
                _ => return Err(VmError::new("E4305", "neg expects integer arg")),
            };
            v.checked_neg()
                .map(Value::Int)
                .ok_or_else(|| VmError::new("E4305", "integer overflow in neg"))
        }
        36 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "len expects one arg"));
            }
            let len = match &args[0] {
                Value::List(items) => items.len() as i64,
                Value::String(s) => s.chars().count() as i64,
                _ => return Err(VmError::new("E4305", "len expects list or string")),
            };
            Ok(Value::Int(len))
        }
        37 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "abs expects one numeric arg"));
            }
            match args[0] {
                Value::Int(v) => v
                    .checked_abs()
                    .map(Value::Int)
                    .ok_or_else(|| VmError::new("E4305", "integer overflow in abs")),
                Value::Float(v) => Ok(Value::Float(v.abs())),
                _ => Err(VmError::new("E4305", "abs expects int or float arg")),
            }
        }
        _ => Err(VmError::new(
            "E4305",
            format!("unsupported builtin id {}", id),
        )),
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

fn cmp_eq(args: &[Value], eq: bool) -> Result<Value, VmError> {
    if args.len() != 2 {
        return Err(VmError::new("E4305", "comparison expects 2 args"));
    }
    let res = args[0] == args[1];
    Ok(Value::Bool(if eq { res } else { !res }))
}

fn cmp_i64(args: &[Value], f: fn(i64, i64) -> bool, op: &str) -> Result<Value, VmError> {
    let (a, b) = int2(args, op)?;
    Ok(Value::Bool(f(a, b)))
}

fn int2(args: &[Value], op: &str) -> Result<(i64, i64), VmError> {
    if args.len() != 2 {
        return Err(VmError::new(
            "E4305",
            format!("builtin {} expects 2 integer args", op),
        ));
    }
    let a = match args[0] {
        Value::Int(v) => v,
        _ => {
            return Err(VmError::new(
                "E4305",
                format!("builtin {} arg0 must be int", op),
            ))
        }
    };
    let b = match args[1] {
        Value::Int(v) => v,
        _ => {
            return Err(VmError::new(
                "E4305",
                format!("builtin {} arg1 must be int", op),
            ))
        }
    };
    Ok((a, b))
}

fn bool2(args: &[Value], op: &str) -> Result<(bool, bool), VmError> {
    if args.len() != 2 {
        return Err(VmError::new(
            "E4305",
            format!("builtin {} expects 2 bool args", op),
        ));
    }
    let a = match args[0] {
        Value::Bool(v) => v,
        _ => {
            return Err(VmError::new(
                "E4305",
                format!("builtin {} arg0 must be bool", op),
            ))
        }
    };
    let b = match args[1] {
        Value::Bool(v) => v,
        _ => {
            return Err(VmError::new(
                "E4305",
                format!("builtin {} arg1 must be bool", op),
            ))
        }
    };
    Ok((a, b))
}

pub fn disassemble(bytecode: &Bytecode) -> String {
    let mut out = String::new();
    for (fn_idx, f) in bytecode.functions.iter().enumerate() {
        out.push_str(&format!(
            "fn[{fn_idx}] {} arity={} captures={}\n",
            f.name, f.arity, f.captures
        ));
        for (ip, ins) in f.code.iter().enumerate() {
            out.push_str(&format!("  {:04}: {}", ip, op_name(ins.op)));
            if let Some(arg) = &ins.arg {
                out.push_str(&format!(" arg={arg}"));
            }
            if let Some(argc) = ins.argc {
                out.push_str(&format!(" argc={argc}"));
            }
            if let Some(id) = ins.id {
                out.push_str(&format!(" id={id}"));
            }
            out.push('\n');
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use crate::bytecode::load_bytecode_from_str;

    use super::{run, Value, DEFAULT_FUEL};

    #[test]
    fn run_simple_add_program() {
        let src = r#"
{
  "format": "funk-bytecode-v1-json",
  "strings": [],
  "functions": [
    {
      "name": "add",
      "arity": 2,
      "captures": 0,
      "code": [
        {"op":"LOAD_LOCAL","arg":0},
        {"op":"LOAD_LOCAL","arg":1},
        {"op":"CALL_BUILTIN","id":20,"argc":2},
        {"op":"RETURN"}
      ]
    },
    {
      "name": "main",
      "arity": 0,
      "captures": 0,
      "code": [
        {"op":"PUSH_INT","arg":2},
        {"op":"PUSH_INT","arg":3},
        {"op":"CALL_FN","arg":0,"argc":2},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 1
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Int(5));
    }

    #[test]
    fn trap_returns_error() {
        let src = r#"
{
  "format": "funk-bytecode-v1-json",
  "strings": ["boom"],
  "functions": [
    {
      "name": "main",
      "arity": 0,
      "captures": 0,
      "code": [
        {"op":"TRAP","arg":0}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let err = run(&bc, DEFAULT_FUEL).expect_err("vm should trap");
        assert!(err.message.contains("boom"));
    }

    #[test]
    fn run_list_len_program() {
        let src = r#"
{
  "format": "funk-bytecode-v1-json",
  "strings": [],
  "functions": [
    {
      "name": "main",
      "arity": 0,
      "captures": 0,
      "code": [
        {"op":"PUSH_INT","arg":10},
        {"op":"PUSH_INT","arg":20},
        {"op":"PUSH_INT","arg":30},
        {"op":"MK_LIST","argc":3},
        {"op":"CALL_BUILTIN","id":36,"argc":1},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Int(3));
    }

    #[test]
    fn run_get_index_program() {
        let src = r#"
{
  "format": "funk-bytecode-v1-json",
  "strings": [],
  "functions": [
    {
      "name": "main",
      "arity": 0,
      "captures": 0,
      "code": [
        {"op":"PUSH_INT","arg":10},
        {"op":"PUSH_INT","arg":20},
        {"op":"PUSH_INT","arg":30},
        {"op":"MK_LIST","argc":3},
        {"op":"PUSH_INT","arg":1},
        {"op":"GET_INDEX"},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Int(20));
    }

    #[test]
    fn run_not_builtin_program() {
        let src = r#"
{
  "format": "funk-bytecode-v1-json",
  "strings": [],
  "functions": [
    {
      "name": "main",
      "arity": 0,
      "captures": 0,
      "code": [
        {"op":"PUSH_BOOL","arg":true},
        {"op":"CALL_BUILTIN","id":33,"argc":1},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Bool(false));
    }

    #[test]
    fn run_abs_builtin_program() {
        let src = r#"
{
  "format": "funk-bytecode-v1-json",
  "strings": [],
  "functions": [
    {
      "name": "main",
      "arity": 0,
      "captures": 0,
      "code": [
        {"op":"PUSH_INT","arg":-9},
        {"op":"CALL_BUILTIN","id":37,"argc":1},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Int(9));
    }
}
