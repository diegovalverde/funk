# return all elements in A that are not in B

in_list(_,[]): 0.
in_list(a,b <~ [B] | a != b): in_list(a, B).
in_list(a,_ ): 1.

set_diff([], _): [].
set_diff(a <~ [A], B | in_list(a, B) = 1): set_diff(A, B).
set_diff(a <~ [A], B): a ~> [set_diff(A, B)].
