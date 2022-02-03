use sdl_simple

coeffs(r | r < 1.): [0., 0., 0.16, 0., 0.].
coeffs(r | r < 86.): [0.85, 0.04, -0.04, 0.85, 1.6].
coeffs(r | r < 93.): [0.2, -0.26, 0.22, 0.23, 1.6].
coeffs(_): [-0.15, 0.28, 0.26, 0.24, 0.44].

barnsley(n , prev_x, prev_y, r  | n = 0): 1.
barnsley(n , prev_x, prev_y, r ):
    
    c <- coeffs(r)   
    x <- c[0] * prev_x + c[1] * prev_y
    y <- c[2] * prev_x + c[3] * prev_y + c[4]

    sdl_point(40.*x + 200., 40.*y + 80.)
    barnsley(n-1, x, y, rand_float(0.0, 100.0) ).

sdl_render(ctx):
    barnsley(5000, 0.0, 0.0, rand_float(0.0, 100.0) )
    1.

main(): sdl_simple(510, 510,[0]).
