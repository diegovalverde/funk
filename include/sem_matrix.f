

# returns a matrix of all zeros except at position ei, ej
# sem: single element matrix
sem_element(i, j, ei, ej | ei = i /\ ej = j ): 1.

sem_element(_,_,_,_):0.
sem_matrix(n, m, ei,ej):
    
    x <- [[ sem_element(i,j, ei, ej) | 0 <= j < m] |  0 <= i < n ]

    x.
