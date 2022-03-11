use minimax, replace_matrix_element, find, arg_neq, any, all, transpose
MAX_DEPTH <-> 4
H <-> 6
W <-> 7

_check_4(_, _, k | k = 4): 1. 
_check_4([],...): 0. 
_check_4(h <~ [L], v, k | h = v): _check_4(L, v, k + 1).
_check_4(h <~ [L], v, k): _check_4(L,v,0). 
check_4(L,v): _check_4(L,v,0).

check_4x4([], player): 0.
check_4x4(M, player):
    
    T <- transpose(M)
    # say(T)
    # say([check_4( T[i], player ) | 0 <= i < W])
    # say(any([check_4( T[i], player ) | 0 <= i < W],1))

    # say('...')
    # say([ any([check_4( M[i], player ) | 0 <= i < W], 1),    # check rows
    #        any([check_4(T[i], player )  | 0 <= i < H], 1) ]  )

    any( [ any([check_4( M[i], player ) | 0 <= i < H], 1),    # check rows
           any([check_4(T[i], player )  | 0 <= i < W], 1) ], 1 ). # check cols
#   say(M,player)

#   say('checking cols ', flatten(transpose(M)), check_4(flatten(transpose(M)), player ))  
#   say('checking rows ', flatten(M), check_4( flatten(M), player ))
#   exit()
#   say('cols ', [[M[0+i..3+i, j] | 0 <= j <= 3 ] | 0 <= i < H], [ [all(M[i+0..i+3, j], player) | 0 <= j <= 3 ] | 0 <= i < H ])
#   say('----\n\n\n')        
        
#          any([all([M[i,i]   | 0 <= i <= 3 ], player), # check diagonal
#          all([M[3-i,i] | 0 <= i <=3  ], player), # check anti-diagonal
#          all([M[i, 0..3] | 0 <= i <= 3 ], player), # check rows
#          all([M[0..3, j] | 0 <= j <= 3 ], player)], # chek cols
#          player).
         
         
  


is_win(M, player): 
    check_4x4(M, player).
    #any(flatten([[ check_4x4(M[i .. i+3 , j..j+3], player)  |  0 <= j < H ] | 0 <= i <= W]),1).

    
utility_function(M,player | is_win(M,player) = 1): player*infinity().
utility_function(M,player | is_win(M,-1*player) = 1): -1*player*infinity().
utility_function(M, player): 
    # Allis (1988)
    heuristic <- [[3, 4, 5,  7,  5,  4, 3],
                  [4, 6, 8,  9,  8,  6, 4],
                  [5, 8, 11, 13, 11, 8, 5],
                  [5, 8, 11, 13, 11, 8, 5],
                  [4, 6, 8,  9,  8,  6, 4],
                  [3, 4, 5,  7,  5,  4, 3]]
    
    player * sum(heuristic * M).
    
# return index of columns with available places to move
get_legal_moves(M, player): 
    arg_neq([find(0, M[0 .. H-1, j]) | 0 <= j < W ], -1).


make_move(M, col, player): 
    row <- (H - 1) - find(0, reverse(flatten( M[0..H-1, col])))
    replace_matrix_element(M,player,[row,col]).


game_loop(previous_board,... | is_win(previous_board,1)=1): 
    say('Human wins')
    1.

game_loop(previous_board, ... | is_win(previous_board,-1)=1): 
    say('AI wins')
    1.


game_loop(previous_board, depth):
    
    say('please select a move from ', get_legal_moves(previous_board,1))
    human_move <- toi32(in())
    say('you selected ', human_move)
    board <- make_move(previous_board, human_move, 1)
    say(board)

    say('AI is thinking...')
    ai_move <- minimax(board,  depth, -1, utility_function, get_legal_moves, make_move ) #minimax([board, utility_function, make_move, get_legal_moves], MAX_DEPTH )
    new_board <- make_move(board, ai_move, -1 )
    say(new_board)
    game_loop(new_board, depth).


main():
     board <- [[0 | 0 <= j < W ] | 0 <= j < H]
     say(board)
     game_loop( board, 2 ).
