# merge sort algorithm

# default comparator function LessThan
comp_lt(l,r | l < r): 1.
comp_lt(l,r ): 0.

merge([], R, _): R.
merge(L , [], _): L.
merge(l <~ [L], R, F | F(l, R[0]) = 1):
    say('merge 1')
    l ~> [merge(L,R, F)].
merge(L, r <~ [R], F | F(r, L[0]) = 1):
    say('merge 2')
    r ~> [merge(L,R, F)].

_sort(A ,_ | len(A) < 2):A.
_sort(A, F):
  say('_sort', A, 'len(A)', len(A))
  

  m <- len(A)/2
  say('m',m)
  XX <- A[0 .. m-1]
  say(XX)
  merge(_sort( A[0 .. m-1] , F),_sort( A[m .. -1] , F), F).

# public interface entry point
sort(A, custom_comparator):
    say(A)
    _sort(A,custom_comparator).

sort(A):
    _sort(A, comp_lt).
