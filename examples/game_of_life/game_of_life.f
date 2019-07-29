
 use nth, idem, accumn, s2d, render_board, len, foreach, set_k, map


# Any live cell with fewer than two live neighbours dies
update_cell(alive, cnt |  alive = 1 /\ cnt < 2 ): 0.

# Any live cell with two or three live neighbours lives
update_cell(alive, cnt | alive = 1 /\ cnt = 2 ):
    say('keep')
    1.
update_cell(alive, cnt | alive = 1 /\ cnt = 3 ): 1.

# Any live cell with more than three live neighbours dies
update_cell(alive, cnt | alive = 1 /\ cnt > 3 ):
    say('die')
    0.

# Any dead cell with exactly three live neighbours becomes a live cell
update_cell(alive, cnt | alive = 0 /\ cnt = 3 ):
    say(cell,'wake up',cnt)
    1.

# All others: ie. dead cells with no neighbours remain dead
update_cell(_, _  ): 0.

update_board(_ , _ , br, i | len(br) < 5):
        say(len(br), ' =========== STOP ==========')
        [].

# update_board(a <~ [tr], mr, br, i | i < 50):
#      say('top row')
#      a ~> [update_board( tr, mr, br, i + 1  )].


# update_board(tr, mr, br, i | i % 50 = 0):
#      x <- 1
#      idem(x) ~> [update_board( tr, mr, br, i+1   )].

# update_board(tr, mr, br, i | i % 49 = 0):
#      x <- 1
#      idem(x) ~> [update_board( tr, mr, br, i+1   )].

matrix_insert_col([],_,_,_): [].

matrix_insert_col(h <~ [t], val, col, i | i % col = 0):
    say('matrix_insert_col', col, i)
    caca <- [1, 0]
    caca ~> [matrix_insert_col(t,val,col, i+1)]
    caca.

matrix_insert_col(h <~ [t], val, col, i):
    idem(h) ~> [matrix_insert_col(t, val, col, i+1)].





update_board(a <~ [tr], b <~ [mr], c <~ [br], i ):
    cnt <- a + b + c  + br + tr + nth(tr,1) + nth(mr, 1) + nth(br,1)
    #TODO accumn has a bug
    #say('>>>>',a,b,c,accumn(tr,  2) , accumn(br, 2) , nth(mr, 1))

    say(a, tr, nth(tr, 1))
    say(b, mr, nth(mr, 1))
    say(c, br, nth(br, 1))

    # change syntax to say('cell',[mr],'cnt =',cnt)

    say(i, 'cell',mr,'cnt =',cnt)
    say('')


    update_cell(mr, cnt) ~> [update_board( tr, mr, br, i + 1  )].



s2d_render(board):
    w <- 50

    s <- [1 | 0 < i < 51]


    new_board <- update_board(board, nth(board,w), nth(board,2*w), 0)


        framed_board <- [1 | 0 <= i < 48]
        [framed_board] ~> [new_board]
        [framed_board] ~> [1 | 0 <= i < 48]

        caca <- matrix_insert_col(framed_board, 0.5, 50, 0)
        caca2 <- matrix_insert_col(caca, 1, 50, 0)

        say( 'LEN', len(board), len(new_board))

        #x <- sublist(board, w) ~> [new_board]
        say('s=',len(s),'new_board=',len(new_board))
        [s] ~> [new_board]
        say('>>>>>','s=',len(s))


    render_board(new_board, 150, 100, 50, 10 )
    s2d_render(new_board).


main():
    funk_set_config(0,1)
    funk_set_config(1,10)

    board <-  set_k(set_k(set_k([0 | 0 <= cell < 2000 ], 210, 1),211,1),212,1)
    say(board)
    s2d_window('the game of life', 800, 600 )
    s2d_render(board).
