_arg_eq([],_,_): -1.
_arg_eq(v <~ [L], val, k | v != val): _arg_eq(L,val,k+1).
_arg_eq(_,_, k): k.

arg_eq(L,val): _arg_eq(L,val,0).      
