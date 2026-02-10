#!/usr/bin/env python3


def collatz_steps(n: int) -> int:
    steps = 0
    while n != 1:
        if (n % 2) == 0:
            n //= 2
        else:
            n = 3 * n + 1
        steps += 1
    return steps


def sum_collatz(n: int) -> int:
    acc = 0
    while n > 0:
        acc += collatz_steps(n)
        n -= 1
    return acc


if __name__ == "__main__":
    print(sum_collatz(15000))
