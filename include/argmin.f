
argmin_custom_function(l,r | l < r): 1.
argmin_custom_function(l,r ): 0.

_argmin([], best_v, best_k, ...): best_k.
_argmin(v <~ [L], best_v, best_k, k, F | F(v, best_v) = 1):  _argmin(L, v, k, k+1, F).
_argmin(v <~ [L], best_v, best_k, k, F ):  _argmin(L, best_v, best_k, k+1, F).

argmin(L): _argmin(L, infinity(), 0, 0, argmin_custom_function).
argmin(L, F): _argmin(L, infinity(), 0, 0, F).
