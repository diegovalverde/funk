use std::fmt;
use std::fs;
use std::io::{self, Write};
use std::rc::Rc;
use std::collections::HashMap;

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
    List(Rc<Vec<Value>>),
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
    let mut host = StdoutHost {};
    run_with_host(bytecode, fuel, &mut host)
}

pub trait VmHost {
    fn write(&mut self, text: &str) -> Result<(), VmError>;
    fn writeln(&mut self, text: &str) -> Result<(), VmError>;
    fn call_host(&mut self, name: &str, _args: &[Value]) -> Result<Value, VmError> {
        Err(VmError::new(
            "E_EFFECT",
            format!("disallowed host effect: '{}'", name),
        ))
    }
}

struct StdoutHost {}

impl VmHost for StdoutHost {
    fn write(&mut self, text: &str) -> Result<(), VmError> {
        print!("{text}");
        io::stdout()
            .flush()
            .map_err(|e| VmError::new("E4305", format!("print flush failed: {e}")))?;
        Ok(())
    }

    fn writeln(&mut self, text: &str) -> Result<(), VmError> {
        println!("{text}");
        Ok(())
    }
}

pub fn run_with_host<H: VmHost>(
    bytecode: &Bytecode,
    fuel: u64,
    host: &mut H,
) -> Result<VmResult, VmError> {
    bytecode.validate()?;
    let mut function_lookup: HashMap<(String, usize), usize> = HashMap::new();
    for (idx, f) in bytecode.functions.iter().enumerate() {
        if let Some((name, arity)) = parse_function_signature(&f.name) {
            function_lookup.insert((name, arity), idx);
        }
    }
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
                let args_start = stack.len() - argc;
                let result = call_builtin(id, &stack[args_start..], host)?;
                stack.truncate(args_start);
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
                let args_start = stack.len() - argc;
                let tail_pos = frame.ip < func.code.len() && matches!(func.code[frame.ip].op, OpCode::Return);
                if tail_pos {
                    frame.locals.clear();
                    frame.locals.extend(stack.drain(args_start..));
                    frame.fn_id = target_fn;
                    frame.ip = 0;
                } else {
                    let mut args = Vec::with_capacity(argc);
                    args.extend(stack.drain(args_start..));
                    frames.push(Frame {
                        fn_id: target_fn,
                        ip: 0,
                        locals: args,
                    });
                }
            }
            OpCode::CallIndirect => {
                let argc = ins
                    .argc
                    .ok_or_else(|| VmError::new("E4305", "CALL_INDIRECT missing argc"))?
                    as usize;
                if stack.len() < argc + 1 {
                    return Err(VmError::new("E4304", "stack underflow in CALL_INDIRECT"));
                }
                let callee_idx = stack.len() - argc - 1;
                let args_start = callee_idx + 1;
                let callee = stack[callee_idx].clone();
                let callee_name = match callee {
                    Value::String(s) => s,
                    _ => return Err(VmError::new("E4305", "CALL_INDIRECT expects string callee")),
                };
                let target_fn = function_lookup
                    .get(&(callee_name.clone(), argc))
                    .ok_or_else(|| {
                        VmError::new(
                            "E4303",
                            format!("CALL_INDIRECT unresolved target '{}/{}'", callee_name, argc),
                        )
                    })?;
                let tail_pos = frame.ip < func.code.len() && matches!(func.code[frame.ip].op, OpCode::Return);
                if tail_pos {
                    frame.locals.clear();
                    frame.locals.extend(stack.drain(args_start..));
                    stack.truncate(callee_idx);
                    frame.fn_id = *target_fn;
                    frame.ip = 0;
                } else {
                    let mut args = Vec::with_capacity(argc);
                    args.extend(stack.drain(args_start..));
                    stack.truncate(callee_idx);
                    frames.push(Frame {
                        fn_id: *target_fn,
                        ip: 0,
                        locals: args,
                    });
                }
            }
            OpCode::CallHost => {
                let host_name_idx = require_u32_arg(ins, "CALL_HOST")? as usize;
                let argc = ins
                    .argc
                    .ok_or_else(|| VmError::new("E4305", "CALL_HOST missing argc"))?
                    as usize;
                let host_name = bytecode.strings.get(host_name_idx).ok_or_else(|| {
                    VmError::new(
                        "E4303",
                        format!("CALL_HOST string index {} out of bounds", host_name_idx),
                    )
                })?;
                if stack.len() < argc {
                    return Err(VmError::new("E4304", "stack underflow in CALL_HOST"));
                }
                let args_start = stack.len() - argc;
                let result = host.call_host(host_name, &stack[args_start..])?;
                stack.truncate(args_start);
                stack.push(result);
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
                stack.push(Value::List(Rc::new(items)));
            }
            OpCode::GetIndex => {
                let idx_val = stack
                    .pop()
                    .ok_or_else(|| VmError::new("E4304", "stack underflow in GET_INDEX"))?;
                let list_val = stack
                    .pop()
                    .ok_or_else(|| VmError::new("E4304", "stack underflow in GET_INDEX"))?;
                match list_val {
                    Value::List(items) => {
                        if items.is_empty() {
                            return Err(VmError::new("E4303", "GET_INDEX list index out of bounds"));
                        }
                        let idx = match idx_val {
                            Value::Int(v) => normalize_index(v, items.len()),
                            _ => return Err(VmError::new("E4305", "GET_INDEX expects integer index")),
                        };
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
                    Value::List(items) => deep_len(&items) as i64,
                    Value::String(s) => s.chars().count() as i64,
                    _ => 1,
                };
                stack.push(Value::Int(len));
            }
        }
    }

    Err(VmError::new("E4302", "program terminated without RETURN"))
}

fn call_builtin<H: VmHost>(id: u8, args: &[Value], host: &mut H) -> Result<Value, VmError> {
    match id {
        1 => {
            let mut out = String::new();
            for arg in args {
                out.push_str(&render_value(arg));
            }
            host.write(&out)?;
            Ok(Value::Unit)
        }
        2 => {
            if args.is_empty() {
                host.writeln("")?;
                return Ok(Value::Unit);
            }
            let mut out = String::new();
            for (i, arg) in args.iter().enumerate() {
                if i > 0 {
                    out.push(' ');
                }
                out.push_str(&render_value(arg));
            }
            host.writeln(&out)?;
            Ok(Value::Unit)
        }
        3 => {
            if args.len() > 1 {
                return Err(VmError::new("E4305", "exit expects zero or one argument"));
            }
            let code = if args.len() == 1 {
                match args[0] {
                    Value::Int(v) => v,
                    _ => return Err(VmError::new("E4305", "exit arg must be int")),
                }
            } else {
                1
            };
            Err(VmError::new("E4306", format!("exit({code})")))
        }
        20 => {
            if args.len() != 2 {
                return Err(VmError::new("E4305", "builtin + expects 2 args"));
            }
            add_values(&args[0], &args[1])
        }
        21 => {
            if args.len() != 2 {
                return Err(VmError::new("E4305", "builtin - expects 2 args"));
            }
            sub_values(&args[0], &args[1])
        }
        22 => {
            if args.len() != 2 {
                return Err(VmError::new("E4305", "builtin * expects 2 args"));
            }
            mul_values(&args[0], &args[1])
        }
        23 => {
            if args.len() != 2 {
                return Err(VmError::new("E4305", "builtin / expects 2 args"));
            }
            div_values(&args[0], &args[1])
        }
        24 => {
            if args.len() != 2 {
                return Err(VmError::new("E4305", "builtin % expects 2 args"));
            }
            mod_values(&args[0], &args[1])
        }
        25 => cmp_eq(args, true),
        26 => cmp_eq(args, false),
        27 => cmp_num(args, |a, b| a < b, "<"),
        28 => cmp_num(args, |a, b| a <= b, "<="),
        29 => cmp_num(args, |a, b| a > b, ">"),
        30 => cmp_num(args, |a, b| a >= b, ">="),
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
                return Err(VmError::new("E4305", "neg expects one arg"));
            }
            neg_value(&args[0])
        }
        35 => {
            if !args.is_empty() {
                return Err(VmError::new("E4305", "infinity expects no args"));
            }
            Ok(Value::Int(i32::MAX as i64))
        }
        36 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "len expects one arg"));
            }
            let len = match &args[0] {
                Value::List(items) => deep_len(items) as i64,
                Value::String(s) => s.chars().count() as i64,
                _ => 1,
            };
            Ok(Value::Int(len))
        }
        37 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "abs expects one numeric arg"));
            }
            abs_value(&args[0])
        }
        38 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "sum expects one list arg"));
            }
            let mut int_acc: i64 = 0;
            let mut float_acc: f64 = 0.0;
            let mut is_float = false;
            sum_recursive(&args[0], &mut int_acc, &mut float_acc, &mut is_float)?;
            if is_float {
                Ok(Value::Float(float_acc))
            } else {
                Ok(Value::Int(int_acc))
            }
        }
        39 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "flatten expects one list arg"));
            }
            let items = match &args[0] {
                Value::List(items) => items,
                _ => return Err(VmError::new("E4305", "flatten expects list arg")),
            };
            let mut out = Vec::new();
            flatten_values(items, &mut out);
            Ok(Value::List(Rc::new(out)))
        }
        41 => {
            if args.len() != 2 {
                return Err(VmError::new("E4305", "concat expects 2 args"));
            }
            let right_len = match &args[1] {
                Value::List(items) => items.len(),
                _ => 1,
            };
            let mut out = Vec::with_capacity(1 + right_len);
            out.push(args[0].clone());
            match &args[1] {
                Value::List(items) => out.extend(items.iter().cloned()),
                other => out.push(other.clone()),
            }
            Ok(Value::List(Rc::new(out)))
        }
        42 => {
            if args.len() != 2 {
                return Err(VmError::new("E4305", "list union expects 2 args"));
            }
            let left_len = match &args[0] {
                Value::List(items) => items.len(),
                _ => 1,
            };
            let right_len = match &args[1] {
                Value::List(items) => items.len(),
                _ => 1,
            };
            let mut out = Vec::with_capacity(left_len + right_len);
            match &args[0] {
                Value::List(items) => out.extend(items.iter().cloned()),
                other => out.push(other.clone()),
            }
            match &args[1] {
                Value::List(items) => out.extend(items.iter().cloned()),
                other => out.push(other.clone()),
            }
            Ok(Value::List(Rc::new(out)))
        }
        43 => {
            if args.len() != 2 {
                return Err(VmError::new("E4305", "list concat tail expects 2 args"));
            }
            let left = spread_list(&args[0], "list concat tail arg0")?;
            let mut out = left.to_vec();
            out.push(args[1].clone());
            Ok(Value::List(Rc::new(out)))
        }
        44 => {
            let (left, right) = spread_list2(args, "difference")?;
            let mut out = Vec::new();
            for item in left {
                if !right.contains(item) {
                    out.push(item.clone());
                }
            }
            Ok(Value::List(Rc::new(out)))
        }
        45 => {
            if args.len() != 3 {
                return Err(VmError::new("E4305", "reshape expects 3 args"));
            }
            let items = match &args[0] {
                Value::List(items) => items,
                _ => return Err(VmError::new("E4305", "reshape arg0 must be list")),
            };
            let rows = match args[1] {
                Value::Int(v) if v >= 0 => v as usize,
                _ => return Err(VmError::new("E4305", "reshape arg1 must be non-negative int")),
            };
            let cols = match args[2] {
                Value::Int(v) if v >= 0 => v as usize,
                _ => return Err(VmError::new("E4305", "reshape arg2 must be non-negative int")),
            };
            if rows == 0 || cols == 0 || rows * cols != items.len() {
                return Ok(Value::List(items.clone()));
            }
            let mut out = Vec::with_capacity(rows);
            for i in 0..rows {
                let start = i * cols;
                let end = start + cols;
                out.push(Value::List(Rc::new(items[start..end].to_vec())));
            }
            Ok(Value::List(Rc::new(out)))
        }
        47 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "is_list expects one arg"));
            }
            Ok(Value::Bool(matches!(args[0], Value::List(_))))
        }
        48 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "tail expects one list arg"));
            }
            let items = match &args[0] {
                Value::List(items) => items,
                _ => return Err(VmError::new("E4305", "tail arg must be list")),
            };
            if items.len() <= 1 {
                Ok(Value::List(Rc::new(Vec::new())))
            } else {
                Ok(Value::List(Rc::new(items[1..].to_vec())))
            }
        }
        49 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "list_size expects one list arg"));
            }
            let items = match &args[0] {
                Value::List(items) => items,
                _ => return Err(VmError::new("E4305", "list_size arg must be list")),
            };
            Ok(Value::Int(items.len() as i64))
        }
        46 => {
            if args.len() != 1 {
                return Err(VmError::new("E4305", "fread_list expects one string path arg"));
            }
            let path = match &args[0] {
                Value::String(s) => s,
                _ => return Err(VmError::new("E4305", "fread_list arg must be string path")),
            };
            let content = match fs::read_to_string(path) {
                Ok(v) => v,
                Err(_) => {
                    let alt = format!("../{}", path);
                    fs::read_to_string(&alt).map_err(|e| {
                        VmError::new(
                            "E4305",
                            format!("fread_list failed reading '{}' or '{}': {e}", path, alt),
                        )
                    })?
                }
            };
            let mut out = Vec::new();
            for tok in content.split_whitespace() {
                let n = tok.parse::<i64>().map_err(|e| {
                    VmError::new(
                        "E4305",
                        format!("fread_list token '{}' is not an integer: {e}", tok),
                    )
                })?;
                out.push(Value::Int(n));
            }
            Ok(Value::List(Rc::new(out)))
        }
        40 => {
            if args.len() != 3 {
                return Err(VmError::new("E4305", "slice expects (list, start, end)"));
            }
            let items = match &args[0] {
                Value::List(items) => items,
                _ => return Err(VmError::new("E4305", "slice arg0 expects list")),
            };
            if items.is_empty() {
                return Ok(Value::List(Rc::new(Vec::new())));
            }
            let start = match args[1] {
                Value::Int(v) => normalize_index(v, items.len()),
                _ => return Err(VmError::new("E4305", "slice arg1 expects int")),
            };
            let end = match args[2] {
                Value::Int(v) => normalize_index(v, items.len()),
                _ => return Err(VmError::new("E4305", "slice arg2 expects int")),
            };
            if end < start {
                return Ok(Value::List(Rc::new(Vec::new())));
            }
            Ok(Value::List(Rc::new(items[start..=end].to_vec())))
        }
        _ => Err(VmError::new(
            "E4305",
            format!("unsupported builtin id {}", id),
        )),
    }
}

fn normalize_index(raw: i64, len: usize) -> usize {
    if raw >= 0 {
        return (raw as usize) % len;
    }
    let len_i64 = len as i64;
    raw.rem_euclid(len_i64) as usize
}

fn parse_function_signature(name: &str) -> Option<(String, usize)> {
    let (base, arity_raw) = name.rsplit_once('#')?;
    let arity = arity_raw.parse::<usize>().ok()?;
    Some((base.to_string(), arity))
}

fn flatten_values(items: &[Value], out: &mut Vec<Value>) {
    for item in items {
        match item {
            Value::List(nested) => flatten_values(nested, out),
            _ => out.push(item.clone()),
        }
    }
}

fn deep_len(items: &[Value]) -> usize {
    let mut total = 0usize;
    for item in items {
        match item {
            Value::List(nested) => {
                total += deep_len(nested);
            }
            _ => total += 1,
        }
    }
    total
}

fn sum_recursive(
    value: &Value,
    int_acc: &mut i64,
    float_acc: &mut f64,
    is_float: &mut bool,
) -> Result<(), VmError> {
    match value {
        Value::List(items) => {
            for item in items.iter() {
                sum_recursive(item, int_acc, float_acc, is_float)?;
            }
            Ok(())
        }
        Value::Int(v) => {
            if *is_float {
                *float_acc += *v as f64;
            } else {
                *int_acc = int_acc
                    .checked_add(*v)
                    .ok_or_else(|| VmError::new("E4305", "integer overflow in sum"))?;
            }
            Ok(())
        }
        Value::Float(v) => {
            if !*is_float {
                *float_acc = *int_acc as f64;
                *is_float = true;
            }
            *float_acc += *v;
            Ok(())
        }
        _ => Err(VmError::new("E4305", "sum expects numeric/list elements")),
    }
}

fn neg_value(value: &Value) -> Result<Value, VmError> {
    match value {
        Value::Int(v) => Ok(Value::Int(if *v == 0 { 1 } else { 0 })),
        Value::Float(v) => Ok(Value::Int(if *v == 0.0 { 1 } else { 0 })),
        Value::Bool(v) => Ok(Value::Int(if *v { 0 } else { 1 })),
        Value::List(items) => {
            let mut out = Vec::with_capacity(items.len());
            for item in items.iter() {
                out.push(neg_value(item)?);
            }
            Ok(Value::List(Rc::new(out)))
        }
        _ => Err(VmError::new("E4305", "neg expects numeric/bool/list arg")),
    }
}

fn abs_value(value: &Value) -> Result<Value, VmError> {
    match value {
        Value::Int(v) => v
            .checked_abs()
            .map(Value::Int)
            .ok_or_else(|| VmError::new("E4305", "integer overflow in abs")),
        Value::Float(v) => Ok(Value::Float(v.abs())),
        Value::List(items) => {
            let mut out = Vec::with_capacity(items.len());
            for item in items.iter() {
                out.push(abs_value(item)?);
            }
            Ok(Value::List(Rc::new(out)))
        }
        _ => Err(VmError::new("E4305", "abs expects int or float arg")),
    }
}

fn add_values(a: &Value, b: &Value) -> Result<Value, VmError> {
    map_numeric2(a, b, "+", |x, y| x.checked_add(y), |x, y| x + y)
}

fn sub_values(a: &Value, b: &Value) -> Result<Value, VmError> {
    map_numeric2(a, b, "-", |x, y| x.checked_sub(y), |x, y| x - y)
}

fn mul_values(a: &Value, b: &Value) -> Result<Value, VmError> {
    map_numeric2(a, b, "*", |x, y| x.checked_mul(y), |x, y| x * y)
}

fn div_values(a: &Value, b: &Value) -> Result<Value, VmError> {
    map_numeric2(
        a,
        b,
        "/",
        |x, y| if y == 0 { None } else { x.checked_div(y) },
        |x, y| x / y,
    )
}

fn mod_values(a: &Value, b: &Value) -> Result<Value, VmError> {
    match (a, b) {
        (Value::List(_), _) | (_, Value::List(_)) => map_list2(a, b, mod_values),
        _ => {
            let pair = num_pair(a, b, "%")?;
            match pair {
                NumPair::Int(x, y) => {
                    if y == 0 {
                        return Err(VmError::new("E4305", "division by zero"));
                    }
                    x.checked_rem(y)
                        .map(Value::Int)
                        .ok_or_else(|| VmError::new("E4305", "integer overflow in %"))
                }
                NumPair::Float(_, _) => Err(VmError::new("E4305", "builtin % expects integer args")),
            }
        }
    }
}

fn map_numeric2(
    a: &Value,
    b: &Value,
    op: &str,
    int_op: fn(i64, i64) -> Option<i64>,
    float_op: fn(f64, f64) -> f64,
) -> Result<Value, VmError> {
    match (a, b) {
        (Value::List(_), _) | (_, Value::List(_)) => map_list2(a, b, |x, y| {
            map_numeric2(x, y, op, int_op, float_op)
        }),
        _ => match num_pair(a, b, op)? {
            NumPair::Int(x, y) => int_op(x, y)
                .map(Value::Int)
                .ok_or_else(|| VmError::new("E4305", format!("integer overflow in {}", op))),
            NumPair::Float(x, y) => {
                if op == "/" && y == 0.0 {
                    return Err(VmError::new("E4305", "division by zero"));
                }
                Ok(Value::Float(float_op(x, y)))
            }
        },
    }
}

fn map_list2<F>(a: &Value, b: &Value, f: F) -> Result<Value, VmError>
where
    F: Fn(&Value, &Value) -> Result<Value, VmError> + Copy,
{
    match (a, b) {
        (Value::List(lhs), Value::List(rhs)) => {
            if lhs.len() != rhs.len() {
                return Err(VmError::new("E4305", "list sizes must match for elementwise operation"));
            }
            let mut out = Vec::with_capacity(lhs.len());
            for i in 0..lhs.len() {
                out.push(f(&lhs[i], &rhs[i])?);
            }
            Ok(Value::List(Rc::new(out)))
        }
        (Value::List(lhs), scalar) => {
            let mut out = Vec::with_capacity(lhs.len());
            for item in lhs.iter() {
                out.push(f(item, scalar)?);
            }
            Ok(Value::List(Rc::new(out)))
        }
        (scalar, Value::List(rhs)) => {
            let mut out = Vec::with_capacity(rhs.len());
            for item in rhs.iter() {
                out.push(f(scalar, item)?);
            }
            Ok(Value::List(Rc::new(out)))
        }
        _ => Err(VmError::new("E4305", "internal map_list2 misuse")),
    }
}

fn list2<'a>(args: &'a [Value], op: &str) -> Result<(&'a [Value], &'a [Value]), VmError> {
    if args.len() != 2 {
        return Err(VmError::new(
            "E4305",
            format!("builtin {} expects 2 list args", op),
        ));
    }
    let left = match &args[0] {
        Value::List(items) => items,
        _ => return Err(VmError::new("E4305", format!("builtin {} arg0 must be list", op))),
    };
    let right = match &args[1] {
        Value::List(items) => items,
        _ => return Err(VmError::new("E4305", format!("builtin {} arg1 must be list", op))),
    };
    Ok((left, right))
}

fn spread_list<'a>(value: &'a Value, arg_name: &str) -> Result<&'a [Value], VmError> {
    let items = match value {
        Value::List(items) => items.as_slice(),
        _ => return Err(VmError::new("E4305", format!("{} must be list", arg_name))),
    };
    if items.len() == 1 {
        if let Value::List(inner) = &items[0] {
            return Ok(inner.as_slice());
        }
    }
    Ok(items)
}

fn spread_list2<'a>(args: &'a [Value], op: &str) -> Result<(&'a [Value], &'a [Value]), VmError> {
    if args.len() != 2 {
        return Err(VmError::new(
            "E4305",
            format!("builtin {} expects 2 list args", op),
        ));
    }
    Ok((
        spread_list(&args[0], &format!("{} arg0", op))?,
        spread_list(&args[1], &format!("{} arg1", op))?,
    ))
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

fn cmp_num(args: &[Value], f: fn(f64, f64) -> bool, op: &str) -> Result<Value, VmError> {
    match num2(args, op)? {
        NumPair::Int(a, b) => Ok(Value::Bool(f(a as f64, b as f64))),
        NumPair::Float(a, b) => Ok(Value::Bool(f(a, b))),
    }
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

enum NumPair {
    Int(i64, i64),
    Float(f64, f64),
}

fn num2(args: &[Value], op: &str) -> Result<NumPair, VmError> {
    if args.len() != 2 {
        return Err(VmError::new(
            "E4305",
            format!("builtin {} expects 2 numeric args", op),
        ));
    }
    num_pair(&args[0], &args[1], op)
}

fn num_pair(a: &Value, b: &Value, op: &str) -> Result<NumPair, VmError> {
    match (a, b) {
        (Value::Int(a), Value::Int(b)) => Ok(NumPair::Int(*a, *b)),
        (Value::Int(a), Value::Float(b)) => Ok(NumPair::Float(*a as f64, *b)),
        (Value::Float(a), Value::Int(b)) => Ok(NumPair::Float(*a, *b as f64)),
        (Value::Float(a), Value::Float(b)) => Ok(NumPair::Float(*a, *b)),
        _ => Err(VmError::new(
            "E4305",
            format!("builtin {} expects numeric args", op),
        )),
    }
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

    #[test]
    fn run_mixed_numeric_arithmetic_program() {
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
        {"op":"PUSH_FLOAT","arg":2.5},
        {"op":"PUSH_INT","arg":2},
        {"op":"CALL_BUILTIN","id":20,"argc":2},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Float(4.5));
    }

    #[test]
    fn run_mixed_numeric_compare_program() {
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
        {"op":"PUSH_FLOAT","arg":2.5},
        {"op":"PUSH_INT","arg":2},
        {"op":"CALL_BUILTIN","id":29,"argc":2},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Bool(true));
    }

    #[test]
    fn run_sum_builtin_int_list_program() {
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
        {"op":"PUSH_INT","arg":1},
        {"op":"PUSH_INT","arg":2},
        {"op":"PUSH_INT","arg":3},
        {"op":"MK_LIST","argc":3},
        {"op":"CALL_BUILTIN","id":38,"argc":1},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Int(6));
    }

    #[test]
    fn run_sum_builtin_mixed_list_program() {
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
        {"op":"PUSH_INT","arg":1},
        {"op":"PUSH_FLOAT","arg":2.5},
        {"op":"PUSH_INT","arg":3},
        {"op":"MK_LIST","argc":3},
        {"op":"CALL_BUILTIN","id":38,"argc":1},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Float(6.5));
    }

    #[test]
    fn run_flatten_builtin_program() {
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
        {"op":"PUSH_INT","arg":1},
        {"op":"MK_LIST","argc":1},
        {"op":"PUSH_INT","arg":2},
        {"op":"PUSH_INT","arg":3},
        {"op":"MK_LIST","argc":1},
        {"op":"MK_LIST","argc":2},
        {"op":"MK_LIST","argc":2},
        {"op":"CALL_BUILTIN","id":39,"argc":1},
        {"op":"LEN"},
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
    fn run_slice_builtin_program() {
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
        {"op":"PUSH_INT","arg":0},
        {"op":"PUSH_INT","arg":1},
        {"op":"CALL_BUILTIN","id":40,"argc":3},
        {"op":"LEN"},
        {"op":"RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
"#;
        let bc = load_bytecode_from_str(src).expect("bytecode parse");
        let result = run(&bc, DEFAULT_FUEL).expect("vm run");
        assert_eq!(result.return_value, Value::Int(2));
    }

    #[test]
    fn run_slice_builtin_negative_indices_program() {
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
        {"op":"PUSH_INT","arg":-2},
        {"op":"PUSH_INT","arg":-1},
        {"op":"CALL_BUILTIN","id":40,"argc":3},
        {"op":"PUSH_INT","arg":0},
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
}
