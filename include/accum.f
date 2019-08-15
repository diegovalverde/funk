
# accumulate (sum) all the elements of a list

__accum([], acc): acc.
__accum(h <~ [t], acc):
    __accum(t, acc + h).

accum(a):
    __accum(a, 0).


# accumulate (sum) the first n elements of a list
__accumn(_, acc, 0):
      acc.
__accumn(h <~ [t], acc, n):
    __accumn(t, acc + h, n - 1).


accumn(a,n):
     __accumn(a, 0, n).

