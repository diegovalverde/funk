

replace(M, p, q, v | p = q ): v.
replace(M, _, [i,j], _ ): M[i,j].

replace_matrix_element(M, v, pos):
   [ [ replace(M,pos,[i,j], v) | 0 <= j < len(M[0])] | 0 <= i < len(M) ].

