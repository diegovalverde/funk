check_4x4(M, player):
    # diagonal / antidiagonal
    any(all([ S[i,i] | 0 <= i <= 3 ],  player),
        all([ S[3-i,i] | 0 <= i <=3 ], player),
    # rows / cols
        all(S[i, 0..3]) | 0 <= i <= 3],player),
        all(S[0..3, j]) | 0 <= j <= 3 ],player)).

# Slinding Window
is_win(M, player):
    any([[check_4x4(M[i .. i+4 , j..j+4], player) | 
            0 <= j < -4] | 0 <= i <= -4 ], 1).

# return columns with at least a zero
get_valid_cols(M): arg_eq([find(0, M[0:H, j]) | 0 <= j < W ], 1).

minimax(M, _, player | is_win(maximizingPlayer)): 1000.
minimax(M, _, player | is_win(minimizingPlayer)): -1000.

minimax(M, depth, player | depth=0): heuristic(M,player).

minimax(M, depth, player  | player = maximizingPlayer):
        max([ minimax( move(M, col, player), depth-1, minimizingPlayer)) |
            col : get_valid_cols(M)]).

minimax(M, depth, player  | player = minimizingPlayer):
        min([ minimax( move(M, col, player), depth-1, maximizingPlayer)) |
            col : get_valid_cols(M)]).
