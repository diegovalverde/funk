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

## Browser Playground (local)

The browser playground uses this VM via the WASM wrapper crate (`crates/funk_wasm`).

From repo root:

```bash
rustup target add wasm32-unknown-unknown
cargo install wasm-bindgen-cli
cd web
npm install
npm run dev
```

If `web/src/pkg/funk_wasm.js` is missing, run:

```bash
cd web
npm run build:wasm
```
