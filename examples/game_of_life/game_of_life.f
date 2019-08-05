use nth, idem, accumn, s2d, render_board, len, foreach, set_k, map

# Any live cell with fewer than two live neighbours dies
update_cell(alive, cnt |  alive = 1 /\ cnt < 2 ): 0.

# Any live cell with two or three live neighbours lives
update_cell(alive, cnt | alive = 1 /\ cnt = 2 ): 1.
update_cell(alive, cnt | alive = 1 /\ cnt = 3 ): 1.

# Any live cell with more than three live neighbours dies
update_cell(alive, cnt | alive = 1 /\ cnt > 3 ): 0.
# Any dead cell with exactly three live neighbours becomes a live cell
update_cell(alive, cnt | alive = 0 /\ cnt = 3 ): 1.

# All others: ie. dead cells with no neighbours remain dead
update_cell(_, _  ): 0.

ub(tr, mr, br, k, i, j, w, h | k = (w*h)): [].

ub(tr, mr, br, k, i, j, w, h | k >= (w*(h-1))):
    idem(0) ~>[ub(tr,mr,br, k+1,(k+1)/w,(k+1)%w,w,h)].


ub(tr, mr, br, k, i,j,w,h | i = 0 \/ j = 0):

    idem(0) ~>[ub(tr,mr,br, k+1,(k+1)/w,(k+1)%w,w,h)].

ub(a <~ [tr], b <~ [mr], c <~ [br],k, i,j,w,h| j = (w-1)):

    idem(0) ~>[ub(nth(tr,1), nth(mr,1), nth(br,1), k+1,(k+1)/w,(k+1)%w,w,h)].

ub(tr, mr, br,k, i,j,w,h | i = (w-1)):

    idem(0) ~>[ub(tr, mr, br, k+1,(k+1)/w,(k+1)%w,w,h)].


ub(a <~ [tr], b <~ [mr], c <~ [br],k,i,j,w,h):
    cnt <- a + b + c + br + tr + nth(tr,1) + nth(mr, 1) + nth(br,1)
    update_cell(mr, cnt) ~> [ub( tr, mr, br, k+1,(k+1)/w,(k+1)%w,w,h )].

s2d_render(board):
    w <- 8
    h <- 5
    next_board <- ub(board, nth(board,w), nth(board,2*w), 0, 0,0,w,h)
    render_board(next_board, 10, 10, w, 80 )

    s2d_render(next_board).

main():
    w <- 8
    h <- 5

    funk_set_config(0,1)
    funk_set_config(1,10)

    board <-  set_k(set_k(set_k([0 | 0 <= cell < 40 ], 19, 1),20,1),21,1)
    say(board)
    s2d_window('the game of life', 800, 600 )
    s2d_render(board).
