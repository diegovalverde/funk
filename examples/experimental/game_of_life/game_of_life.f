use s2d, render_board
W <-> 50
H <-> 50


update_cell(0,3): 1.
update_cell(1, c | c = 2 \/ c = 3): 1.
update_cell(_,_): 0.

update_board(M, i, j | i - 1 < 0 \/ j - 1 < 0 \/ i + 1 >= H  \/ j + 1 >= W): 0.

update_board(M, i, j):
    cnt <- M[i-1, j] + M[i+1, j] + M[i, j-1] + M[i, j+1] + M[i-1,j-1] + M[i-1,j+1]+ M[i+1,j-1] + M[i+1,j+1]
    x <- M[i,j]
    update_cell(x, cnt).

s2d_render(board):
    render_board(board, 150, 100, W, 10 )
    next_board <- [[update_board(board, i, j) | 0 <= j < W] | 0 <= i < H ]
    sleep(1)
    s2d_render(next_board).

main():
    s2d_window('the game of life', 800, 600 )
    s2d_render(reshape(fread_list('patterns/pulsar.txt'), [W,H])).
