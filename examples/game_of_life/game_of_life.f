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

 update_board(tr, mr, br, k, w, h | k = (w*h)): [].

 update_board(tr, mr, br, k, w, h | k >= (w*(h-1))):
    idem(0) ~>[ update_board(tr, mr, br, k+1, w, h)].

 update_board(tr, mr, br, k, w, h | (k / w) = 0 \/ (k % w) = 0):
    idem(0) ~>[ update_board(tr, mr, br, k+1, w, h)].

 update_board(a <~ [tr], b <~ [mr], c <~ [br],k ,w, h| (k % w) = (w-1)):
    idem(0) ~>[ update_board(nth(tr,1), nth(mr,1), nth(br,1), k+1, w, h)].

 update_board(tr, mr, br,k, w,h | (k / w) = (w-1)):
    idem(0) ~>[ update_board(tr, mr, br, k+1, w, h)].

 update_board(a <~ [tr], b <~ [mr], c <~ [br],k,w,h):
    cnt <- a + b + c + br + tr + nth(tr,1) + nth(mr, 1) + nth(br,1)
    update_cell(mr, cnt) ~> [ update_board( tr, mr, br, k+1, w, h )].

s2d_render(board):
    w <- 50
    h <- 30
    next_board <-  update_board(board, nth(board,w), nth(board,2*w), 0, w, h)
    render_board(next_board, 150, 100, w, 10 )
    sleep(1)
    s2d_render(next_board).

main():
    board <- fread_list('examples/game_of_life/pulsar.txt')
    s2d_window('the game of life', 800, 600 )
    s2d_render(board).
