# Mutual recursion benchmark (call overhead + branchless recursion).

ping(0, acc): acc.
ping(n, acc): pong(n - 1, acc + 1).

pong(0, acc): acc.
pong(n, acc): ping(n - 1, acc + 1).

run_ping(0, _, acc): acc.
run_ping(k, n, acc): run_ping(k - 1, n, acc + ping(n, 0)).

main():
    n <- 800
    rounds <- 2000
    say(run_ping(rounds, n, 0))
    1.
