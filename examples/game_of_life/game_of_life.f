use nth, accumn, s2d, render_board, len, foreach, set_k, map

# Any live cell with fewer than two live neighbours dies
update_cell( cnt| cnt < 2 ): 0.

# Any live cell with two or three live neighbours lives
update_cell( cnt | cnt = 2 \/ cnt = 3): 1.

# Any live cell with more than three live neighbours dies
update_cell(cnt | cnt > 3 ): 0.

update_board(_ , _ , br | len(br) < 5):
        say(len(br), ' =========== STOP ==========')
        [].

update_board(_ <~ [tr], _ <~ [mr], _ <~ [br] ):
    # say('len(tr) ', len(tr))
    # say('len(mr) ', len(mr))
    # say('len(br) ', len(br))


    cnt <- accumn(tr,  3) + accumn(br, 3) + mr + nth(mr, 2)
    say('cnt = ', cnt)


    update_cell(cnt) ~> [update_board( tr, mr, br  )].


s2d_render():
    w <- 50

    board <-  set_k(set_k(set_k([0 | 0 <= cell < 2000 ], 210, 1),211,1),212,1)

    new_board <- update_board(board, nth(board,w), nth(board,2*w))

    

    render_board(new_board, 150, 100, w, 10 ).


main():
    s2d_window('the game of life', 800, 600 ).
