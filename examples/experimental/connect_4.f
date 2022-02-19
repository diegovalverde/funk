use any, all, arg_eq, min, max, find
H <-> 6
W <-> 7
# Allis (1988)
VALUES <- [[3,4,5,7,5,4,3], [4,6,8,9,8,6,4],[5,8,11,13,11,8,5],[5,8,11,13,11,8,5],[4,6,8,9,8,6,4],[3,4,5,7,5,4,3]]

heuristic(M,player): sum(VALUES * player * M).

check_4x4(M, player):
    any(all([ S[i,i] | 0 <= i <= 3 ],  player),
        all([ S[3-i,i] | 0 <= i <=3 ], player),
        all(S[i, 0..3]) | 0 <= i <= 3],player),
        all(S[0..3, j]) | 0 <= j <= 3 ],player)).

# Slinding Window
is_win(M, player):
    any([[check_4x4(M[i .. i+4 , j..j+4], player) |  0 <= j < W] | 0 <= i <= H ], 1).

# return index of columns with at least a zero
get_valid_cols(M): arg_eq([find(0, M[0:H, j]) | 0 <= j < W ], 1).

 
move(M, col, player): 
    l <- M[0..H, 0..col-1]
    m <- M[0..H, col] 
    find(0, H - reverse(flatten(m))
    [m] ++ M[0..H, col+1..W].

minimax(M, _, player | is_win(maximizingPlayer)): 1000.
minimax(M, _, player | is_win(minimizingPlayer)): -1000.
minimax(M, 0, player): heuristic(M,player).

minimax(M, depth, player  | player = maximizingPlayer):
        max([ minimax( move(M, col, player), depth-1, minimizingPlayer)) |
            col : get_valid_cols(M)]).

minimax(M, depth, player  | player = minimizingPlayer):
        min([ minimax( move(M, col, player), depth-1, maximizingPlayer)) |
            col : get_valid_cols(M)]).
