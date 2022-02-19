use find, unique, do_until_success, replace_matrix_element

is_valid(B, v, [i,j]):
    x <- [B[i]] ++ [B[0..-1, j]]
    -1* find(v,unique([x] ++ [flatten(B[3*(i/3)  .. 3*(i/3)+2, 3*(j/3) .. 3*(j/3)+2])])).

get_next_empty_position(B): 
    p <- find(0,flatten(B))
    [p / 9, p % 9].

sudoku_backtracking(B | find(0,flatten(B)) = -1): [1,B]. 
sudoku_backtracking(B):
    pos <- get_next_empty_position(B)
    do_until_success([ [solve, [B,v,pos]  ] | 1 <= v <=  9]).

solve([B, v, pos] | is_valid(B,v,pos) != 1): [0,[]].
solve([B, v, pos]): 
    M <- replace_matrix_element(B, v, pos)
    sudoku_backtracking(M).
