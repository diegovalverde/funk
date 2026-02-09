#!/usr/bin/env python3

def make_x(n: int):
    return [i * 0.5 + 1.1 for i in range(n)]


def make_y(n: int):
    return [i * 0.25 + 2.3 for i in range(n)]


def daxpy_sum(x, y, a: float) -> float:
    acc = 0.0
    for xi, yi in zip(x, y):
        acc += a * xi + yi
    return acc


if __name__ == "__main__":
    n = 2000
    rounds = 200
    a = 1.61803398875
    x = make_x(n)
    y = make_y(n)
    total = 0.0
    for _ in range(rounds):
        total += daxpy_sum(x, y, a)
    print(f"{total:.12f}")
