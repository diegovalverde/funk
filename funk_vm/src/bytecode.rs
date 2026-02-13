use std::fmt;
use std::fs;
use std::path::Path;

use serde::Deserialize;
use serde_json::Value as JsonValue;

pub const FORMAT_V1_JSON: &str = "funk-bytecode-v1-json";

#[derive(Debug, Clone)]
pub struct BytecodeError {
    pub code: &'static str,
    pub message: String,
}

impl BytecodeError {
    pub fn new(code: &'static str, message: impl Into<String>) -> Self {
        Self {
            code,
            message: message.into(),
        }
    }
}

impl fmt::Display for BytecodeError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}: {}", self.code, self.message)
    }
}

impl std::error::Error for BytecodeError {}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub enum OpCode {
    PushInt,
    PushFloat,
    PushBool,
    PushString,
    PushUnit,
    LoadLocal,
    StoreLocal,
    Pop,
    Jump,
    JumpIfFalse,
    CallBuiltin,
    CallFn,
    CallIndirect,
    Return,
    Trap,
    MkList,
    GetIndex,
    Len,
}

#[derive(Debug, Clone, Deserialize)]
#[serde(deny_unknown_fields)]
pub struct Instruction {
    pub op: OpCode,
    #[serde(default)]
    pub arg: Option<JsonValue>,
    #[serde(default)]
    pub argc: Option<u8>,
    #[serde(default)]
    pub id: Option<u8>,
}

#[derive(Debug, Clone, Deserialize)]
#[serde(deny_unknown_fields)]
pub struct FunctionBytecode {
    pub name: String,
    pub arity: u32,
    pub captures: u32,
    pub code: Vec<Instruction>,
}

#[derive(Debug, Clone, Deserialize)]
#[serde(deny_unknown_fields)]
pub struct Bytecode {
    pub format: String,
    pub strings: Vec<String>,
    pub functions: Vec<FunctionBytecode>,
    pub entry_fn: u32,
}

impl Bytecode {
    pub fn validate(&self) -> Result<(), BytecodeError> {
        if self.format != FORMAT_V1_JSON {
            return Err(BytecodeError::new(
                "E4201",
                format!("unsupported bytecode format '{}'", self.format),
            ));
        }
        if self.functions.is_empty() {
            return Err(BytecodeError::new("E4202", "functions must be non-empty"));
        }
        if self.entry_fn as usize >= self.functions.len() {
            return Err(BytecodeError::new("E4204", "entry_fn is out of bounds"));
        }
        for (fn_idx, f) in self.functions.iter().enumerate() {
            if f.name.is_empty() {
                return Err(BytecodeError::new(
                    "E4202",
                    format!("function[{fn_idx}] name must be non-empty"),
                ));
            }
            for (ip, ins) in f.code.iter().enumerate() {
                validate_instruction(ins, self, f, fn_idx, ip)?;
            }
        }
        Ok(())
    }
}

pub fn load_bytecode_from_str(src: &str) -> Result<Bytecode, BytecodeError> {
    let bytecode = serde_json::from_str::<Bytecode>(src)
        .map_err(|e| BytecodeError::new("E4201", format!("invalid JSON container: {e}")))?;
    bytecode.validate()?;
    Ok(bytecode)
}

pub fn load_bytecode_from_path(path: &Path) -> Result<Bytecode, BytecodeError> {
    let text = fs::read_to_string(path).map_err(|e| {
        BytecodeError::new(
            "E4201",
            format!("failed reading bytecode file '{}': {e}", path.display()),
        )
    })?;
    load_bytecode_from_str(&text)
}

fn validate_instruction(
    ins: &Instruction,
    bytecode: &Bytecode,
    f: &FunctionBytecode,
    fn_idx: usize,
    ip: usize,
) -> Result<(), BytecodeError> {
    match ins.op {
        OpCode::PushUnit | OpCode::Pop | OpCode::Return | OpCode::GetIndex | OpCode::Len => {}
        OpCode::PushInt => {
            require_i64_arg(ins, "PUSH_INT")?;
        }
        OpCode::PushFloat => {
            require_f64_arg(ins, "PUSH_FLOAT")?;
        }
        OpCode::PushBool => {
            require_bool_arg(ins, "PUSH_BOOL")?;
        }
        OpCode::PushString | OpCode::Trap => {
            let idx = require_u32_arg(ins, op_name(ins.op))?;
            if idx as usize >= bytecode.strings.len() {
                return Err(BytecodeError::new(
                    "E4204",
                    format!(
                        "{} string index out of bounds at function {}, ip {}",
                        op_name(ins.op),
                        fn_idx,
                        ip
                    ),
                ));
            }
        }
        OpCode::LoadLocal | OpCode::StoreLocal => {
            require_u32_arg(ins, op_name(ins.op))?;
        }
        OpCode::Jump | OpCode::JumpIfFalse => {
            let target = require_u32_arg(ins, op_name(ins.op))?;
            if target as usize > f.code.len() {
                return Err(BytecodeError::new(
                    "E4205",
                    format!(
                        "{} jump target out of bounds at function {}, ip {}",
                        op_name(ins.op),
                        fn_idx,
                        ip
                    ),
                ));
            }
        }
        OpCode::CallBuiltin => {
            if ins.id.is_none() || ins.argc.is_none() {
                return Err(BytecodeError::new(
                    "E4202",
                    format!("CALL_BUILTIN missing id/argc at function {}, ip {}", fn_idx, ip),
                ));
            }
        }
        OpCode::CallFn => {
            let target = require_u32_arg(ins, "CALL_FN")?;
            if target as usize >= bytecode.functions.len() {
                return Err(BytecodeError::new(
                    "E4204",
                    format!("CALL_FN function index out of bounds at function {}, ip {}", fn_idx, ip),
                ));
            }
            if ins.argc.is_none() {
                return Err(BytecodeError::new(
                    "E4202",
                    format!("CALL_FN missing argc at function {}, ip {}", fn_idx, ip),
                ));
            }
        }
        OpCode::CallIndirect => {
            if ins.argc.is_none() {
                return Err(BytecodeError::new(
                    "E4202",
                    format!("CALL_INDIRECT missing argc at function {}, ip {}", fn_idx, ip),
                ));
            }
        }
        OpCode::MkList => {
            if ins.argc.is_none() {
                return Err(BytecodeError::new(
                    "E4202",
                    format!("MK_LIST missing argc at function {}, ip {}", fn_idx, ip),
                ));
            }
        }
    }
    Ok(())
}

pub fn require_i64_arg(ins: &Instruction, op: &str) -> Result<i64, BytecodeError> {
    let arg = ins
        .arg
        .as_ref()
        .ok_or_else(|| BytecodeError::new("E4202", format!("{op} missing arg")))?;
    arg.as_i64()
        .ok_or_else(|| BytecodeError::new("E4202", format!("{op} expects integer arg")))
}

pub fn require_f64_arg(ins: &Instruction, op: &str) -> Result<f64, BytecodeError> {
    let arg = ins
        .arg
        .as_ref()
        .ok_or_else(|| BytecodeError::new("E4202", format!("{op} missing arg")))?;
    arg.as_f64()
        .ok_or_else(|| BytecodeError::new("E4202", format!("{op} expects numeric arg")))
}

pub fn require_bool_arg(ins: &Instruction, op: &str) -> Result<bool, BytecodeError> {
    let arg = ins
        .arg
        .as_ref()
        .ok_or_else(|| BytecodeError::new("E4202", format!("{op} missing arg")))?;
    arg.as_bool()
        .ok_or_else(|| BytecodeError::new("E4202", format!("{op} expects bool arg")))
}

pub fn require_u32_arg(ins: &Instruction, op: &str) -> Result<u32, BytecodeError> {
    let arg = ins
        .arg
        .as_ref()
        .ok_or_else(|| BytecodeError::new("E4202", format!("{op} missing arg")))?;
    let raw = arg
        .as_u64()
        .ok_or_else(|| BytecodeError::new("E4202", format!("{op} expects non-negative integer arg")))?;
    u32::try_from(raw)
        .map_err(|_| BytecodeError::new("E4202", format!("{op} arg out of range for u32")))
}

pub fn op_name(op: OpCode) -> &'static str {
    match op {
        OpCode::PushInt => "PUSH_INT",
        OpCode::PushFloat => "PUSH_FLOAT",
        OpCode::PushBool => "PUSH_BOOL",
        OpCode::PushString => "PUSH_STRING",
        OpCode::PushUnit => "PUSH_UNIT",
        OpCode::LoadLocal => "LOAD_LOCAL",
        OpCode::StoreLocal => "STORE_LOCAL",
        OpCode::Pop => "POP",
        OpCode::Jump => "JUMP",
        OpCode::JumpIfFalse => "JUMP_IF_FALSE",
        OpCode::CallBuiltin => "CALL_BUILTIN",
        OpCode::CallFn => "CALL_FN",
        OpCode::CallIndirect => "CALL_INDIRECT",
        OpCode::Return => "RETURN",
        OpCode::Trap => "TRAP",
        OpCode::MkList => "MK_LIST",
        OpCode::GetIndex => "GET_INDEX",
        OpCode::Len => "LEN",
    }
}
