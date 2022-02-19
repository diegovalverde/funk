any([],_): 0.
any(v <~ [L], val|  v != val): any(L,val).
any(_,_): 1.
