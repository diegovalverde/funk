
# returns a new list after applying function F
# to each individual element


map(F, A | len(A) > 1): [map(F, A[i]) | 0 <= i < len(A)]. #a : A].
map(F, a ): F(a).
       
