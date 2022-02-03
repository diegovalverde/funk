# returns list with unique elements in O(nlogn)
# essentially a variation of merge sort algorithm

_merge([], R): R.
_merge(L , []): L.
_merge(l <~ [L], R | l = R[0] ): _merge(L,R).      # this removes the duplicate
_merge(l <~ [L], R | l < R[0]): l ~> [_merge(L,R)].
_merge(L, r <~ [R]): r ~> [_merge(L,R)].

unique(A | len(A) < 2):A.
unique(A):
  m <- len(A)/2
  _merge(unique( A[0 .. m-1] ),unique( A[m .. -1])).
  

