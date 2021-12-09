_count([],_, total): total.
_count(a <~ [A],v, total | a = v): _count(A,v,total+1).
_count(a <~ [A],v, total): _count(A,v,total).

count(A,v):
    _count(flatten(A),v,0).
