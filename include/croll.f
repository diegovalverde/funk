use rroll

croll([], _): [].
croll(M,k):
      n <- len(M) / len(M[0])
      [ rroll(M[i],k) | 0 <= i < n ].
