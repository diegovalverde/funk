use s2d, render_board


game_loop(board):
        render_board( board, 50, 10 ).

s2d_render():
    board <- [c | 0 <= c < 2000 ]
    game_loop(board).

main():
    s2d_window('board test', 800, 600 ).

