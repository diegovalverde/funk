# BLAS-like DDOT benchmark (double precision).

vec_x(n): [i * 0.5 + 1.1 | 0 <= i < n].
vec_y(n): [i * 0.25 + 2.3 | 0 <= i < n].

dot([], [], acc): acc.
dot(x <~ [xs], y <~ [ys], acc): dot(xs, ys, acc + x * y).

run_dot(0, _, _, acc): acc.
run_dot(k, x, y, acc): run_dot(k - 1, x, y, acc + dot(x, y, 0.0)).

main():
    n <- 2000
    rounds <- 200
    x <- vec_x(n)
    y <- vec_y(n)
    say(run_dot(rounds, x, y, 0.0))
    1.
