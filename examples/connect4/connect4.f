############################################################
#
# F U N K! Connect 4
#
# Connect board implementation written in Funk!
# https://en.wikipedia.org/wiki/Connect_Four
# Board Dimensions: seven-columns, six-rows
#
# Note: The Funk compiler is still in pre-alpha at the time when this
# code has been written. Therefore some of the features presented
# here may not correctly translate into well formed LLVM expressions
#
# Some remarks about the programming language:
# Funk is an experimental functional programming language
# that I have been working on for the last few months.
# The Funk compiler is at a very early stage of development.
# Nevertheless, the compiler can generate well formed llvm
# IMs for simple programs, such as fizz-buzz (aka. crackle-pop), or simple
# fibonacci program (naive version, no memoization), but it will unfortunately
# will not generate all of the necessary LLVM IM for Connect-4.
# However, it is an interesting exercise to express
# the connect-4 game in a way that is idiomatic to Funk,
# even if it doesn’t compile just yet.
#
# Regarding the language syntax, Funk has no for/while/do-loops,
# no if-statements, no global symbols and all variables
# are immutable.
# Functions in Funk are first-class citizens, meaning they can pretty much
# be used wherever a regular variable can be used.
#
# With the exception of lists, all variables all pass by value
# (copied) when calling functions. For performance reasons, list elements
# internally have pointers to the heap, but special care is taken so that the
# immutability property remains honored.
#
# This code was written as part of the application process to the RC
# mini boot-camp.
#
############################################################
use min, max, sort, read, stdin


############################################################
# Board representation
#
# The board is represented as a list of cells, where each
# cell in the list consists of 3 elements: [v, r, c]
#
# v: the value of 0 (empty), 1 (player 1) or 2 (player 2)
# r: row position on the board
# c: col position on the board
#
############################################################

# Declare some constants with global visibility
# Constants essentially become LLVM statements like @W = global i32 7
W <- 7
H <- 6
MAX_DEPTH <- 3 # Maximum search depth for the minimax DFS

############################################################
#
# M A I N
#
############################################################
main():
    # Start by creating an empty board
    board <- [ [0, i, j | 0 <= i <= W] | 0 <= j <= H ]
    # Now just run the game main loop
    gameLoop(board, 0, 0).

############################################################
#
# gameLoop: main game loop, alternates between human user
# and the AI
#
############################################################

gameLoop(board, turn, player | player = 0):
    printBoard(board)
    say(‘Please select your next move human [’, legalMoves(board), ‘]’ )
    move <- read(stdin())
    next_board <- getUpdatedBoard( board, W, move, player )
    gameLoop(next_board , turn + 1, 1).

gameLoop(board, turn, player | player = 1):
    printBoard(board)
    _, move <- miniMax([], board, MAX_DEPTH)
    next_board <- getUpdatedBoard( board, W, move, player )
    gameLoop(next_board, turn + 1, 0).

############################################################
#
# getUpdatedBoard: Used to get the state of the board after
# a game move. This function is used by the minimax functions
#
############################################################
getUpdatedBoard(board, move, j, player | j= 0 \/ notLegal(move)): [].

getUpdatedBoard(board, move, j, player | move = j):
      col <- sort( getCol(board,move),
                    lambda(v1 <~ [a],v2 <~ [b]): v1 > v2. )

      dropPiece( col, player ) ~> [getUpdatedBoard(board, move, j - 1, player)].

getUpdatedBoard(board, move, j, player ):
      getCol(board, j).

############################################################
#
# dropPiece: drops a piece on a given board column
#
# Note: this assumes that the column has been sorted in
# ascending order, ie. highest row index comes first, such
# that it will first check for the empty cells further down
# to drop the piece and move up until a free slot is found
#
############################################################

dropPiece([],  player): []. # shall never happen
dropPiece(h <~ [t],  player):
      v <~ [h]
      cell <-? v = 0 : player, v
      cell ~> dropPiece(t, move, player).

############################################################
#
# Minimax
#
# The idea is to use a simple minimax with alpha-beta prunning
# to select the best adversary move.
# Since there are no for loops or if statements in Funk, the miniMax is
# implemented recursively (Funk compiler uses tail recursion whenever possible)
#
############################################################

# if there are no more legal moves or we reached maximum depth, then return the
# last move
miniMax(move, board, depth, _,_,_ | depth = 0 \/ legalMoves(board)=[] ): [utility(board), move].

# if the player won then return the winning move with super high utility
miniMax(move, board, depth | depth % 2 = 0 & playerWon(board, 0 )  ): [1000, move].

# Make sure not to select a loosing move
miniMax(move, board, depth | depth % 2 = 1 & playerWon(board, 1 )  ): [-1000, move].

# player search iteration
miniMax(move, board, depth, player, alpha, beta | player = 1):
  max([ miniMax(move, getUpdatedBoard(board, move), depth - 1), | move : legalMoves(board) ]).

# opponent search iteration
miniMax(move, board, depth, player, alpha, beta | player = -1):
  min([ miniMax(move, getUpdatedBoard(board, move), depth - 1), | move : legalMoves(board) ]).

############################################################
#
# LegalMoves
#
# Returns a list of all the columns whose top-most row is empty.
# In other words, you can still slide a piece into that row.
#
############################################################


legalMoves(h <~ [t], c):
  top_row <-  getRow(board,0,[])
  [c | v,r,c : top_row & v = 0]  #Not sure about this syntax

############################################################
#
# PlayerWon
#
# Returns 1 if the given player won the game
#
############################################################

playerWon(board, player):
  row_win  <- any([ hCheck(getRow(board,r,[]), player, 0) |  0 <= r < H])
  col_win  <- any([ vCheck(getCol(board,c,[] ), player, 0) | 0 <= c < W])
  diag_win <- dCheck(board, player, W, H)
  col_win \/ row_win \/ diag_win.


############################################################
#
# vCheck: Vertical check for winning condition
#
# Essentially, looks for 4 consecutive disks of the same color
# in a column
############################################################

vCheck(_, _,  4): 1.
vCheck([], _, _): 0.
vCheck(h <~[t], player, count):
      v <~ [h]
      next_count <-? v = player : count + 1, 0
 	vCheck(t, player, next_count ).

############################################################
#
# hCheck: Horizontal check for winning condition
#
# Looks for 4 consecutive disks of the same color
# in a row
############################################################

hCheck(_, _,  4): 1.
hCheck([], _, _): 0.
hCheck(h <~[t], player, count):
    v <~ [h]
    next_count <-? v = player: count + 1, 0
  	hCheck(t, player, next_count ).

############################################################
# dCheck: Diagonal winning condition check.
#
# In connect-4, a player can also win by connecting 4 consecutive
# pieces in a diagonal. Therefore, we need a way to obtain the diagonals.
# The general strategy for this is to shift the rows of the matrix, obtaining
# a second matrix whose columns are the diagonals of the original matrix:
#
#  1  2  3       _  _  1  2  3
#  4  5  6  ->   _  4  5  6
#  7  8  9       7  8  9
#
# By selecting the columns of the right shifted matrix
# we obtain the diagonals: [7], [4,8], [1,5,9] and [3]
#
# Similarly for the diagonals in the opposite direction
# 1  2  3     1  2  3
# 4  5  6 ->  _  4  5  6
# 7  8  9     _  _  7  8  9
# we obtain the diagonals: [1], [2,4], [3,5,7] and [9]
#
############################################################


dCheck(board, player ):
      dcount    <- W + H - 1
      rs_board  <- shrBoard(board, H - 1)
      diagr_won <- any([vCheck( getCol(rs_board,j,[]), 0, player, 0)| 0 <= j <= dcount])
      ls_board  <- shlBoard(board, H)
      diagl_won <- any([vCheck( getCol(ls_board,j,[]), 0, player, 0)| 0 <= j <= dcount])
      diagr_won \/ diagl_won.

############################################################
#
# shrBoard: shifts the entire board to the right row-wise
#
############################################################


shrBoard(board, r | r < 0): [].
shrBoard(board, r):
    srow <- shrRow( getRow(board, r, []), H - r - 1 )
    srow ~> [shrBoard(board, r - 1)].

############################################################
#
# shrRow: shifts a row to the right
#
############################################################


shrRow( row, off | row = [] \/ off = 0): row.
shrRow( h <~ [t], off):
   v,r,c <~ [h]
   [v, r, c + off ] ~> shiftRow(t, off ).

############################################################
#
# Sparse Matrix Manipulation functions
#
# At the time this code was written, funk does not supported arrays
# but only linked lists (and I am still undecided if arrays will be
# supported). Since lists have O(n) for random element access, then
# some recursive support for matrix manipulation is required here.
# Also note that the way the board is represented allows storing only
# the non-zero (non empty cells), thus can potentially save some memory
# for big sparse boards.
############################################################

############################################################
#
# getRow: returns a row given its index
#
############################################################

getRow([], _, acc): acc.
getRow(h <~ [t], row, acc):
  v, r <~ [h]
  [acc] <~? row = r: h,[]
  getRow(t, row, acc).

############################################################
#
# getCol: returns a column given its index
#
############################################################

getCol([], _, acc): acc.
getCol(h <~ [t], col, acc):
  _, _, c <~ [h]
  [acc] <~? col = c: h,[]
  getCol(t, row, acc).

############################################################
#
# printBoard: prints the board
#
############################################################
printBoard([]): 1.
printBoard(h <~ [t]):
   v <~ h
   p <-? v = 0 : ‘ ’ : v
   say(‘ ’, p , ‘ ’).