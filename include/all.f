_all([],_):1.
_all(a <~[A] , val | a = val ):
  _all(A,val).
_all(_,_): 0.

all(A,val):
  _all(flatten(A), val).
