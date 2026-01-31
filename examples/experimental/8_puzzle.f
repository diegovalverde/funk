use bfs, sem_matrix, shift_matrix, sort, count, all, find, roll

#FINAL <-> [[1, 2, 3],[5, 8, 6],[0, 7, 4]]
#INITIAL <-> [[1, 2, 3],[5, 6, 0],[7, 8, 4]]

FINAL <-> [[1, 2, 3],[4, 5, 6],[7, 8, 0]]
INITIAL <-> [[0, 1, 3],[6, 5, 2],[4, 7, 8]]

inside([x1,y1],[x2,y2], [x, y] | x >= x1 ):
    inside_y(x1, y1, x2, y2, x, y).
inside(_,_,p):
    say('out',p)
    [].

inside_y(x1, y1, x2, y2, x, y | x < x2 ):
    inside_y2(x1, y1, x2, y2, x, y).
inside_y(_, _, _, _, _, y):
    say('out',[y])
    [].

inside_y2(x1, y1, x2, y2, x, y | y >= y1 ):
    inside_y3(x1, y1, x2, y2, x, y).
inside_y2(_, _, _, _, _, y):
    say('out',[y])
    [].

inside_y3(_, _, _, y2, x, y | y < y2):
    point <- [x,y]
    say('inside', point)
    point.
inside_y3(_, _, _, _, x, y):
    say('out',[x,y])
    [].

points_in_rec([], _, _ ): [].
points_in_rec(p <~ [points], p1, p2  ):
    say('p', p, points)
    inside(p1, p2, p) ~> [points_in_rec(points, p1,p2)].


# heuristic: count of misplaced cells
h([]): [].
h(board): board - FINAL.

#is_goal([FINAL, prev_boards,_,_]):

is_goal([board, prev_boards,_,_] | all(h(board),0) = 1 ):
    say('solution: ', prev_boards, board)
    1.
is_goal(_): 0.

# Use A* sort style
sort_criteria([board1, _, cost1, _], [board2, _, cost2, _] |
        (cost1 + count(h(board1),0)) < (cost2 + count(h(board2),0))):
        say('baord1', board1, 'cost1', cost1)
        say('baord2', board2, 'cost2', cost2)
        1.
sort_criteria(_, _):
    say('somethings fishy')
    0.

# unexplored(boards, [] ): boards.
# unexplored(b <~ [boards], explored_list | find(b, explored_list) = 0):
#     b ~> [unexplored(boards, explored_list)].
# unexplored(boards, explored_list ):
#     unexplored(boards, explored_list).

unexplored([], _ , _): [].
unexplored(b <~ [next_boards], explored_list, i | find(b, explored_list) = 0):
    i ~> [unexplored(next_boards,explored_list, i+1)].
unexplored(next_boards, explored_list, i ):
    unexplored(next_boards, explored_list, i+1 ).

next_board(A, [zi,zj], [di, dj] ):
    E <- sem_matrix(3,3, zi + di, zj + dj )
    (roll(A * E, -1*di, -1*dj) + A) * (1 - E).
get_children([]): [].


# get_children([ board , prev_boards, cost, pos ]):
#     delta <- [[-1,0], [1,0], [0,1], [0,-1]]
#     x <- [ [delta[k] + pos] | 0 <= k < len(delta) ]
#     # x <- [ [d + pos] | d : delta ]
#
#     # carp <- [next_board(board, pos, delta[k] + pos) | 0 <= k < len(delta) ]
#     # say('crap', crap)
#
#     say('x',x)
#     new_pos <- points_in_rec(x, [0,0],[3,3])
#     say('new_pos',new_pos, len(new_pos))
#
#     next_boards <- unexplored([[next_board(board, pos, new_pos[k]), new_pos[k]] |
#         0 <= k < len(new_pos)  ], prev_boards)
#
#     #next_boards <- unexplored([[next_board(board, pos, npos), npos] |
#     #   npos : new_pos  ], prev_boards)
#
#     say(len(next_boards), 'next_boards', next_boards)
#     i <- 0
#     j <- 0
#     say(next_boards[i,j], '....', next_boards[i,j+1])
#     #exit()
#
#     # children <- [[next_boards[k]] ++ [[prev_boards] <~ board, cost+1] |
#     #     0 <= k < len(next_boards) ]
#
#     children <- [[next_boards[k,i],
#          [prev_boards] <~ board,
#          cost+1, next_boards[k, i+1]] | 0 <= k < len(next_boards) ]
#
#     say('children', children, len(children))
#
#     s <- sort(children, sort_criteria)
#     say('sorted', s)
#     s.


    get_children([ board , prev_boards, cost, pos ]):
        say(' &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& get_children ==============')
        say('board', board , 'prev_boards', prev_boards, 'cost', cost, 'pos', pos)
        delta <- [[-1,0], [1,0], [0,1], [0,-1]]

        x <- [ [delta[k] + pos] | 0 <= k < len(delta) ]

        say('x',x)
        new_pos <- points_in_rec(x, [0,0],[3,3])
        # x <- [ [d + pos] | d : delta ]
        next_boards <- [[next_board(board, pos, new_pos[k])  ] |
            0 <= k < len(new_pos)  ]

        idx <- unexplored(next_boards, prev_boards ,0)

        children <- [[next_boards[ idx[k] ],
             [prev_boards] <~ board,
             cost+1, new_pos[idx[k]]] | 0 <= k < len(idx) ]

        say('children', children, len(children))

        s <- sort(children, sort_criteria)
        say('sorted', s)
        s.


# get_children([ board , prev_boards, cost, pos ]):
#     delta <- [[-1,0], [1,0], [0,1], [0,-1]]
#     # compute all reachable children
#     # need to remove explored!
#     say('prev_boards', prev_boards)
#     children <- [[unexplored(next_board(board, pos, delta[k]),prev_boards),
#         [prev_boards] <~ board,
#         cost+1, pos + delta[k]] | 0 <= k < len(delta) ]
#     # return children board sorted by acummuted cost + heuristic
#     sort(children, sort_criteria).

main():

    board <- INITIAL
    empty <- []
    bfs(is_goal, get_children, [[board,[empty],0,[0,0]]] ).
