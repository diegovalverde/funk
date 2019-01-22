import copy


############################################################
#
# Note: This is NOT pythonish way of writing the code
# rather the idea of this code is that it resembles how
# you would write it in Funk, and it is used to then
# check the Funk algorithms
#
############################################################

W = 7  # 4
H = 6  # 4
MAX_DEPTH = 3  # Maximum search depth for the minimax DFS


############################################################
#
# vCheck: Vertical check for winning condition
#
# Essentially, looks for 4 consecutive disks of the same color
# in a column
############################################################
def vCheck(cx, player, count):
   col = copy.deepcopy(cx)

   if count == 4:
       return 1

   if col == []:
       return 0

   [v,r,c] = col.pop(0)

   next_count = count
   if v == player:
       next_count = count + 1
   else:
       next_count = 0

   return vCheck(col, player, next_count )

############################################################
#
# hCheck: Horizontal check for winning condition
#
# Looks for 4 consecutive disks of the same color
# in a row
############################################################
def hCheck(rx, player,  count):
    row = copy.deepcopy(rx)

    if count == 4:
        return 1

    if row == []:
        return 0

    [v, r, c] = row.pop(0)

    if v == player:
        next_count = count + 1
    else:
        next_count = 0

    return hCheck(row, player, next_count )

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


def dCheck(board, player, width, height):
   dcount    = width + height - 1
   rs_board  = shrBoard(board, height -1 )

   diagr_won = any([vCheck( getCol(rs_board, j, []), player, 0) for j in range(dcount)])
   #ls_board  = shlBoard(board, height, height)
   #diagl_won = any([vCheck(ls_board, 0, j, player, 0) for j in range(dcount)])
   return diagr_won# or diagl_won

############################################################
#
# PlayerWon
#
# Returns 1 if the given player won the game
#
############################################################


def playerWon(board, player):
    row_win = any([ hCheck(getRow(board,r,[]), player, 0) for r in range(H)])
    col_win = any([ vCheck(getCol(board,c,[] ), player, 0) for c in range(W)])
    diag_win = dCheck(board, player, W, H)
    return col_win or row_win or diag_win


############################################################
#
# shrBoard: shifts the entire board to the right row-wise
#
############################################################

def shrBoard(board, r):
   b = copy.deepcopy(board)
   if r < 0:
       return []
   row = getRow(b, r, [])
   srow = shiftRow( row , H - r - 1 )
   return srow + shrBoard(board, r - 1)

############################################################
#
# shrRow: shifts a row to the right
#
############################################################

def shiftRow( row, off):
   if row == [] or off == 0:
       return row
   h = row.pop(0)
   [v, r, c] = h
   return [[v, r, c + off]] + shiftRow(row, off)


############################################################
#
# getRow: returns a row given its index
#
############################################################

# def getRow(b, row, acc):
#    board = copy.deepcopy(b)
#    if board == []:
#        return acc
#    [v, r, c] = board.pop(0)
#    if row == r:
#        acc += [[v,r,c]] # PUT AT THE END TO PRESERVE ORDER
#    return getRow(board, row, acc)

def getRow(board, row, acc,k=0):

    """
    Note that in Funk you will not pass the index 'k'
    because lists in Funk are linked lists
    However the 'k' is used here in order to prevent
    deep-copying the entire board every time.
    In Funk this will (hopefully) not be an issue since
    lists are allocated on the head (but still immutable)
    """
    if k == W*H:
        return acc
    [v, r, c] = board[k]
    if row == r:
        acc += [[v,r,c]] # PUT AT THE END TO PRESERVE ORDER
    return getRow(board, row, acc, k+1)

############################################################
#
# getCol: returns a column given its index
#
############################################################

# def getCol(b, col, acc):
#    board = copy.deepcopy(b)
#    if board == []:
#        return acc
#    [v, r, c] = board.pop(0)
#    if col == c:
#        acc += [[v, r, c]] # PUT AT THE END TO PRESERVE ORDER
#    return getCol(board, col, acc)

def getCol(board, col, acc,k=0):
   if k == W*H:
       return acc
   [v, r, c] = board[k]
   if col == c:
       acc += [[v, r, c]] # PUT AT THE END TO PRESERVE ORDER
   return getCol(board, col, acc,k+1)

############################################################
#
# LegalMoves
#
# Returns a list of all the columns whose top-most row is empty.
# In other words, you can still slide a piece into that row.
#
############################################################

def legalMoves(b):

    return [c for [v,r,c] in getRow(b,0,[]) if v == 0]


def miniMax(move, b, depth, player, alpha=-1000, beta=1000):
    board = copy.deepcopy(b)

    if playerWon(board,1):
        u = 1000
    elif playerWon(board,-1):
        u = -1000
    else:
        u = player*utility(board, 1)

    if depth == 0 or u in [1000,-1000]:
        return [u, move ]
    elif player == 1:
        depth_2 = depth - 1

        best_util = -100000
        best_move = 0
        for m in legalMoves(board):
            util, _ = miniMax(m, getUpdatedBoard(board, m, W, 1), depth_2, -1, alpha, beta)

            if util > best_util:
                best_util = util
                best_move = m

            alpha = max(alpha, best_util)

            if beta <= alpha:
                break

        return [best_util, best_move]

    else:
        #print('AI turn. legal moves', legalMoves(board))
        depth_2 = depth - 1

        best_util = 100000
        best_move = 0
        for m in legalMoves(board):
            util, _ = miniMax(m, getUpdatedBoard(board, m, W, -1), depth_2,1,alpha,beta)

            if util < best_util:
                best_util = util
                best_move = m

            beta = min(beta, best_util)

            if beta <= alpha:
                break

    return [best_util, best_move] #[utils[idx],idx]


def gameLoop(b, turn, player):
    board = copy.deepcopy(b)
    printBoard(board, H)
    print(' 0  1  2  3  4  5  6\n')
    if playerWon(board,1):
        print('Human Wins')
        exit()
    elif playerWon(board,-1):
        print('AI Wins')
        exit()
    elif legalMoves(board) == []:
        print('Draw')
        exit()


    elif player == 1:

        print('Please select your next move human ', legalMoves(board) )
        move = int(input('>'))
        next_board = getUpdatedBoard( board, move, W, player )
        gameLoop(next_board , turn + 1, -1)
    else:

        _, move = miniMax(-1, board, MAX_DEPTH, -1)
        next_board = getUpdatedBoard( board,  move, W, player )
        gameLoop(next_board, turn + 1, 1)


def sortRow(val):
    return val[1]

def sortCol(val):
    return val[2]

def getUpdatedBoard(b, move, j, player):
    board = copy.deepcopy(b)
    if move not in legalMoves(board):
        return board
    elif j < 0 :
        return []
    elif move == (W-j):
        col = getCol(board, move, [])
        col.sort(key = sortRow, reverse = True)

        return dropPiece(col, player, 0 ) + getUpdatedBoard(board, move, j - 1, player)
    else:
        return getCol(board, W - j, []) + getUpdatedBoard(board, move, j - 1, player)


def printBoard(b, i):

    board = copy.deepcopy(b)
    if i == 0:
        return
    else:
       row = getRow(board, H - i, [])
       row.sort(key = sortCol)
       vals =[v for v,r,c in row]

      # print([2 if x == -1 elif x == '0' else x for x in vals])


       for x in vals:
           if x == -1:
               print(' x ', end ='')
           elif x == 1:
               print(' o ', end ='')
           else:
               print(' _ ', end ='')
       print()

       printBoard(board, i-1)




def dropPiece(c, player, found):
    col = copy.deepcopy(c)
    if col == []:
        return []
    else:
        h = col.pop(0)
        v,r,c = h
        if v == 0 and found == 0:
            cell = [player, r, c]
            found  = 1
        else:
            cell = [v, r, c]

    return [cell] + dropPiece(col, player, found)

# The idea of these evalutaion functions is explained here
#https://softwareengineering.stackexchange.com/questions/263514/why-does-this-evaluation-function-work-in-a-connect-four-game-in-java

utility_table_4x4 = [
        [3, 2, 2, 3],
        [2, 2, 2, 2],
        [2, 2, 2, 2],
        [3, 2, 2, 3],
    ]

utility_table_7x6 = [
        [3, 4, 5, 7, 5, 4, 3],
        [4, 6, 8, 10, 8, 6, 4],
        [5, 8, 11, 13, 11, 8, 5],
        [5, 8, 11, 13, 11, 8, 5],
        [4, 6, 8, 10, 8, 6, 4],
        [3, 4, 5, 7, 5, 4, 3]
]


def utility(board, player):
    total_util = 0
    for i in range(H):
        row = getRow(board,i,[])
        for e in row:
            [v,r,c] = e
            if player == v:
                total_util += utility_table_7x6[r][c]
            elif v != 0:
                total_util -= utility_table_7x6[r][c]

    return total_util



if __name__ == "__main__":
    print('starting')
    board_ = [[0,i,j] for i in range(H) for j in range(W)]


    gameLoop(board_, 0, 1)


