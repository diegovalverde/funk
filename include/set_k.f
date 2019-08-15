use idem


set_k([], _, _ ):
    say(k,'^')
    [].

set_k(h <~ [t], k, val | k = 0):
    idem(val) ~> [t].#set_k(t, -1, val)].

set_k(h <~ [t], k, val):
    idem(h) ~> [set_k( t, k-1, val)].
