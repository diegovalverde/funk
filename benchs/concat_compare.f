# List-heavy benchmark for cross-language comparison.

row(n): [1 | 0 <= i < n].

concat_rows(0, _, acc): acc.
concat_rows(k, n, acc): concat_rows(k - 1, n, [acc] ++ [row(n)]).

main():
    res <- concat_rows(3000, 8, [])
    say(len(res))
    1.
