# compute the max in O(n)

max_default_cmp(a,b | a > b): a.
max_default_cmp(a,b): b.

_max([], v, _): v.
_max(v <~ [A], max_val, F ): _max(A, F(v, max_val), F).


max(A): _max(A, A[0], max_default_cmp ).
max(A, F): _max(A, A[0], F ).
