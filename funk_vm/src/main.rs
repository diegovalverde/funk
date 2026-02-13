use std::path::PathBuf;
use std::process;

use funk_vm::{load_bytecode_from_path, run};
use funk_vm::vm::{disassemble, DEFAULT_FUEL, Value};

fn usage() -> &'static str {
    "Usage:\n  funk_vm run <path.fkb.json> [--fuel N]\n  funk_vm disasm <path.fkb.json>\n"
}

fn main() {
    if let Err(err) = real_main() {
        eprintln!("{err}");
        process::exit(1);
    }
}

fn real_main() -> Result<(), String> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 3 {
        return Err(usage().to_string());
    }
    let command = &args[1];
    let path = PathBuf::from(&args[2]);
    let bytecode = load_bytecode_from_path(&path).map_err(|e| e.to_string())?;

    match command.as_str() {
        "run" => {
            let fuel = parse_fuel(&args[3..])?;
            let result = run(&bytecode, fuel).map_err(|e| e.to_string())?;
            match result.return_value {
                Value::Int(code) => {
                    if code != 0 {
                        process::exit(code as i32);
                    }
                }
                _ => {}
            }
            Ok(())
        }
        "disasm" => {
            print!("{}", disassemble(&bytecode));
            Ok(())
        }
        _ => Err(usage().to_string()),
    }
}

fn parse_fuel(args: &[String]) -> Result<u64, String> {
    if args.is_empty() {
        return Ok(DEFAULT_FUEL);
    }
    if args.len() != 2 || args[0] != "--fuel" {
        return Err("invalid run arguments; expected optional '--fuel N'".to_string());
    }
    args[1]
        .parse::<u64>()
        .map_err(|e| format!("invalid fuel '{}': {e}", args[1]))
}
