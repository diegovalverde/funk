# funk_vm

Rust VM for Funk JSON bytecode artifacts (`*.fkb.json`).

## Current status
- Strict JSON bytecode decode + validation.
- Stack VM interpreter for the current opcode subset:
  - constants/local ops/control flow (`PUSH_*`, `LOAD_LOCAL`, `STORE_LOCAL`, `JUMP`, `RETURN`, `TRAP`)
  - calls (`CALL_FN`, `CALL_BUILTIN`)
  - basic list ops (`MK_LIST`, `GET_INDEX`, `LEN`)
- Builtin arithmetic/comparison/logical ops for ids used by the current Python lowerer.

## Usage

Run bytecode:

```bash
cargo run --offline -- run ../build_phase1_simple/bytecode_phase1_simple.fkb.json
```

Disassemble bytecode:

```bash
cargo run --offline -- disasm ../build_phase1_simple/bytecode_phase1_simple.fkb.json
```

Run tests:

```bash
cargo test
```
