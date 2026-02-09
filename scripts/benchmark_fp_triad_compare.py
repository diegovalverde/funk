#!/usr/bin/env python3

import argparse
import math
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


def assert_close(expected_s, actual_s, name):
    expected = float(expected_s)
    actual = float(actual_s)
    # Funk uses default stream formatting, so large FP values may be rounded
    # to scientific notation with limited precision in stdout.
    tol = max(1e-6, abs(expected) * 1e-6)
    if math.isnan(actual) or abs(actual - expected) > tol:
        raise RuntimeError(f"Output mismatch for {name}: expected {expected_s}, got {actual_s}")


def main():
    parser = argparse.ArgumentParser(description="Benchmark STREAM-like triad reduction across Funk/Python/C.")
    parser.add_argument("--runs", type=int, default=5)
    parser.add_argument("--warmup", type=int, default=1, help="Warmup runs per implementation (excluded from timing).")
    parser.add_argument("--fastpath", action="store_true", help="Enable FUNK_I32_FASTPATH for Funk C++ build.")
    parser.add_argument("--backend", choices=["cpp20", "cpp20_i32"], default="cpp20")
    args = parser.parse_args()

    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    funk_src = os.path.join(root, "examples", "bench", "fp_triad_compare.f")
    py_src = os.path.join(root, "examples", "bench", "fp_triad_compare.py")
    c_src = os.path.join(root, "examples", "bench", "fp_triad_compare.c")
    benchmark_name = os.path.splitext(os.path.basename(funk_src))[0]
    variant_tag = f"{args.backend}_{'fast' if args.fastpath else 'base'}"
    build_subdir = f"build_{benchmark_name}_{variant_tag}"
    build_dir = os.path.join(root, build_subdir)
    os.makedirs(build_dir, exist_ok=True)
    c_bin = os.path.join(build_dir, "fp_triad_compare_c")

    env = os.environ.copy()
    base_flags = env.get("FUNK_EXTRA_CXXFLAGS", "").strip()
    if "-O" not in base_flags:
        base_flags = (base_flags + " -O3 -DNDEBUG").strip()
    if args.fastpath:
        base_flags = (base_flags + " -DFUNK_I32_FASTPATH").strip()
    env["FUNK_EXTRA_CXXFLAGS"] = base_flags

    subprocess.check_call([
        os.path.join(root, "venv_3.11", "bin", "python"),
        os.path.join(root, "funky.py"),
        funk_src,
        "--backend",
        args.backend,
        "--build-dir",
        build_subdir,
        "--include",
        ".",
    ], cwd=root, env=env)

    subprocess.check_call(["clang", "-O3", c_src, "-o", c_bin], cwd=root)

    funk_bin = os.path.join(build_dir, "fp_triad_compare")
    py_stats = timed(["python3", py_src], args.runs, cwd=root, warmup=args.warmup)
    funk_stats = timed([funk_bin], args.runs, cwd=root, warmup=args.warmup)
    c_stats = timed([c_bin], args.runs, cwd=root, warmup=args.warmup)

    expected = py_stats["last_out"]
    assert_close(expected, funk_stats["last_out"], "funk_cpp20")
    assert_close(expected, c_stats["last_out"], "c_o3")

    print(f"result: {expected}")
    print(f"runs: {args.runs}")
    print(f"warmup: {args.warmup}")
    print(f"funk_fastpath: {1 if args.fastpath else 0}")
    print(f"funk_backend: {args.backend}")
    print("name,min_s,median_s,max_s")
    print(f"python3,{py_stats['min']:.6f},{py_stats['median']:.6f},{py_stats['max']:.6f}")
    print(f"funk_cpp20,{funk_stats['min']:.6f},{funk_stats['median']:.6f},{funk_stats['max']:.6f}")
    print(f"c_o3,{c_stats['min']:.6f},{c_stats['median']:.6f},{c_stats['max']:.6f}")


if __name__ == "__main__":
    main()
