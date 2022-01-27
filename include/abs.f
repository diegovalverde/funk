use map
_abs(x | x > 0) : -1 * x.
_abs(x) : x.

abs(x | type(x) = __array__): map(x,_abs). 
abs(x): _abs(x).
