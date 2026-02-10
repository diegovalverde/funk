# Tail-recursive integer accumulation benchmark.

sum_range(0, acc): acc.
sum_range(n, acc): sum_range(n - 1, acc + n).

repeat_sum(0, _, acc): acc.
repeat_sum(k, n, acc): repeat_sum(k - 1, n, acc + sum_range(n, 0)).

main():
    # Keep below int32 max for i32 lowering mode.
    n <- 12000
    rounds <- 29
    say(repeat_sum(rounds, n, 0))
    1.
