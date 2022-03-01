
_all([],_):1.
_all(A , val |A[0] != val): 0.
_all(a <~[A] , val ): _all(A,val).

all(L,_| flatten(L) = []): 0.
all(A,val):
  _all(flatten(A), val).
