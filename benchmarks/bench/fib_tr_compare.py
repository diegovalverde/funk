#!/usr/bin/env python3

# Tail-recursive style Fibonacci.
# Python does not optimize tail calls, so this is mostly for algorithmic parity.
def fib_tr(n: int, a: int = 0, b: int = 1) -> int:
    if n == 0:
        return a
    return fib_tr(n - 1, b, a + b)


def main() -> int:
    n = 35
    print(fib_tr(n, 0, 1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
