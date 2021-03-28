all([],_):1.
all(a <~[A] , val | a = val ): all(A,val).
all(_,_): 0.
