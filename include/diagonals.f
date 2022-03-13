
diagonals(M):
    upper_diagonals <- [ [M[    i, k + i] | 0 <= i < (len(M) - k) ] | 1 <= k <len(M) ]
    lower_diagonals <- [ [M[k + i, 0 + i] | 0 <= i < (len(M) - k) ] | 0 <= k <len(M) ]
    [upper_diagonals] ++ [lower_diagonals].
