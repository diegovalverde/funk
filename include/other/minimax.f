use max, argmax


search(board, player, 0, get_utility,...): get_utility(board, player).
search(board, player, depth, get_utility, get_legal_moves, make_move):
    tmp <- [search(make_move(board, move, player), -1*player, depth-1, get_utility, get_legal_moves, make_move) |  move : get_legal_moves(board, player)]
    alpha <- max(tmp)
    -1*alpha.


minimax(board,  depth, player, get_utility, get_legal_moves, make_move ):
    legal_moves  <- get_legal_moves(board, player)
    candidates <- [ search( make_move(board, legal_moves[i], player), -1* player, depth-1, get_utility, get_legal_moves, make_move ) | 0 <= i < len(legal_moves)  ]
    say('candidates', candidates)
    ret <- argmax(candidates)
    legal_moves[ret].
