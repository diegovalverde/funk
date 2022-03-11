# compute the min in O(n)

min_default_cmp(a,b | a < b): a.
min_default_cmp(a,b): b.

_min([], v, _): v.
_min(v <~ [A], min_val, F ): _min(A, F(v, min_val), F).


min(A): _min(A, A[0], min_default_cmp ).
min(A, F): _min(A, A[0], F ).
