_arg_neq([],_,_): [].
_arg_neq(v <~ [L], val, k | v = val): _arg_neq(L,val,k+1).
_arg_neq(v <~ [L], val, k): k ~> [_arg_neq(L, val, k+1)].

arg_neq(L,val): _arg_neq(L,val,0).      
