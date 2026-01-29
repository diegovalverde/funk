
diagonals(M):
    n <- len(M) / len(M[0])
    upper_diagonals <- [ [M[    i, k + i] | 0 <= i < (n - k) ] | 1 <= k < n ]
    lower_diagonals <- [ [M[k + i, 0 + i] | 0 <= i < (n - k) ] | 0 <= k < n ]
    [upper_diagonals] ++ [lower_diagonals].
