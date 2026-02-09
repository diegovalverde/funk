# Branch-heavy integer recursion benchmark.

# Tail-recursive version so TRE can lower this into a loop in generated C++.
collatz_steps(1, acc): acc.
collatz_steps(n, acc | n % 2 = 0): collatz_steps(n / 2, acc + 1).
collatz_steps(n, acc): collatz_steps(3 * n + 1, acc + 1).

sum_collatz(0, acc): acc.
sum_collatz(n, acc): sum_collatz(n - 1, acc + collatz_steps(n, 0)).

main():
    n <- 15000
    say(sum_collatz(n, 0))
    1.
