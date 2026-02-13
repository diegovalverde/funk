# Funk ByteCode Spec (Draft v0)

## Status
- Draft for incremental implementation.
- Versioned as `funk-bytecode-v1-json` for the JSON container.
- Binary container (`FKB1`) is deferred to a later phase.

## Design Goals
- Deterministic execution model.
- Strict decode/validation (no best-effort parsing).
- Stable error codes for malformed bytecode.
- Simple stack VM as baseline implementation.

## JSON Container (`*.fkb.json`)
Top-level object shape:

```json
{
  "format": "funk-bytecode-v1-json",
  "strings": ["..."],
  "functions": [
    {
      "name": "main",
      "arity": 0,
      "captures": 0,
      "code": [
        {"op": "PUSH_INT", "arg": 0},
        {"op": "RETURN"}
      ]
    }
  ],
  "entry_fn": 0
}
```

## Value Domains
- `strings`: UTF-8 string pool, indexed by integer.
- `functions[i]`:
  - `name`: debug name (non-semantic)
  - `arity`: required argument count (>= 0)
  - `captures`: closure capture count (>= 0)
  - `code`: list of instructions
- `entry_fn`: index into `functions`

## VM Model (v1)
- Global stack of runtime values.
- Call frame:
  - `fn_id`
  - `ip` (instruction index)
  - `locals[]`
- Execution ends when outermost frame returns.

## Opcode Set (v1)
- Constants:
  - `PUSH_INT {arg:i64}`
  - `PUSH_FLOAT {arg:f64}`
  - `PUSH_BOOL {arg:bool}`
  - `PUSH_STRING {arg:u32}` (string table index)
  - `PUSH_UNIT`
- Locals:
  - `LOAD_LOCAL {arg:u32}`
  - `STORE_LOCAL {arg:u32}`
  - `POP`
- Control flow:
  - `JUMP {arg:u32}` (target instruction index)
  - `JUMP_IF_FALSE {arg:u32}`
  - `RETURN`
  - `TRAP {arg:u32}` (string message index)
- Calls:
  - `CALL_BUILTIN {id:u8, argc:u8}`
  - `CALL_FN {arg:u32, argc:u8}` (function index)
- List/array baseline:
  - `MK_LIST {argc:u8}` (pop argc values, push list)
  - `GET_INDEX` (pop index + list, push element)
  - `LEN` (pop list/string, push int)

## Validation Rules
- `format` must match expected format string.
- `entry_fn` must be in-bounds.
- Unknown opcode is invalid.
- Operand shape/type must match opcode.
- `PUSH_STRING` and `TRAP` string index must be in-bounds.
- `CALL_FN` target must be in-bounds.
- `JUMP`/`JUMP_IF_FALSE` targets must be in-bounds of current function code.
- `arity`, `captures`, and indexes must be non-negative integers.

## Error Codes (decoder/validator)
- `E4201`: invalid container/header
- `E4202`: invalid field/type
- `E4203`: invalid opcode
- `E4204`: invalid index
- `E4205`: invalid jump target
- `E4206`: trailing/unknown fields (reserved strict mode)

## Non-goals (v1)
- Bytecode-level optimizations.
- Binary container.
- Full closure support.
- Full Funk list slicing semantics.
