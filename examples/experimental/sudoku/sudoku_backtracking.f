use find, unique, fread_list


do_until_success(_,[1,B]): [1,B].
do_until_success([],_): [0,[]].
do_until_success( f <~ [functions], [0,_]) : 
     func <- f[0]
     done <- func(f[1])
     do_until_success(functions, done).

replace(M, p, q, v | p = q ): v.
replace(M, _, [i,j], _ ): M[i,j].

m_replace_element(M, v, pos):
   [ [ replace(M,pos,[i,j], v) | 0 <= j < len(M[0])] | 0 <= i < len(M) ].

is_valid(B, v, [i,j]):
    x <- [B[i]] ++ [B[0..-1, j]]
    -1* find(v,unique([x] ++ [flatten(B[3*(i/3)  .. 3*(i/3)+2, 3*(j/3) .. 3*(j/3)+2])])).


get_next_empty_position(B): 
    p <- find(0,flatten(B))
    [p / 9, p % 9].

solve_sudoku(B | find(0,flatten(B)) = -1): [1,B]. 
solve_sudoku(B):
    pos <- get_next_empty_position(B)
    do_until_success([ [s1, [B,v,pos]  ] | 1 <= v <=  9],[0,[]]).

s1([B, v, pos] | is_valid(B,v,pos) != 1): [0,[]].
s1([B, v, pos]): 
    M <- m_replace_element(B, v, pos)
    solve_sudoku(M).
    
main():
    B <- reshape(fread_list('/Users/diego/workspace/projects/funky_programming_language/examples/experimental/sudoku/puzzle1.txt'),9,9)
    solution <- solve_sudoku(B) 
    say('solution\n',solution)
    1.