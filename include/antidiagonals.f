
use diagonals, transpose, inverse

antidiagonals(M):
    diagonals([ inverse(col) | col: transpose(M)]).
   

