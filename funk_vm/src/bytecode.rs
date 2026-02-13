use std::fmt;
use std::fs;
use std::path::Path;

use serde::Deserialize;
use serde_json::{Number as JsonNumber, Value as JsonValue};

pub const FORMAT_V1_JSON: &str = "funk-bytecode-v1-json";
const BINARY_MAGIC: &[u8; 4] = b"FKB1";

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
    let raw = fs::read(path).map_err(|e| {
        BytecodeError::new(
            "E4201",
            format!("failed reading bytecode file '{}': {e}", path.display()),
        )
    })?;
    load_bytecode_from_bytes(&raw)
}

pub fn load_bytecode_from_bytes(raw: &[u8]) -> Result<Bytecode, BytecodeError> {
    if raw.len() >= 4 && &raw[0..4] == BINARY_MAGIC {
        return decode_binary(raw);
    }
    let text = std::str::from_utf8(raw)
        .map_err(|e| BytecodeError::new("E4201", format!("bytecode is not valid UTF-8 JSON: {e}")))?;
    load_bytecode_from_str(text)
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

fn decode_binary(raw: &[u8]) -> Result<Bytecode, BytecodeError> {
    let mut c = BinaryCursor::new(raw);
    c.expect_magic(BINARY_MAGIC)?;

    let strings_len = c.read_u32()? as usize;
    let mut strings = Vec::with_capacity(strings_len);
    for _ in 0..strings_len {
        strings.push(c.read_string()?);
    }

    let fn_len = c.read_u32()? as usize;
    let mut functions = Vec::with_capacity(fn_len);
    for _ in 0..fn_len {
        let name = c.read_string()?;
        let arity = c.read_u32()?;
        let captures = c.read_u32()?;
        let code_len = c.read_u32()? as usize;
        let mut code = Vec::with_capacity(code_len);
        for _ in 0..code_len {
            let op = decode_op(c.read_u8()?)?;
            let arg_kind = c.read_u8()?;
            let arg = match arg_kind {
                0 => None,
                1 => Some(JsonValue::from(c.read_i64()?)),
                2 => {
                    let v = c.read_f64()?;
                    let num = JsonNumber::from_f64(v).ok_or_else(|| {
                        BytecodeError::new("E4201", "invalid binary float payload")
                    })?;
                    Some(JsonValue::Number(num))
                }
                3 => Some(JsonValue::Bool(c.read_u8()? != 0)),
                other => {
                    return Err(BytecodeError::new(
                        "E4201",
                        format!("unknown binary arg kind {}", other),
                    ))
                }
            };
            let argc_raw = c.read_u8()?;
            let id_raw = c.read_u8()?;
            code.push(Instruction {
                op,
                arg,
                argc: if argc_raw == u8::MAX { None } else { Some(argc_raw) },
                id: if id_raw == u8::MAX { None } else { Some(id_raw) },
            });
        }
        functions.push(FunctionBytecode {
            name,
            arity,
            captures,
            code,
        });
    }

    let entry_fn = c.read_u32()?;
    if c.remaining() != 0 {
        return Err(BytecodeError::new(
            "E4201",
            format!("binary payload has {} trailing bytes", c.remaining()),
        ));
    }

    let bytecode = Bytecode {
        format: FORMAT_V1_JSON.to_string(),
        strings,
        functions,
        entry_fn,
    };
    bytecode.validate()?;
    Ok(bytecode)
}

fn decode_op(raw: u8) -> Result<OpCode, BytecodeError> {
    match raw {
        0 => Ok(OpCode::PushInt),
        1 => Ok(OpCode::PushFloat),
        2 => Ok(OpCode::PushBool),
        3 => Ok(OpCode::PushString),
        4 => Ok(OpCode::PushUnit),
        5 => Ok(OpCode::LoadLocal),
        6 => Ok(OpCode::StoreLocal),
        7 => Ok(OpCode::Pop),
        8 => Ok(OpCode::Jump),
        9 => Ok(OpCode::JumpIfFalse),
        10 => Ok(OpCode::CallBuiltin),
        11 => Ok(OpCode::CallFn),
        12 => Ok(OpCode::CallIndirect),
        13 => Ok(OpCode::Return),
        14 => Ok(OpCode::Trap),
        15 => Ok(OpCode::MkList),
        16 => Ok(OpCode::GetIndex),
        17 => Ok(OpCode::Len),
        _ => Err(BytecodeError::new(
            "E4201",
            format!("unknown opcode byte {}", raw),
        )),
    }
}

struct BinaryCursor<'a> {
    raw: &'a [u8],
    pos: usize,
}

impl<'a> BinaryCursor<'a> {
    fn new(raw: &'a [u8]) -> Self {
        Self { raw, pos: 0 }
    }

    fn remaining(&self) -> usize {
        self.raw.len().saturating_sub(self.pos)
    }

    fn expect_magic(&mut self, magic: &[u8]) -> Result<(), BytecodeError> {
        let got = self.read_exact(magic.len())?;
        if got != magic {
            return Err(BytecodeError::new("E4201", "invalid binary magic"));
        }
        Ok(())
    }

    fn read_exact(&mut self, n: usize) -> Result<&'a [u8], BytecodeError> {
        if self.pos + n > self.raw.len() {
            return Err(BytecodeError::new("E4201", "unexpected end of binary payload"));
        }
        let out = &self.raw[self.pos..self.pos + n];
        self.pos += n;
        Ok(out)
    }

    fn read_u8(&mut self) -> Result<u8, BytecodeError> {
        Ok(self.read_exact(1)?[0])
    }

    fn read_u32(&mut self) -> Result<u32, BytecodeError> {
        let bytes = self.read_exact(4)?;
        let mut arr = [0u8; 4];
        arr.copy_from_slice(bytes);
        Ok(u32::from_le_bytes(arr))
    }

    fn read_i64(&mut self) -> Result<i64, BytecodeError> {
        let bytes = self.read_exact(8)?;
        let mut arr = [0u8; 8];
        arr.copy_from_slice(bytes);
        Ok(i64::from_le_bytes(arr))
    }

    fn read_f64(&mut self) -> Result<f64, BytecodeError> {
        let bytes = self.read_exact(8)?;
        let mut arr = [0u8; 8];
        arr.copy_from_slice(bytes);
        Ok(f64::from_le_bytes(arr))
    }

    fn read_string(&mut self) -> Result<String, BytecodeError> {
        let len = self.read_u32()? as usize;
        let bytes = self.read_exact(len)?;
        String::from_utf8(bytes.to_vec())
            .map_err(|e| BytecodeError::new("E4201", format!("invalid utf-8 string payload: {e}")))
    }
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
