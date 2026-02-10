#!/usr/bin/env python3


def sum_range(n: int) -> int:
    acc = 0
    while n > 0:
        acc += n
        n -= 1
    return acc


if __name__ == "__main__":
    n = 12000
    rounds = 29
    total = 0
    for _ in range(rounds):
        total += sum_range(n)
    print(total)
