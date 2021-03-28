use bfs, sem_matrix, shift_matrix, sort, count, all

FINAL <-> [[1, 2, 3],[5, 8, 6],[0, 7, 4]]
INITIAL <-> [[1, 2, 3],[5, 6, 0],[7, 8, 4]]
# heuristic: count of misplaced cells
h(board): board - FINAL.

#is_goal([FINAL, prev_boards,_,_]):
is_goal([board, prev_boards,_,_] | all(h(board),0) = 1 ):
    say('solution: ', prev_boards, board)
    1.
is_goal(_): 0.

# Use A* sort style
sort_criteria([board1, cost1, _], [board2, cost2, _] |
        (cost1 + count(h(board1),0)) < (cost2 + count(h(board2),0))): 1.
sort_criteria(_, _): 0.

next_board(A, [zi,zj], [di, dj] ):
    E <- sem_matrix(3,3, zi + di, zj + dj )
    (roll(A * E, -1*di, -1*dj) + A) * not(E).

get_children([]): [].
get_children([ board , prev_boards, cost, pos ]):
    delta <- [[-1,0], [1,0], [0,1], [0,-1]]
    # compute all reachable children
    children <- [[next_board(board, pos, delta[k]), [prev_boards] <~ board,
    cost+1, pos + delta[k]] | 0 <= k < len(delta) ]
    # return children board sorted by acummuted cost + heuristic
    sort(children, sort_criteria).

main():
    board <- INITIAL
    bfs(is_goal, get_children, [[board,[],0,[1,2]]] ).
