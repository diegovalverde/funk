#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PY="${PYTHON:-$ROOT_DIR/venv_3.11/bin/python}"
BUILD_DIR_DEFAULT="${BUILD_DIR_DEFAULT:-$ROOT_DIR/build}"
BUILD_DIR_OPT="${BUILD_DIR_OPT:-$ROOT_DIR/build}"
REPEAT="${REPEAT:-3}"
OUT_CSV="${OUT_CSV:-$ROOT_DIR/bench_results.csv}"

BENCHES=(
  "benchmarks/bench/fibonacci.f"
  "benchmarks/bench/array_concat.f"
  "benchmarks/bench/small_lists.f"
)

run_one() {
  local backend="$1"
  local build_dir="$2"

  echo "== Backend: ${backend} =="
  for bench in "${BENCHES[@]}"; do
    echo "-- ${bench}"
    "$PY" "$ROOT_DIR/funky.py" "$ROOT_DIR/$bench" --backend "$backend" >/dev/null
    local exe_name
    exe_name="${bench##*/}"
    exe_name="${exe_name%.f}"
    for i in $(seq 1 "$REPEAT"); do
      local line
      line=$(/usr/bin/time -p "$build_dir/$exe_name" 2>&1 >/dev/null | awk -v b="$backend" -v f="$bench" -v r="$i" '
        $1=="real"{real=$2}
        $1=="user"{user=$2}
        $1=="sys"{sys=$2}
        END{printf "%s,%s,%s,%.5f,%.5f,%.5f\n", b,f,r,real,user,sys}
      ')
      echo "$line" | tee -a "$OUT_CSV" >/dev/null
      echo "run $i: $line"
    done
  done
}

if [ ! -f "$OUT_CSV" ]; then
  echo "backend,bench,run,real,user,sys" > "$OUT_CSV"
fi

run_one "default" "$BUILD_DIR_DEFAULT"
run_one "cpp20" "$BUILD_DIR_OPT"
