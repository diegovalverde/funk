_all([],_):1.
_all(a <~[A] , val | a = val ):
  say('all',a,val)
  _all(A,val).
_all(_,_): 0.

all(A,val):
   say('all', A, val)
  _all(flatten(A), val).
