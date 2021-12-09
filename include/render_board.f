use sdl

render_cell([], _, _, _, _, _ ): 1. # can improve syntax like render_cell([], _...): 1
render_cell(val <~ [row], i, j, tlx, tly, s):
    #info(row)
    sdl_set_color(252*val,186*val,3*val)
    x <- i * s + tlx
    y <- j * s + tly
    sdl_rect(x+1,y+1,s-1,s-1)
    render_cell(row, i, j+1, tlx, tly, s).


_render([], _, _, _, _, _): 1.
_render(row <~ [board],i,j, tlx, tly, s):
    #info(board)
    render_cell(row, i, j, tlx, tly, s)
    _render(board,i+1,j, tlx, tly, s).

render_board(board, tlx, tly, s):
    _render(board, 0, 0, tlx, tly, s).
    # info(B)
    # [[ j |
    #          0 < j < 3]| 0 <= i < 3]
    #          1.
    # 1.
    # dummy <- [[ render_cell(B[i,j], i, j, tlx, tly, s) |
    #         0 < j < len(B)]| 0 <= i < len(B[0])]
    #         1.
