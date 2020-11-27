use s2d, render_board
W <-> 50
H <-> 50


sum([]): 0.
sum( x <~ [A]):
     x + sum(A).

update_cell(0,3): 1.
update_cell(1, c | c = 2 \/ c = 3): 1.
update_cell(_,_): 0.

update_board(M, i, j):
    cnt <- sum(M[i-1 .. i+1, j-1 .. j+1]) - M[i,j]
    # cnt <- M[i-1, j]  + M[i+1,  j] + M[i, j-1]  +
    #        M[i, j+1]  + M[i-1,j-1] + M[i-1,j+1] +
    #        M[i+1,j-1] + M[i+1,j+1]

    update_cell(M[i,j], cnt).

s2d_render(board):
    render_board(board, 150, 100, W, 10 )
    next_board <- [[update_board(board, i, j) | 0 <= j < W] | 0 <= i < H ]
    sleep(1)
    s2d_render(next_board).

main():
    s2d_window('the game of life', 800, 600 )
    s2d_render(reshape(fread_list('patterns/pulsar.txt'), [W,H])).
