# simple driver for sudoku_backtracking
use sudoku_backtracking, fread_list

main():
    # 0 indicates empty cells (loaded from file)
    B <- reshape(fread_list('examples/experimental/sudoku/board.txt'),9,9)

    # returns [status, board]
    say(sudoku_backtracking(B))
    1.
