use max, argmax


 max_cmp_fn(a, b | a[1] >= b[1]) : a.
 max_cmp_fn(a, b) : b.

search(board, player, 0, get_utility,...): get_utility(board, player).
search(board, player, depth, get_utility, get_legal_moves, make_move):
    
    #legal_moves <- [ make_move(board, move, player) | move : get_legal_moves(board, player)]
    #say('START search ', board, ' depth ', depth)


    #alpha <- max([search(make_move(board, move, player), -1*player, depth-1, get_utility, get_legal_moves, make_move) |  move : get_legal_moves(board, player)])
    tmp <- [search(make_move(board, move, player), -1*player, depth-1, get_utility, get_legal_moves, make_move) |  move : get_legal_moves(board, player)]
    alpha <- max(tmp)
    #say('END search ', board, ' depth ', depth)
    #say(get_legal_moves(board, player))
    #say('alpha ', tmp, alpha)
    -1*alpha.


minimax(board,  depth, player, get_utility, get_legal_moves, make_move ):
    legal_moves  <- get_legal_moves(board, player)
    candidates <- [ search( make_move(board, legal_moves[i], player), -1* player, depth-1, get_utility, get_legal_moves, make_move ) | 0 <= i < len(legal_moves)  ]
    say('candidates', candidates)
    ret <- argmax(candidates)
    #say('ret', ret)
    legal_moves[ret].
# use max, min

# MAX_PLAYER <-> -1
# MIN_PLAYER <-> 1

# max_cmp_fn(a, b | a[1] >= b[1]) : a.
# max_cmp_fn(a, b) : b.

# min_cmp_fn(a, b | a[1] < b[1]) : a.
# min_cmp_fn(a, b) : b.

# _board <-> 0
# _make_move <-> 2
# _get_legal_moves <-> 3
# _get_utility <-> 1


# alphabeta(MAX_PLAYER, utility, move, _, beta,... | utility >= beta ): [move,utility].
# alphabeta(MIN_PLAYER, utility, move, alpha,... | utility <= alpha ): [move,utility].

# alphabeta(player, utility, move, alpha, beta, game, depth, legal_moves, best_move | player = MAX_PLAYER ):
        
#         val <- max( [[best_move, alpha],[move,utility] ], max_cmp_fn)
#         new_best_move <- val[0]
#         new_alpha <- val[1]
#         say('alphabeta MAX ', val, new_best_move, new_alpha)
#         explore_moves( legal_moves, game, new_best_move, utility, depth, new_alpha, beta, player ).


# alphabeta(player, utility, move, alpha, beta, game, depth, legal_moves, best_move | player = MIN_PLAYER):

#         val <- min( [[best_move, beta],[move,utility] ], min_cmp_fn)
#         new_best_move <- val[0]
#         new_beta <- val[1]
#         say('alphabeta MIN', val, new_best_move,  new_beta)
#         explore_moves( legal_moves, game, new_best_move, utility, depth, alpha, new_beta, player ).


# explore_moves([],_,best_move, utility,...): [best_move, utility].
# explore_moves( _, _, best_move, utility, depth, ... | depth = 0 \/ utility = infinity()): [best_move, utility].
# explore_moves( _, _, best_move, utility, depth, ... | utility = (-1*infinity())): [best_move, utility].

# explore_moves( move <~ [legal_moves], game, best_move, utility, depth, alpha, beta, player):
#         say('========= explore_moves ======== depth', depth)
#         make_move <- game[_make_move]
#         next_board <- make_move(game[_board], move, player)
#         say(player,' exploring move ', move, '\n', next_board  , 'depth ', depth)
#         fu <-  next_board ~> [ game[1 .. -1] ]  
#         val <- _minimax(fu, depth - 1, alpha, beta, -1*player)
        
#         say(player, val, alpha, beta, 'DONE exploring move ', move,  'depth ', depth, 'val = ', val[1])
#         alphabeta(player, val[1], move, alpha, beta, game, depth, legal_moves, best_move ).
               
         
        

#  _minimax( game, depth, alpha, beta, player): 
#         say('player ',player, ' ========= _minimax ======== depth', depth)
#         get_legal_moves <- game[_get_legal_moves]
#         legal_moves <- get_legal_moves(game[_board], player)
#         best_move <- legal_moves[0]
#         get_utility <- game[_get_utility]
#         utility <- get_utility(game[_board], player) 
#         say('utility ', utility)
#         res <- explore_moves(legal_moves, game, best_move, utility, depth, alpha, beta, player)
#         say('==== Best move for player ', player , 'is ', res)
#         res.
          

# minimax( game, depth): 
#     alpha <- -1*infinity()
#     beta <- infinity()
#     result <- _minimax( game, depth, alpha, beta, MAX_PLAYER)
#     best_move <- result[0]
#     utility <- result[1]
#     say('====== RESULT ========')
#     say('best move is ', best_move, ' with utlity of ', utility)
#     best_move.