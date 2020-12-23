use sdl

_render_board( [], _, _, _, _, _ ): 1.

_render_board( h <~ [t], k, tlx, tly, w, s ):
    x <- (k % w) * s + tlx
    y <- (k / w) * s + tly

    sdl_set_color(252*h,186*h,3*h)
    sdl_rect(x+1,y+1,s-1,s-1)

    _render_board(t, k + 1, tlx, tly, w, s).

#########################################
#
# tlx: top left x-coord where board starts
# tly: top left y-coord where board starts
# w: number of squares per row
# s: size of a square
#
#########################################
render_board( board, tlx, tly, w, s ):
    _render_board( board, 0, tlx, tly, w, s).
