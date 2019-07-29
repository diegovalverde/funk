use s2d


cantor(_, _, l, _ | l < 1): 1.

cantor(x, y, l, h ):
    s2d_line(x, y, x+l, y, 1.0, 1.0, 1.0, 1.0, 100.0)
    y_ <- y + h
    cantor(x, y_ , l/3, h)
    # 2/3 constant does not seem to work
    cantor(x + l * 0.666666666, y_, l/3, h ).

s2d_render():
    cantor(0.0, 0.0,800, 120.0 )
    s2d_render().

main():
    s2d_window('cantor series', 800, 600 )
    s2d_render().
