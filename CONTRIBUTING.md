# Contributing

## Branching and PRs

- Open PRs against `main`.
- Keep PRs focused and small when possible.
- Ensure required CI checks pass before requesting merge.

## Local Setup

From repo root:

```bash
make sync-submodules
make doctor
```

Set examples path for validation commands:

```bash
export FUNK_EXAMPLES_PATH=/path/to/funky_example_files/root/examples
```

## Required Local Validation

Quick checks (run before most PRs):

```bash
make tests-fast
make examples-smoke
```

## Full Validation

Run for larger changes, toolchain changes, or release-related updates:

```bash
make release-check
```

Optional deeper integration run:

```bash
make tests-integration
make examples
```

## Multi-Repo Compatibility

- Keep compatibility in sync across:
  - `funk`
  - `lib_funky` (submodule `funk/`)
  - `funk_stdlib` (submodule `stdlib/`)
  - `funky_example_files`
- Update `VERSIONS.md` whenever compatibility tuples change.
