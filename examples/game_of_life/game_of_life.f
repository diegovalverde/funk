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
    1 .

# All others: ie. dead cells with no neighbours remain dead
update_cell(_, _  ): 0.

ub(tr, mr, br, k, i,j,w| k = 40): [].

ub(tr, mr, br, k, i,j,w| k > 31):
    idem(0) ~>[ub(tr,mr,br, k+1,(k+1)/w,(k+1)%w,w)].


ub(tr, mr, br, k, i,j,w| i = 0 \/ j = 0):

    idem(0) ~>[ub(tr,mr,br, k+1,(k+1)/w,(k+1)%w,w)].

ub(a <~ [tr], b <~ [mr], c <~ [br],k, i,j,w| j = (w-1)):

    idem(0) ~>[ub(nth(tr,1), nth(mr,1), nth(br,1), k+1,(k+1)/w,(k+1)%w,w)].

ub(tr, mr, br,k, i,j,w| i = (w-1)):

    idem(0) ~>[ub(tr, mr, br, k+1,(k+1)/w,(k+1)%w,w)].


ub(a <~ [tr], b <~ [mr], c <~ [br],k,i,j,w):
    say(k,'>>>>>>>',i,j)
    cnt <- a + b + c + br + tr + nth(tr,1) + nth(mr, 1) + nth(br,1)
    update_cell(mr, cnt) ~> [ub( tr, mr, br, k+1,(k+1)/w,(k+1)%w,w )].



update_board(a <~ [tr], b <~ [mr], br | len(br) = 1):
    [br].

update_board(_ , _ , [],_ ): [].

update_board(a <~ [tr], b <~ [mr], c <~ [br] | len(br) = 1 ):
    update_cell(mr, 0) ~> [update_board( tr, mr, br )].

update_board(a <~ [tr], b <~ [mr], c <~ [br]) :
    cnt <- a + b + c + br + tr + nth(tr,1) + nth(mr, 1) + nth(br,1)
    update_cell(mr, cnt) ~> [update_board( tr, mr, br )].

layer(_,[],_,_,_,_): [].

layer(fg,b <~ [bg],k,i,j,w | len(fg) = 0):
    say(len(fg),len(bg),'XXX k',k,i,j)
    idem(b) ~> [layer(fg,bg,k+1,(k+1)%w,(k+1)/w,w)].

layer(fg,b<~[bg],k, i,j,w| i = (w-1) \/ j = (w-1)):
    say(len(fg),len(bg),'BG2 k',k,i,j)
    idem(b) ~>[layer(fg,bg,k+1,(k+1)%w,(k+1)/w,w)].


layer(fg,b<~[bg],k, i,j,w| i = 0 \/ j = 0):
    say(len(fg),len(bg),'BG k',k,i,j)
    idem(b) ~>[layer(fg,bg,k+1,(k+1)%w,(k+1)/w,w)].

layer(f<~[fg],b<~[bg],k,i,j,w):
    say(len(fg),len(bg),'FG k',k,i,j)
    idem(f) ~>[layer(fg,bg,k+1,(k+1)%w,(k+1)/w,w)].


s2d_render(board):
    w <- 8

    #inner_board <- update_board(board, nth(board,w), nth(board,2*w))
    #next_board <- layer(inner_board,[1 | 0 <= cell < 40 ],0,0,0,w)

    #render_board(board, 10, 10, 8, 80 )
    da_b <- ub(board, nth(board,w), nth(board,2*w), 0, 0,0,w)
    render_board(da_b, 10, 10, 8, 80 )

    #render_board(inner_board, 10, 10, 6, 80 )
    s2d_render(da_b).

main():
    funk_set_config(0,1)
    funk_set_config(1,10)

    board <-  set_k(set_k(set_k([0 | 0 <= cell < 40 ], 19, 1),20,1),21,1)
    say(board)
    s2d_window('the game of life', 800, 600 )
    s2d_render(board).
