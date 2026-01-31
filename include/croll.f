use rroll

croll([], _): [].
croll(M,k):
      [ rroll(M[i],k) | 0 <= i < (len(M) / len(M[0])) ].
