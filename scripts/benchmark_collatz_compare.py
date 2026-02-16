#!/usr/bin/env python3

import argparse
import os
import statistics
import subprocess
import time


def run_cmd(cmd, cwd=None):
    out = subprocess.check_output(cmd, cwd=cwd, text=True)
    return out.strip()


def timed(cmd, runs, cwd=None, warmup=1):
    for _ in range(warmup):
        run_cmd(cmd, cwd=cwd)
    samples = []
    last_out = None
    for _ in range(runs):
        t0 = time.perf_counter()
        last_out = run_cmd(cmd, cwd=cwd)
        samples.append(time.perf_counter() - t0)
    return {
        "last_out": last_out,
        "min": min(samples),
        "median": statistics.median(samples),
        "max": max(samples),
    }


def main():
    parser = argparse.ArgumentParser(
        description="Benchmark Collatz workload across Funk/Python/C."
    )
    parser.add_argument("--runs", type=int, default=5)
    parser.add_argument(
        "--warmup",
        type=int,
        default=1,
        help="Warmup runs per implementation (excluded from timing).",
    )
    parser.add_argument(
        "--fastpath",
        action="store_true",
        help="Enable FUNK_I32_FASTPATH for Funk C++ build.",
    )
    parser.add_argument(
        "--backend", choices=["cpp20", "cpp20_i32"], default="cpp20_i32"
    )
    args = parser.parse_args()

    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    funk_src = os.path.join(root, "benchmarks", "bench", "collatz_compare.f")
    py_src = os.path.join(root, "benchmarks", "bench", "collatz_compare.py")
    c_src = os.path.join(root, "benchmarks", "bench", "collatz_compare.c")
    benchmark_name = os.path.splitext(os.path.basename(funk_src))[0]
    variant_tag = f"{args.backend}_{'fast' if args.fastpath else 'base'}"
    build_prefix = os.environ.get("FUNK_BUILD_ROOT", "").strip()
    build_subdir = (
        os.path.join(build_prefix, f"build_{benchmark_name}_{variant_tag}")
        if build_prefix
        else f"build_{benchmark_name}_{variant_tag}"
    )
    build_dir = os.path.join(root, build_subdir)
    os.makedirs(build_dir, exist_ok=True)
    c_bin = os.path.join(build_dir, "collatz_compare_c")

    env = os.environ.copy()
    base_flags = env.get("FUNK_EXTRA_CXXFLAGS", "").strip()
    if "-O" not in base_flags:
        base_flags = (base_flags + " -O3 -DNDEBUG").strip()
    if args.fastpath:
        base_flags = (base_flags + " -DFUNK_I32_FASTPATH").strip()
    env["FUNK_EXTRA_CXXFLAGS"] = base_flags

    subprocess.check_call(
        [
            os.path.join(root, "venv_3.11", "bin", "python"),
            os.path.join(root, "funky.py"),
            funk_src,
            "--backend",
            args.backend,
            "--build-dir",
            build_subdir,
            "--include",
            ".",
        ],
        cwd=root,
        env=env,
    )

    subprocess.check_call(["clang", "-O3", c_src, "-o", c_bin], cwd=root)

    funk_bin = os.path.join(build_dir, "collatz_compare")
    py_stats = timed(["python3", py_src], args.runs, cwd=root, warmup=args.warmup)
    funk_stats = timed([funk_bin], args.runs, cwd=root, warmup=args.warmup)
    c_stats = timed([c_bin], args.runs, cwd=root, warmup=args.warmup)

    expected = py_stats["last_out"]
    for name, stats in (("funk_cpp20", funk_stats), ("c_o3", c_stats)):
        if stats["last_out"] != expected:
            raise RuntimeError(
                f"Output mismatch for {name}: expected {expected}, got {stats['last_out']}"
            )

    print(f"result: {expected}")
    print(f"runs: {args.runs}")
    print(f"warmup: {args.warmup}")
    print(f"funk_fastpath: {1 if args.fastpath else 0}")
    print(f"funk_backend: {args.backend}")
    print("name,min_s,median_s,max_s")
    print(
        f"python3,{py_stats['min']:.6f},{py_stats['median']:.6f},{py_stats['max']:.6f}"
    )
    print(
        f"funk_cpp20,{funk_stats['min']:.6f},{funk_stats['median']:.6f},{funk_stats['max']:.6f}"
    )
    print(f"c_o3,{c_stats['min']:.6f},{c_stats['median']:.6f},{c_stats['max']:.6f}")


if __name__ == "__main__":
    main()
