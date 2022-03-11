
argmax_custom_function(l,r | l >= r): 1.
argmax_custom_function(l,r ): 0.

_argmax([], best_v, best_k, ...): best_k.
_argmax(v <~ [L], best_v, best_k, k, F | F(v, best_v) = 1):  _argmax(L, v, k, k+1, F).
_argmax(v <~ [L], best_v, best_k, k, F ):  _argmax(L, best_v, best_k, k+1, F).

argmax(L): _argmax(L, -1*infinity(), 0, 0, argmax_custom_function).

argmax(L, F): _argmax(L, -1*infinity(), 0, 0, F).
