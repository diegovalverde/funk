# Compatibility Matrix

This file defines known-good version tuples across the multi-repo toolchain.

## Policy

- Treat each row below as an atomic compatibility tuple.
- When bumping one repo (compiler, stdlib, examples), validate tests/examples/benchmark smoke and then update this file in the same PR.
- Prefer pinning CI to explicit SHAs for reproducibility.

## Known-Good Tuples

### `stable_2026` baseline (2026-02-10)

- `funk` (this repo): `53bc9b9e7982fce922032f43ee6425f45bbdbb4f`
- `funk` submodule (`lib_funky`): `996695a11d8ad2954b5217bd241cd859e7e99d09` on `stable_2026`
- `stdlib` submodule (`funk_stdlib`): `c307a27e81ad9507226db4f4df6e89c718bc125d` on `main`
- `funky_example_files`: `77bd37bfbdf64a72df2ae70a35812affb3806d80` on `stable_2026`

Validation commands used:

```bash
make sync-submodules
FUNK_EXAMPLES_PATH=/path/to/funky_example_files/root/examples make tests
FUNK_EXAMPLES_PATH=/path/to/funky_example_files/root/examples make examples
make bench-report BENCH_RUNS=1 BENCH_WARMUP=0
```
