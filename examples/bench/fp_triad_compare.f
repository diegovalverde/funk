# STREAM-like triad benchmark reduced to scalar accumulation.

vec_b(n): [i * 0.5 + 1.1 | 0 <= i < n].
vec_c(n): [i * 0.25 + 2.3 | 0 <= i < n].
vec_d(n): [i * 0.125 + 3.7 | 0 <= i < n].

triad_sum([], [], [], _, acc): acc.
triad_sum(b <~ [bs], c <~ [cs], d <~ [ds], a, acc): triad_sum(bs, cs, ds, a, acc + (b + a * c + d)).

run_triad(0, _, _, _, _, acc): acc.
run_triad(k, b, c, d, a, acc): run_triad(k - 1, b, c, d, a, acc + triad_sum(b, c, d, a, 0.0)).

main():
    n <- 2000
    rounds <- 200
    a <- 0.31415926535
    b <- vec_b(n)
    c <- vec_c(n)
    d <- vec_d(n)
    say(run_triad(rounds, b, c, d, a, 0.0))
    1.
