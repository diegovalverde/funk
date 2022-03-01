use sort
min( A | len(A) = 2 /\ A[0] > A[1]): [A[1], A[0]].
min(A): 
    S <- sort(A)
    S[0].
