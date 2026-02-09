#!/usr/bin/env python3

import sys


def ping(n: int, acc: int) -> int:
    if n == 0:
        return acc
    return pong(n - 1, acc + 1)


def pong(n: int, acc: int) -> int:
    if n == 0:
        return acc
    return ping(n - 1, acc + 1)


if __name__ == "__main__":
    sys.setrecursionlimit(100000)
    n = 800
    rounds = 2000
    total = 0
    for _ in range(rounds):
        total += ping(n, 0)
    print(total)
