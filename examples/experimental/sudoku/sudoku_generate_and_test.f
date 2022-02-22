use fread_list, unique, find

replace(M, p, q, v | p = q ): v.
replace(M, _, [i,j], _ ): M[i,j].

m_replace_element(M, v, pos):
   [ [ replace(M,pos,[i,j], v) | 0 <= j < len(M[0])] | 0 <= i < len(M) ].

get_candidates(B, [i,j]):
    x <- [B[i]] ++ [B[0..-1, j]]
    y <- [i | 1 <= i <= 9]
    [y] -- [unique([x] ++ [flatten(B[3*(i/3)  .. 3*(i/3)+2, 3*(j/3) .. 3*(j/3)+2])])].
    

find_next_empty_cell(M):
    n <- find(0, flatten(M))
    [n/9, n % 9].

solve(B, _, _ | find(0,flatten(B)) = -1): 
    say('The solution is', B)
    exit()
    B.

solve(B, i,j | B[i,j] != 0): [].
solve([], _,_): [].


solve(B, i,j):
    pos <- [i,j]  
    [[[ solve( m_replace_element(B,c,pos), l, k ) | c : get_candidates(B,pos) ]| 0 <= k <= 8] | 0 <= l <= 8].

main():
    B <- reshape(fread_list('examples/experimental/sudoku/board.txt'),9,9)
    [[solve(B, i,j) | 0 <= j <= 8] | 0 <= i <= 8].
