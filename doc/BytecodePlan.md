# Funk ByteCode Plan (mu-inspired)

## Goal
Implement a real ByteCode backend for Funk that can compile and run programs via a VM, while keeping `cpp20` stable.

The design should be inspired by `mu` bytecode/runtime in:
- `/Users/diegovalverdegarro/workspace/projects/mu/src/bytecode.rs`
- `/Users/diegovalverdegarro/workspace/projects/mu/src/vm.rs`
- `/Users/diegovalverdegarro/workspace/projects/mu/docs/BYTECODE.md`

## Current State in Funk
- Backend plugin architecture now exists (`funk/backends/base.py`, `funk/backends/__init__.py`).
- `bytecode` backend emits executable JSON bytecode (`*.fkb.json`) via lowering.
- Rust VM runtime executes/disassembles emitted bytecode (`funk_vm` crate).
- Makefile includes smoke + subset bytecode validation targets.

## What to Reuse from mu
- Stack machine execution model (single value stack + call frames).
- Explicit function table with arity metadata.
- Compact opcodes with little-endian immediate payloads.
- Strict decode/validate pass before execution.
- Error-code discipline and deterministic VM traps.

## Proposed ByteCode v1 for Funk
### Container (first iteration)
- Keep JSON for fast iteration:
  - `*.fkb.json` with `strings`, `functions`, `entry_fn`.
- Add binary format once stable:
  - `*.fkb` magic (e.g. `FKB1`), LE integers.

### Core VM model
- Stack-based VM.
- Frame = `{fn_id, ip, locals[]}`.
- Function metadata:
  - arity
  - capture count (optional in v1 if closures are deferred)
  - bytecode stream

### Minimal opcode set (v1)
- Constants: `PUSH_INT`, `PUSH_FLOAT`, `PUSH_BOOL`, `PUSH_STRING`, `PUSH_UNIT`
- Locals: `LOAD_LOCAL`, `STORE_LOCAL`, `POP`
- Control flow: `JUMP`, `JUMP_IF_FALSE`, `RETURN`, `TRAP`
- Calls: `CALL_BUILTIN`, `CALL_FN`
- Arrays/lists: `MK_LIST`, `GET_INDEX`, `SET_INDEX_COPY`, `LEN`

### Extended opcodes (v2)
- Pattern matching: `MATCH_TAG`, `GET_FIELD`, list destructuring helpers
- Closures: `MK_CLOSURE`, `CALL_CLOSURE`
- Advanced slicing/range helpers (multi-dimensional + specialized ops)

## Mapping Funk Semantics to ByteCode
### Function clauses + preconditions
- Compile each Funk function into:
  1. dispatch prologue for clause checks (arity/pattern/preconditions),
  2. clause body blocks with jumps,
  3. fallback trap (`non-exhaustive clause match`).
- This mirrors `mu` match lowering style (jump patching), but tailored for Funk clauses.

### Pattern matching
- Start with:
  - literal equality checks,
  - wildcard,
  - list empty/non-empty checks,
  - head/tail binding.
- Compile to basic jumps + local stores.

### Builtins/stdlib calls
- Use `CALL_BUILTIN` ids for core runtime operations (print, read, math, list primitives).
- Keep user-defined Funk functions as `CALL_FN` via function table id.

## Implementation Phases
### Phase 0: Spec + scaffolding
- Create `doc/BytecodeSpec.md` with opcodes, operand widths, stack effect.
- Add `funk/bytecode/` package:
  - `model.py` (decoded form),
  - `encode.py`, `decode.py` (JSON first),
  - `errors.py`.

### Phase 1: Lowering pipeline
- Introduce backend-neutral lowerer output (`FIR` or direct BC builder).
- Implement `BytecodeLowerer` for a strict subset:
  - literals,
  - arithmetic,
  - direct function calls,
  - returns.
- Emit bytecode functions into `.fkb.json`.

### Phase 2: VM runtime (Python first)
- Implement `funk/bytecode/vm.py`:
  - stack loop,
  - frame management,
  - opcode dispatch,
  - runtime errors with stable error codes.
- Add CLI mode to execute bytecode artifacts.

### Phase 3: Clause dispatch + patterns
- Compile Funk function clauses/preconditions into jump-driven dispatch.
- Add tests for:
  - multi-clause functions,
  - guard behavior,
  - non-exhaustive failures.

### Phase 4: Lists/arrays and stdlib compatibility
- Add list operations needed by current tests/examples.
- Expand builtins and/or runtime helpers.
- Run `make tests` subset under bytecode backend.

Status update:
- v1 already supports range slicing through builtin `40` with omitted bounds:
  - `[..x]`, `[x..]`, `[..]` are lowered with default bounds.
- `make bytecode-tests-subset` now runs a deterministic bytecode subset covering:
  - lists/indexing/ranges,
  - clause dispatch + guards,
  - recursion and builtin helpers.

### Phase 5: Binary format + validation hardening
- Introduce binary `.fkb` encoder/decoder.
- Add strict validation pass (unknown opcodes, bounds, jump targets, trailing bytes).
- Keep JSON as debug format.

### Phase 6: Performance and migration
- Optional threaded dispatch or superinstructions.
- Add bytecode smoke targets in Makefile.
- Document backend maturity and known gaps.

## Testing Strategy
- Unit tests:
  - encode/decode roundtrip,
  - malformed bytecode rejection,
  - VM step semantics per opcode.
- Integration tests:
  - compile+run simple programs (`arith`, `fibo`, clause dispatch).
- Golden tests:
  - stable emitted bytecode for selected sources.
- Differential tests:
  - compare `cpp20` vs `bytecode` outputs for deterministic programs.

## Key Risks and Mitigations
- Risk: Funk semantics are currently embedded in C++ emission paths.
  - Mitigation: centralize clause/pattern lowering in reusable backend-neutral logic.
- Risk: list and slicing semantics are complex.
  - Mitigation: ship scalar+call subset first; add list ops incrementally.
- Risk: debugging bytecode regressions.
  - Mitigation: add disassembler and instruction trace mode early.

## Suggested Next 3 Tasks
1. Add `doc/BytecodeSpec.md` (opcode table + stack effects + error codes).
2. Implement `funk/bytecode/model.py` + JSON `encode/decode` with validation.
3. Replace metadata-only emission in `funk/backends/bytecode.py` with real instruction emission for literal-return and arithmetic functions.
