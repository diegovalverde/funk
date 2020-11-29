use s2d, render_board, sum
W <-> 50
H <-> 50

update_cell(0,3): 1.
update_cell(1, c | c = 2 \/ c = 3): 1.
update_cell(_,_): 0.

s2d_render(M):
    say(M)
    render_board(M, 150, 100, W, 10 )
    
    next_board <- [[update_cell(M[i,j],
                   sum(M[i-1 .. i+1, j-1 .. j+1]) - M[i,j]) |
                   0 <= j < W] | 0 <= i < H ]

    sleep(1)
    s2d_render(next_board).

main():
    s2d_window('the game of life', 800, 600 )
    s2d_render(reshape(fread_list('patterns/pulsar.txt'), [W,H])).
