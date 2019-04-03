use s2d


barnsley(n , prev_x, prev_y, r  | n = 0):
    say(n, 'n = 0').

barnsley(n , prev_x, prev_y, r | r < 1.):

    x <- 0.
    y <- 0.16 * prev_y
    s2d_point((50.*x)+100., (50.*y)+100., 0.0, 1.0, 0.0, 1.0)

    say(y, ' <- 0.16 * ', prev_y )


    barnsley(n-1, x, y, rand_float(0.0, 100.0) ).


barnsley(n , prev_x, prev_y, r | r < 86.):

    x <- 0.85 * prev_x + 0.04 * prev_y
    y <- (0.85 * prev_y - 0.04 * prev_x) +1.6

    say(y, ' <- 0.85 * ', prev_y, ' - 0.04 * ', prev_x, ' +1.6')
    say(x, ' <- 0.85 * ', prev_x, ' + 0.04 * ', prev_y)

    s2d_point((50.*x) + 100., (50.*y) + 100., 0.0, 1.0, 0.0, 1.0)

    barnsley(n-1, x, y, rand_float(0.0, 100.0) ).


barnsley(n , prev_x, prev_y, r | r < 93.):

    x <- 0.2 * prev_x - 0.26 * prev_y
    y <- (0.23 * prev_y + 0.22 * prev_y) + 1.6
    say(r,' ', x, ' ', y, ' C')

    s2d_point((50.*x)+100., (50.*y)+100., 0.0, 1.0, 0.0, 1.0)
    barnsley(n-1, x, y, rand_float(0.0, 100.0) ).


barnsley(n , prev_x, prev_y, r ):
    #say('Default r = ', r)
    x <- 0.28* prev_y - 0.15 * prev_x
    y <- (0.26 * prev_x + 0.24 * prev_y) + 0.44
    s2d_point((50.*x)+100., (50.*y)+100., 0., 1., 0., 1.)
    say(r,' ', x, ' ', y, ' D')

    barnsley(n - 1, x, y, rand_float(0., 100.) ).


s2d_render():

    barnsley(10000, 0.0, 0.0, rand_float(0.0, 100.0) )
    say('-----------')
    sleep(10000).

main():
    # say('Here we go')
    s2d_window('barnsley fern', 1280, 1024 ).
