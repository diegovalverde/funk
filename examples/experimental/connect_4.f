use any, all, arg_neq, min, max, find, replace_matrix_element, neg, argmax, argmin
use get_first_not_of, sort
H <-> 6
W <-> 7
minimizingPlayer <-> -1
maximizingPlayer <-> 1
# Allis (1988)
VALUES <-> [[3,4,5,7,5,4,3], [4,6,8,9,8,6,4],[5,8,11,13,11,8,5],[5,8,11,13,11,8,5],[4,6,8,9,8,6,4],[3,4,5,7,5,4,3]]


    

heuristic(M,player): 
    
    h <- player * sum(VALUES * M)
    say('heuristic ',player,  h)
    h.

check_4x4([], player): 0.
check_4x4(M, player):
    # say(player, 'check_4x4 ', M)
    # say('diagonal ', [M[i,i]   | 0 <= i <= 3 ], all([M[i,i]   | 0 <= i <= 3 ], player))
    # say('anti-diagonal ',[ M[3-i,i] | 0 <= i <=3  ], all([M[3-i,i] | 0 <= i <=3  ], player))
    # say('rows ', [M[i, 0..3] | 0 <= i <= 3 ], all([M[i, 0..3] | 0 <= i <= 3 ], player))
    # say('cols ', [M[0..3, j] | 0 <= j <= 3 ], all([M[0..3, j] | 0 <= j <= 3 ], player))
     result <- any([all([M[i,i]   | 0 <= i <= 3 ], player), # check diagonal
         all([M[3-i,i] | 0 <= i <=3  ], player), # check anti-diagonal
         all([M[i, 0..3] | 0 <= i <= 3 ], player), # check rows
         all([M[0..3, j] | 0 <= j <= 3 ], player)], # chek cols
         player)
         
         
         #say('result\n', result)
         result.
  

# Slinding Window
is_win(M, player): 
    #say(player, '>>> \n', [[ check_4x4(M[i .. i+3 , j..j+3], player)  |  0 <= j < H ] | 0 <= i <= W])
    any(flatten([[ check_4x4(M[i .. i+3 , j..j+3], player)  |  0 <= j < H ] | 0 <= i <= W]),1).
    
# return index of columns with available places to move
get_legal_moves(M): 
    arg_neq([find(0, M[0 .. H-1, j]) | 0 <= j < W ], -1).


custom_function(l,r | l[0] >= r[0]): 1.
custom_function(l,r ): 0.

# assign a value to each of the legal moves
choose_next_moves(M):
    M1 <- neg(M) * VALUES 

    
    #say('pppppp ', M1)
    #say('get_legal_moves(M)',get_legal_moves(M))
    #say('[ reverse(M1[0 .. H-1, j])| j : get_legal_moves(M)]', [ reverse(M1[0 .. H-1, j])| j : get_legal_moves(M)])
    #say('[ get_first_not_of(0,reverse(M1[0 .. H-1, j]))| j : get_legal_moves(M)]', [ get_first_not_of(0,reverse(M1[0 .. H-1, j]))| j : get_legal_moves(M)])
    
    #say([ find_ne(0,reverse(M1[0 .. H-1, j]))| j : get_legal_moves(M)])
    L <- [ get_first_not_of(0,reverse(M1[0 .. H-1, j]))| j : get_legal_moves(M)]
    l1 <- [ [L[i],i] | 0 <= i < len(L) ]
    k <- [ v[1] | v : sort(l1, custom_function)]
    say('k = ',k)
    k.

move(M, col, player): 
    row <- (H - 1) - find(0, reverse(flatten( M[0..H-1, col])))
    say('moving to row, col ', row, col)
    M1 <- replace_matrix_element(M,player,[row,col])
    say('------>\n', M1)
    M1.
    
minimax(M,_,maximizingPlayer | is_win(M, maximizingPlayer) = 1): 
    say('is win ', M)
    1000.
minimax(M,_,minimizingPlayer | is_win(M, minimizingPlayer) = 1): 
    say('is loose')
    -1000.
minimax(M, 0, player): 
    say('heuristic')
    heuristic(M,player).

minimax(M, depth, player  | player = maximizingPlayer):
       
        max([ minimax( move(M, col, minimizingPlayer), depth-1, minimizingPlayer) | col : choose_next_moves(M) ]).

minimax(M, depth, player  | player = minimizingPlayer):
        
        min([ minimax( move(M, col, maximizingPlayer), depth-1, maximizingPlayer) |
            col : choose_next_moves(M)]).


main():
    M <- [[0 | 0 <= j < 7 ] | 0 <= j < 6]
    say(M)
    next_move <- minimax(M,1,maximizingPlayer)
    say('Next move ',next_move )
    say(move(M, next_move, maximizingPlayer))
    1.