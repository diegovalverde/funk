use s2d, render_board


game_loop(board):
        render_board( board, 150, 100, 50, 10 ).

s2d_render():
    board <- [1 | 0 <= c < 2000 ]
    game_loop(board).

main():
    s2d_window('board test',  800, 600 ).

