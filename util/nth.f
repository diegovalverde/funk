
# returns the nth element of a list

nth( t, 0): t.
nth([],_): 0.
nth(_ <~ [t] ,n):
    nth(t,n-1).
