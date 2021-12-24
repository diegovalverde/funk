

# found no solution
bfs(_, _, []):[].

# found a solution


bfs(S, N, explore | S(explore[0]) = 1):
    explore[0].

# add children to search in BFS fashion
bfs(S, N,  n <~ [explore]):
    x <-  N(n)
    bfs( S, N,  [explore] ++ [x] ).
