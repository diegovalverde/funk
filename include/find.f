# implements a linear search
_find(_, [],_): -1.
_find(a,b <~ [B], pos | a = b): 
    pos.
_find(a,b <~ [B], pos):
    _find(a, B, pos+1).

find(a,B): _find(a,B,0).
