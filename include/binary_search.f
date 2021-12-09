binary_search(A, value, low, high | high < low): [].

binary_search(A, value, low, high | A[(low + high)/2] > value):
    mid <- (low + high)/2
    binary_search(A, value, low, mid-1).

binary_search(A, value, low, high | A[(low + high)/2] < value):
        mid <- (low + high)/2
        binary_search(A,  value, mid+1, high).

binary_search(A, value, low, high): [(low + high) / 2].

bst(A,value): binary_search(A, value, 0, len(A)).
