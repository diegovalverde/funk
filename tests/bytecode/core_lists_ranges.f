fib(0): 0.
fib(1): 1.
fib(n | n > 1): fib(n - 1) + fib(n - 2).
fib(_): 0.

main():
    arr <- [1,2,3,4]
    all <- arr[..]
    mid <- arr[1..2]
    tail <- arr[2..]
    head <- arr[..1]
    s <- sum(all)
    fl <- len(flatten([[1],[2,[3]]]))
    n <- fib(6)
    s - 10 + len(mid) - 2 + len(tail) - 2 + len(head) - 2 + fl - 3 + n - 8.
