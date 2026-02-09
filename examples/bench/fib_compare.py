#!/usr/bin/env python3

def fib(n: int) -> int:
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)


def main() -> int:
    n = 35
    print(fib(n))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
