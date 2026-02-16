#!/usr/bin/env python3


def make_b(n: int):
    return [i * 0.5 + 1.1 for i in range(n)]


def make_c(n: int):
    return [i * 0.25 + 2.3 for i in range(n)]


def make_d(n: int):
    return [i * 0.125 + 3.7 for i in range(n)]


def triad_sum(b, c, d, a: float) -> float:
    acc = 0.0
    for bi, ci, di in zip(b, c, d):
        acc += bi + a * ci + di
    return acc


if __name__ == "__main__":
    n = 2000
    rounds = 200
    a = 0.31415926535
    b = make_b(n)
    c = make_c(n)
    d = make_d(n)
    total = 0.0
    for _ in range(rounds):
        total += triad_sum(b, c, d, a)
    print(f"{total:.12f}")
