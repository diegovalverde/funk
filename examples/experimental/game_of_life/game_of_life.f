use sdl_simple, render_board, fread_list
W <-> 50
H <-> 50

update_cell(0,3):1.
update_cell(1, c | c = 2 \/ c = 3):1.
update_cell(_,_): 0.

sdl_render(M):
    render_board(M, 5, 5, 10 )

    next_board <- [[update_cell(M[i,j],
                   sum(M[i-1 .. i+1, j-1 .. j+1]) - M[i,j]) |
                   0 <= j < W] | 0 <= i < H ]

    sdl_set_user_ctx(next_board).

main():
    L <- fread_list('patterns/pulsar.txt')
    sdl_simple(510, 510, reshape(L[2..-1], L[0], L[1]) ).
	