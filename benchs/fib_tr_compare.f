# Tail-recursive Fibonacci benchmark.
# fib_tr(n, a, b) carries state in accumulators so recursion is in tail position.

fib_tr(0, a, _): a.
fib_tr(n, a, b): fib_tr(n - 1, b, a + b).

main():
    # Keep n aligned with the existing fib benchmark so timings are comparable.
    n <- 35
    say(fib_tr(n, 0, 1))
    1.
