use map
_abs(x | x < 0) : -1 * x.
_abs(x) : x.

abs([]): [].
abs(x | len(x) > 1): map(_abs, x).
abs(x): _abs(x).
