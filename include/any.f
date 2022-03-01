
_any([],_): 0.
_any(L, v |  L[0] = v): 1.
_any(v <~ [L], val): _any(L,val).

any(L,v): _any(flatten(L),v).

