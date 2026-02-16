#!/usr/bin/env python3

import argparse
import math
import os
import re
import subprocess
import time
import statistics
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List


@dataclass
class Row:
    workload: str
    variant: str
    name: str
    min_s: float
    median_s: float
    max_s: float


BENCH_CONFIGS = [
    ("cpp20", False, "funk_cpp20"),
    ("cpp20_i32", False, "funk_cpp20_i32"),
    ("cpp20_i32", True, "funk_cpp20_i32_fastpath"),
]


BENCH_SCRIPTS = [
    ("fib", "scripts/benchmark_fib_compare.py"),
    ("fib_tr", "scripts/benchmark_fib_tr_compare.py"),
    ("concat", "scripts/benchmark_concat_compare.py"),
    ("sum_range", "scripts/benchmark_sum_range_compare.py"),
    ("collatz", "scripts/benchmark_collatz_compare.py"),
    ("mutual_recursion", "scripts/benchmark_mutual_recursion_compare.py"),
    ("fp_dot", "scripts/benchmark_fp_dot_compare.py"),
    ("fp_axpy", "scripts/benchmark_fp_axpy_compare.py"),
    ("fp_triad", "scripts/benchmark_fp_triad_compare.py"),
]

WORKLOAD_DESCRIPTIONS = {
    "fib": "naive recursion (call-heavy, non-tail)",
    "fib_tr": "tail recursion with accumulators",
    "concat": "list-heavy concatenation/copy pressure",
    "sum_range": "integer-only tail-recursive accumulation",
    "collatz": "branch-heavy integer recursion",
    "mutual_recursion": "cross-function recursive call overhead",
    "fp_dot": "double-precision dot product reduction",
    "fp_axpy": "double-precision daxpy-style reduction",
    "fp_triad": "double-precision STREAM-like triad reduction",
}


def run_cmd(cmd: List[str], cwd: Path) -> str:
    out = subprocess.check_output(
        cmd, cwd=str(cwd), text=True, stderr=subprocess.STDOUT
    )
    return out


def timed(cmd: List[str], cwd: Path, runs: int, warmup: int) -> Dict[str, float]:
    for _ in range(warmup):
        run_cmd(cmd, cwd)
    samples = []
    last_out = ""
    for _ in range(runs):
        t0 = time.perf_counter()
        last_out = run_cmd(cmd, cwd).strip()
        samples.append(time.perf_counter() - t0)
    return {
        "last_out": last_out,
        "min": min(samples),
        "median": statistics.median(samples),
        "max": max(samples),
    }


def timed_capture(
    cmd: List[str], cwd: Path, runs: int, warmup: int
) -> Dict[str, float]:
    def run_once() -> str:
        proc = subprocess.run(
            cmd,
            cwd=str(cwd),
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )
        return proc.stdout.strip()

    for _ in range(warmup):
        out = run_once()
        if "E4301" in out:
            raise RuntimeError("fuel exhausted")

    samples = []
    last_out = ""
    for _ in range(runs):
        t0 = time.perf_counter()
        last_out = run_once()
        if "E4301" in last_out:
            raise RuntimeError("fuel exhausted")
        samples.append(time.perf_counter() - t0)

    return {
        "last_out": last_out,
        "min": min(samples),
        "median": statistics.median(samples),
        "max": max(samples),
    }


def benchmark_bytecode_workload(
    root: Path, workload: str, runs: int, warmup: int, fuel: int, reuse_build: bool
) -> Row:
    funk_src = root / "benchmarks" / "bench" / f"{workload}_compare.f"
    py_src = root / "benchmarks" / "bench" / f"{workload}_compare.py"
    if not funk_src.exists() or not py_src.exists():
        raise RuntimeError(f"Missing benchmark sources for workload '{workload}'")

    build_prefix = os.environ.get("FUNK_BUILD_ROOT", "").strip()
    build_dir_name = f"build_{workload}_bytecode"
    build_dir = (
        os.path.join(build_prefix, build_dir_name) if build_prefix else build_dir_name
    )
    artifact = root / build_dir / f"{workload}_compare.fkb"
    must_build = True
    if reuse_build and artifact.exists():
        must_build = artifact.stat().st_mtime < funk_src.stat().st_mtime
    if must_build:
        subprocess.check_call(
            [
                "./venv_3.11/bin/python",
                "./funky.py",
                str(funk_src),
                "--backend",
                "bytecode",
                "--build-dir",
                build_dir,
                "--include",
                ".",
            ],
            cwd=str(root),
        )
    else:
        print(f"[bytecode] reuse {artifact}")

    vm_bin = root / "funk_vm" / "target" / "release" / "funk_vm"
    try:
        stats = timed_capture(
            [str(vm_bin), "run", str(artifact), "--fuel", str(fuel)], root, runs, warmup
        )
    except RuntimeError:
        return Row(
            workload=workload,
            variant="funk_bytecode",
            name="funk_bytecode",
            min_s=float("nan"),
            median_s=float("nan"),
            max_s=float("nan"),
        )

    expected = run_cmd(["python3", str(py_src)], root).strip()
    if not outputs_match(expected, stats["last_out"]):
        return Row(
            workload=workload,
            variant="funk_bytecode",
            name="funk_bytecode",
            min_s=float("nan"),
            median_s=float("nan"),
            max_s=float("nan"),
        )

    return Row(
        workload=workload,
        variant="funk_bytecode",
        name="funk_bytecode",
        min_s=stats["min"],
        median_s=stats["median"],
        max_s=stats["max"],
    )


def fmt_s(value: float) -> str:
    if math.isnan(value):
        return "n/a"
    return f"{value:.6f}"


def fmt_ratio(num: float, den: float) -> str:
    if math.isnan(num) or math.isnan(den) or den == 0.0:
        return "n/a"
    return f"{num/den:.2f}x"


def outputs_match(expected: str, actual: str) -> bool:
    if expected == actual:
        return True
    try:
        e = float(expected)
        a = float(actual)
    except ValueError:
        return False
    return math.isclose(e, a, rel_tol=1e-9, abs_tol=1e-9)


def parse_output(workload: str, variant: str, text: str) -> List[Row]:
    rows = []
    for line in text.splitlines():
        if re.match(r"^(python3|funk_cpp20|c_o3),", line):
            name, min_s, med_s, max_s = line.split(",")
            rows.append(
                Row(
                    workload=workload,
                    variant=variant,
                    name=name,
                    min_s=float(min_s),
                    median_s=float(med_s),
                    max_s=float(max_s),
                )
            )
    if len(rows) != 3:
        raise RuntimeError(f"Could not parse benchmark output for {workload}/{variant}")
    return rows


def ensure_dirs(base: Path) -> Dict[str, Path]:
    out = {
        "plots": base / "plots",
        "raw": base / "raw",
    }
    out["plots"].mkdir(parents=True, exist_ok=True)
    out["raw"].mkdir(parents=True, exist_ok=True)
    return out


def write_csv(path: Path, rows: List[Row]) -> None:
    with path.open("w", encoding="utf-8") as f:
        f.write("workload,variant,name,min_s,median_s,max_s\n")
        for r in rows:
            f.write(
                f"{r.workload},{r.variant},{r.name},{r.min_s:.6f},{r.median_s:.6f},{r.max_s:.6f}\n"
            )


def write_bar_svg(
    path: Path, title: str, labels: List[str], values: List[float]
) -> None:
    width = 1100
    height = 520
    margin_left = 90
    margin_right = 40
    margin_top = 70
    margin_bottom = 140
    plot_w = width - margin_left - margin_right
    plot_h = height - margin_top - margin_bottom
    n = len(values)
    if n == 0:
        return

    min_v = min(values)
    max_v = max(values)
    min_log = math.log10(max(min_v, 1e-9))
    max_log = math.log10(max(max_v, 1e-9))
    if abs(max_log - min_log) < 1e-9:
        max_log += 1.0

    def y_for(v: float) -> float:
        lv = math.log10(max(v, 1e-9))
        t = (lv - min_log) / (max_log - min_log)
        return margin_top + plot_h - (t * plot_h)

    bar_gap = 16
    slot_w = (plot_w - bar_gap * (n + 1)) / n
    colors = [
        "#6c8cff",
        "#46b3a9",
        "#f28f3b",
        "#b27cff",
        "#ef476f",
        "#ffd166",
        "#4cc9f0",
    ]

    # Grid lines (log scale ticks at powers of ten)
    tick_vals = []
    p0 = int(math.floor(min_log))
    p1 = int(math.ceil(max_log))
    for p in range(p0, p1 + 1):
        tick_vals.append(10**p)

    parts = []
    parts.append(
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">'
    )
    parts.append('<rect width="100%" height="100%" fill="#0f172a"/>')
    parts.append(
        f'<text x="{margin_left}" y="36" fill="#e5e7eb" font-size="26" font-family="Helvetica, Arial">{title}</text>'
    )
    parts.append(
        f'<text x="{margin_left}" y="58" fill="#94a3b8" font-size="14" font-family="Helvetica, Arial">Median runtime (seconds, log scale)</text>'
    )

    for tv in tick_vals:
        y = y_for(tv)
        if margin_top <= y <= margin_top + plot_h:
            parts.append(
                f'<line x1="{margin_left}" y1="{y:.2f}" x2="{margin_left + plot_w}" y2="{y:.2f}" stroke="#334155" stroke-width="1"/>'
            )
            parts.append(
                f'<text x="{margin_left - 8}" y="{y + 5:.2f}" text-anchor="end" fill="#94a3b8" font-size="12" font-family="Helvetica, Arial">{tv:g}</text>'
            )

    parts.append(
        f'<rect x="{margin_left}" y="{margin_top}" width="{plot_w}" height="{plot_h}" fill="none" stroke="#475569" stroke-width="1.2"/>'
    )

    for i, (label, val) in enumerate(zip(labels, values)):
        x = margin_left + bar_gap + i * (slot_w + bar_gap)
        y = y_for(val)
        h = margin_top + plot_h - y
        color = colors[i % len(colors)]
        parts.append(
            f'<rect x="{x:.2f}" y="{y:.2f}" width="{slot_w:.2f}" height="{h:.2f}" fill="{color}" opacity="0.92"/>'
        )
        parts.append(
            f'<text x="{x + slot_w / 2:.2f}" y="{y - 8:.2f}" text-anchor="middle" fill="#e2e8f0" font-size="11" font-family="Helvetica, Arial">{val:.6f}s</text>'
        )
        parts.append(
            f'<text x="{x + slot_w / 2:.2f}" y="{margin_top + plot_h + 18:.2f}" text-anchor="end" transform="rotate(-35 {x + slot_w / 2:.2f},{margin_top + plot_h + 18:.2f})" fill="#cbd5e1" font-size="12" font-family="Helvetica, Arial">{label}</text>'
        )

    parts.append("</svg>")
    path.write_text("\n".join(parts), encoding="utf-8")


def build_markdown(
    rows: List[Row], plots_rel: Dict[str, str], runs: int, warmup: int
) -> str:
    workload_order = [name for name, _ in BENCH_SCRIPTS]
    lines = []
    lines.append("# Benchmarks")
    lines.append("- Workload matrix:")
    for workload in workload_order:
        lines.append(f"  - `{workload}`: {WORKLOAD_DESCRIPTIONS.get(workload, '')}")
    lines.append("")
    lines.append("Auto-generated by `benchmarks/generate_report.py`.")
    lines.append("")
    lines.append(f"- Runs per configuration: `{runs}`")
    lines.append(f"- Warmup runs per configuration: `{warmup}`")
    lines.append("- Runtime metric: median wall-clock seconds")
    lines.append("- Plot scale: logarithmic y-axis")
    lines.append("")

    by_workload: Dict[str, List[Row]] = {}
    for r in rows:
        by_workload.setdefault(r.workload, []).append(r)

    for workload in workload_order:
        lines.append(f"## {workload}")
        lines.append("")
        lines.append(f"![{workload} plot]({plots_rel[workload]})")
        lines.append("")
        lines.append(
            "| Variant | Python (s) | Funk (s) | Bytecode (s) | C (s) | Funk/Python | Funk/C | Bytecode/Python | Bytecode/C |"
        )
        lines.append("|---|---:|---:|---:|---:|---:|---:|---:|---:|")
        rows_w = [r for r in by_workload.get(workload, [])]
        bc = next(r.median_s for r in rows_w if r.name == "funk_bytecode")
        variants = sorted(set(r.variant for r in rows_w))
        for variant in variants:
            if variant == "funk_bytecode":
                continue
            py = next(
                r.median_s
                for r in rows_w
                if r.variant == variant and r.name == "python3"
            )
            fk = next(
                r.median_s
                for r in rows_w
                if r.variant == variant and r.name == "funk_cpp20"
            )
            cc = next(
                r.median_s for r in rows_w if r.variant == variant and r.name == "c_o3"
            )
            lines.append(
                f"| `{variant}` | {fmt_s(py)} | {fmt_s(fk)} | {fmt_s(bc)} | {fmt_s(cc)} | "
                f"{fmt_ratio(fk, py)} | {fmt_ratio(fk, cc)} | {fmt_ratio(bc, py)} | {fmt_ratio(bc, cc)} |"
            )
        lines.append("")

    lines.append("## Findings")
    lines.append("")
    for workload in workload_order:
        rows_w = [r for r in rows if r.workload == workload]
        best_funk = min(
            (r for r in rows_w if r.name == "funk_cpp20"), key=lambda x: x.median_s
        )
        bc = next(r for r in rows_w if r.name == "funk_bytecode")
        py = next(
            r.median_s
            for r in rows_w
            if r.variant == best_funk.variant and r.name == "python3"
        )
        cc = next(
            r.median_s
            for r in rows_w
            if r.variant == best_funk.variant and r.name == "c_o3"
        )
        if math.isnan(bc.median_s):
            lines.append(
                f"- `{workload}` best Funk variant is `{best_funk.variant}` at `{best_funk.median_s:.6f}s` "
                f"({best_funk.median_s/py:.2f}x vs Python, {best_funk.median_s/cc:.2f}x vs C); "
                "bytecode: n/a (fuel exhausted)."
            )
        else:
            lines.append(
                f"- `{workload}` best Funk variant is `{best_funk.variant}` at `{best_funk.median_s:.6f}s` "
                f"({best_funk.median_s/py:.2f}x vs Python, {best_funk.median_s/cc:.2f}x vs C); "
                f"bytecode is `{bc.median_s:.6f}s` "
                f"({bc.median_s/py:.2f}x vs Python, {bc.median_s/cc:.2f}x vs C)."
            )
    lines.append("")
    return "\n".join(lines)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Run benchmark scripts and generate plots + markdown report."
    )
    parser.add_argument(
        "--runs", type=int, default=7, help="Timing runs per benchmark configuration."
    )
    parser.add_argument(
        "--warmup", type=int, default=1, help="Warmup runs per benchmark configuration."
    )
    parser.add_argument(
        "--bytecode-fuel",
        type=int,
        default=200_000_000,
        help="Fuel budget used when running bytecode workload binaries.",
    )
    parser.add_argument(
        "--reuse-bytecode-build",
        action=argparse.BooleanOptionalAction,
        default=True,
        help="Reuse existing bytecode benchmark artifacts when up to date.",
    )
    args = parser.parse_args()

    root = Path(__file__).resolve().parents[1]
    bench_dir = root / "benchmarks"
    dirs = ensure_dirs(bench_dir)

    all_rows: List[Row] = []
    for workload, script in BENCH_SCRIPTS:
        for backend, fastpath, variant in BENCH_CONFIGS:
            cmd = [
                "./venv_3.11/bin/python",
                script,
                "--runs",
                str(args.runs),
                "--backend",
                backend,
            ]
            cmd.extend(["--warmup", str(args.warmup)])
            if fastpath:
                cmd.append("--fastpath")
            out = run_cmd(cmd, root)
            all_rows.extend(parse_output(workload, variant, out))
        all_rows.append(
            benchmark_bytecode_workload(
                root,
                workload,
                args.runs,
                args.warmup,
                args.bytecode_fuel,
                args.reuse_bytecode_build,
            )
        )

    csv_path = dirs["raw"] / "results.csv"
    write_csv(csv_path, all_rows)

    # Build per-workload plots (Funk variants + bytecode + python + c baselines).
    plot_paths = {}
    workload_order = [name for name, _ in BENCH_SCRIPTS]
    for workload in workload_order:
        rows_w = [r for r in all_rows if r.workload == workload]
        labels = []
        values = []
        # Baseline interpreters/compilers from first variant for stable display.
        base_variant = "funk_cpp20"
        labels.extend(["python3", "c_o3"])
        values.extend(
            [
                next(
                    r.median_s
                    for r in rows_w
                    if r.variant == base_variant and r.name == "python3"
                ),
                next(
                    r.median_s
                    for r in rows_w
                    if r.variant == base_variant and r.name == "c_o3"
                ),
            ]
        )
        bc = next(
            r.median_s
            for r in rows_w
            if r.variant == "funk_bytecode" and r.name == "funk_bytecode"
        )
        if not math.isnan(bc):
            labels.append("funk_bytecode")
            values.append(bc)
        for v in ("funk_cpp20", "funk_cpp20_i32", "funk_cpp20_i32_fastpath"):
            labels.append(v)
            values.append(
                next(
                    r.median_s
                    for r in rows_w
                    if r.variant == v and r.name == "funk_cpp20"
                )
            )
        plot_file = dirs["plots"] / f"{workload}.svg"
        write_bar_svg(plot_file, f"{workload} runtime comparison", labels, values)
        plot_paths[workload] = str(Path("plots") / f"{workload}.svg")

    md = build_markdown(all_rows, plot_paths, args.runs, args.warmup)
    (bench_dir / "benchmarks.md").write_text(md, encoding="utf-8")
    print("Generated:")
    print(f"- {bench_dir / 'benchmarks.md'}")
    print(f"- {csv_path}")
    for w in workload_order:
        print(f"- {dirs['plots'] / f'{w}.svg'}")


if __name__ == "__main__":
    main()
