use sdl, render_board
W <-> 50
H <-> 50

update_cell(0,3):1.
update_cell(1, c | c = 2 \/ c = 3):1.
update_cell(_,_): 0.

sdl_render(M):

    #info(M)
    #exit()
    render_board(M, 150, 100, 10 )
    #info(M)
    #exit()

    next_board <- [[update_cell(M[i,j],
                   sum(M[i-1 .. i+1, j-1 .. j+1]) - M[i,j]) |
                   0 <= j < W] | 0 <= i < H ]


    sleep(1)
    sdl_render(next_board).

main():
    x <- fread_list('patterns/pulsar.txt')
    #info(x)
    sdl_window(800, 600,reshape(x, [W,H]) ).
