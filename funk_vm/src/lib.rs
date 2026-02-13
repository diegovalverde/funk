pub mod bytecode;
pub mod vm;

pub use bytecode::{load_bytecode_from_bytes, load_bytecode_from_path, load_bytecode_from_str, Bytecode, BytecodeError};
pub use vm::{run, run_with_host, VmError, VmHost, VmResult};
