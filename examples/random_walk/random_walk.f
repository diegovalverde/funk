use s2d

walk(n,prev_x, prev_y | n = 0): 1.

walk(n, prev_x, prev_y):
    x <- prev_x + rand_float(-10., 10.)
    y <- prev_y + rand_float(-10., 10.)
    s2d_line(prev_x,prev_y, x, y, 1,0,0,1,2)
    walk(n - 1, x, y).

s2d_render():
    walk( 1000, 400.0, 300.0)
    s2d_render().

main():
    s2d_window('random walk', 800, 600 )
    s2d_render().
