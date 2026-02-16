#!/usr/bin/env python3


def row(n: int):
    return [1 for _ in range(n)]


def concat_rows(k: int, n: int, acc):
    for _ in range(k):
        acc = acc + row(n)
    return acc


def main() -> int:
    res = concat_rows(3000, 8, [])
    print(len(res))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
