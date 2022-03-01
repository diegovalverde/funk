use sort
max( A | len(A) = 2 /\ A[0] < A[1]): [A[1], A[0]].
max(A): 
    S <- sort(A)
    S[-1].
