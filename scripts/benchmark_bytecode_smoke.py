#!/usr/bin/env python3

import argparse
import os
import statistics
import subprocess
import time


def run_cmd(cmd, cwd=None, env=None):
    return subprocess.check_output(cmd, cwd=cwd, env=env, text=True).strip()


def timed(cmd, runs, cwd=None, warmup=1, env=None):
    for _ in range(warmup):
        run_cmd(cmd, cwd=cwd, env=env)
    samples = []
    last_out = None
    for _ in range(runs):
        t0 = time.perf_counter()
        last_out = run_cmd(cmd, cwd=cwd, env=env)
        samples.append(time.perf_counter() - t0)
    return {
        "last_out": last_out,
        "min": min(samples),
        "median": statistics.median(samples),
        "max": max(samples),
    }


def main():
    parser = argparse.ArgumentParser(
        description="Benchmark deterministic Funk bytecode VM workloads."
    )
    parser.add_argument("--runs", type=int, default=7)
    parser.add_argument("--warmup", type=int, default=1)
    args = parser.parse_args()

    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    py = os.path.join(root, "venv_3.11", "bin", "python")
    funky = os.path.join(root, "funky.py")
    vm_dir = os.path.join(root, "funk_vm")
    vm_bin = os.path.join(vm_dir, "target", "release", "funk_vm")
    include_path = os.path.join(root, "stdlib")

    build_prefix = os.environ.get("FUNK_BUILD_ROOT", "").strip()
    build_dir_core = (
        os.path.join(build_prefix, "build_bytecode_core_lists_ranges")
        if build_prefix
        else "build_bytecode_core_lists_ranges"
    )
    build_dir_clauses = (
        os.path.join(build_prefix, "build_bytecode_clauses_recursion")
        if build_prefix
        else "build_bytecode_clauses_recursion"
    )

    workloads = [
        {
            "name": "core_lists_ranges",
            "src": os.path.join(root, "tests", "bytecode", "core_lists_ranges.f"),
            "build_dir": build_dir_core,
            "artifact": "core_lists_ranges.fkb",
        },
        {
            "name": "clauses_recursion",
            "src": os.path.join(root, "tests", "bytecode", "clauses_recursion.f"),
            "build_dir": build_dir_clauses,
            "artifact": "clauses_recursion.fkb",
        },
    ]

    for w in workloads:
        subprocess.check_call(
            [
                py,
                funky,
                w["src"],
                "--backend",
                "bytecode",
                "--build-dir",
                w["build_dir"],
                "--include",
                include_path,
            ],
            cwd=root,
        )

    subprocess.check_call(["cargo", "build", "--release", "--offline"], cwd=vm_dir)

    results = []
    for w in workloads:
        artifact = os.path.join(root, w["build_dir"], w["artifact"])
        stats = timed([vm_bin, "run", artifact], runs=args.runs, warmup=args.warmup)
        results.append((w["name"], stats))

    print(f"runs: {args.runs}")
    print(f"warmup: {args.warmup}")
    print("name,min_s,median_s,max_s")
    for name, stats in results:
        print(f"{name},{stats['min']:.6f},{stats['median']:.6f},{stats['max']:.6f}")


if __name__ == "__main__":
    main()
