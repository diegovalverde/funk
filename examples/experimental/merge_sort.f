# merge sort algorithm

merge([], R): R.
merge(L , []): L.
merge(l <~ [L], R | l < R[0]): l ~> [merge(L,R)].
merge(L, r <~ [R] | r < L[0]): r ~> [merge(L,R)].

sort(A | len(A) < 2): A.
sort(A):
  m <- len(A)/2
  merge(sort( A[0 .. m-1] ),sort( A[m .. -1] )).

main():
    A <- [2, 5, 4, 3, 1]
    say(A)
    say(sort(A)).
