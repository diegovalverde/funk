use any, all, arg_eq, min, max, find, reverse, replace_matrix_element
H <-> 6
W <-> 7
minimizingPlayer <-> -1
maximizingPlayer <-> 1
# Allis (1988)
VALUES <-> [[3,4,5,7,5,4,3], [4,6,8,9,8,6,4],[5,8,11,13,11,8,5],[5,8,11,13,11,8,5],[4,6,8,9,8,6,4],[3,4,5,7,5,4,3]]

heuristic(M,player): sum(VALUES * player * M).

check_4x4(M, player):
    any([all([ S[i,i]   | 0 <= i <= 3 ], player), # check diagonal
         all([ S[3-i,i] | 0 <= i <=3  ], player), # check anti-diagonal
         all([S[i, 0..3] | 0 <= i <= 3 ], player), # check rows
         all([S[0..3, j] | 0 <= j <= 3 ], player)], # chek cols
         player).
  

# Slinding Window
is_win(M, player): 
    any(flatten([[ check_4x4(M[i .. i+3 , j..j+3], player)  |  0 <= j < W ] | 0 <= i <= H]),1).
    
# return index of columns with at least a zero
get_valid_cols(M): arg_eq([find(0, M[0 .. H, j]) | 0 <= j < W ], 1).


move(M, col, player): 
    row <- find(0, reverse(flatten( M[0..H, col])))
    replace_matrix_element(M,player,[row,col]).
    
minimax(M,_,maximizingPlayer | is_win(M, maximizingPlayer) = 1): 1000.
minimax(M,_,minimizingPlayer | is_win(M, minimizingPlayer) = 1): -1000.
minimax(M, 0, player): heuristic(M,player).

minimax(M, depth, player  | player = maximizingPlayer):
        max([ minimax( move(M, col, player), depth-1, minimizingPlayer) |
            col : get_valid_cols(M)]).

minimax(M, depth, player  | player = minimizingPlayer):
        min([ minimax( move(M, col, player), depth-1, maximizingPlayer) |
            col : get_valid_cols(M)]).


main():
    M <- [[0 | 0 <= j < 7 ] | 0 <= j < 6]
    next_board <- minimax(M,10,maximizingPlayer)
    say('Next Board',next_board )
    1.