# Branch-heavy integer recursion benchmark.

collatz_steps(1): 0.
collatz_steps(n | n % 2 = 0): 1 + collatz_steps(n / 2).
collatz_steps(n): 1 + collatz_steps(3 * n + 1).

sum_collatz(0, acc): acc.
sum_collatz(n, acc): sum_collatz(n - 1, acc + collatz_steps(n)).

main():
    n <- 15000
    say(sum_collatz(n, 0))
    1.
