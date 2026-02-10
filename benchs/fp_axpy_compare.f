# BLAS-like DAXPY benchmark reduced to scalar accumulation.

vec_x(n): [i * 0.5 + 1.1 | 0 <= i < n].
vec_y(n): [i * 0.25 + 2.3 | 0 <= i < n].

daxpy_sum([], [], _, acc): acc.
daxpy_sum(x <~ [xs], y <~ [ys], a, acc): daxpy_sum(xs, ys, a, acc + (a * x + y)).

run_daxpy(0, _, _, _, acc): acc.
run_daxpy(k, x, y, a, acc): run_daxpy(k - 1, x, y, a, acc + daxpy_sum(x, y, a, 0.0)).

main():
    n <- 2000
    rounds <- 200
    a <- 1.61803398875
    x <- vec_x(n)
    y <- vec_y(n)
    say(run_daxpy(rounds, x, y, a, 0.0))
    1.
