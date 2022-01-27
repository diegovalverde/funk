use sdl_simple


render_cell(val , i, j, tlx, tly, s):
    sdl_set_color(252*val,186*val,3*val)
    x <- i * s + tlx
    y <- j * s + tly
    sdl_rect(x+1,y+1,s-1,s-1).


render_board(B, tlx, tly, s):
    [[ render_cell(B[i,j], i, j, tlx, tly, s) | 0 < j < len(B)]| 0 <= i < len(B[0])]
    1.
