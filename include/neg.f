use map

_neg(a | a = 0) : 1.
_neg(_):0.
neg(A): map(_neg, A).
