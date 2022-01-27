# return all elements in A that are not in B

in(_,[]): 0..
in(a,b <~ [B] | a != b): in(a, B).
in(a,_ ): 1.

set_diff(a <~ A, B | in(a, B) = 1): [a] <~ set_diff(a, B).
set_diff(a <~ A, B)
    
