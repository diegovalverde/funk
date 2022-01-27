use sdl_simple

barnsley(n , prev_x, prev_y, r  | n = 0): 1.

barnsley(n , prev_x, prev_y, r | r < 1.):
    x <- 0.
    y <- 0.16 * prev_y
    sdl_point((50.*x) + 150., (50.*y) + 80)
    barnsley(n-1, x, y, rand_float(0.0, 100.0) ).


barnsley(n , prev_x, prev_y, r | r < 86.):
    x <- 0.85 * prev_x + 0.04 * prev_y
    y <- (0.85 * prev_y - 0.04 * prev_x) +1.6
    sdl_point((50.*x) + 150., (50.*y) + 80.)
    barnsley(n-1, x, y, rand_float(0.0, 100.0) ).


barnsley(n , prev_x, prev_y, r | r < 93.):
    x <- 0.2 * prev_x - 0.26 * prev_y
    y <- (0.23 * prev_y + 0.22 * prev_y) + 1.6
    sdl_point((50.*x) + 150., (50.*y) + 80.)
    barnsley(n-1, x, y, rand_float(0.0, 100.0) ).


barnsley(n , prev_x, prev_y, r ):
    x <- 0.28* prev_y - 0.15 * prev_x
    y <- (0.26 * prev_x + 0.24 * prev_y) + 0.44

    sdl_point((50.*x) + 150., (50.*y) + 80.)
    barnsley(n - 1, x, y, rand_float(0., 100.) ).


sdl_render(ctx):
    barnsley(10000, 0.0, 0.0, rand_float(0.0, 100.0) )
    #sleep(1)
    sdl_render(ctx).

main():

    sdl_simple(510, 510,[]).
