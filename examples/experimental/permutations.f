#perms([]): [].
# for this is the cross product of H <- L and T <- perms(L--[H])
# perms([]) -> [[]];
# perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].
# This takes H from L in all possible ways. The result is the set of all lists [H|T], where T is the set of all possible permutations of L, with H removed:
#   the X--Y for each element in the second argument, the first occurrence of this element (if any) is removed
#
# perms(L):  [ [H|T] || H <- L, T <- perms(L--[H])  ].
#
#
# perms([]): [].
# # ,  means cartesian product of two vectors
# perms(L): [ H <~[T] | H <- L, T <- perms(L--[H])   ].
#
# if L = [1,2,3]
# then H is [1, 2, 3] and T is []
#
#
# v = [0, 1, 2]
#
#
# [0] ~> [1,2]  0,1,2
# [1,2]<~[0]    0,2,1
#
# [1] ~> [0,2]  1,0,2
# [0,2]<~[1]    1,2,0
#
# [2] ~> [0,1]  2,0,1
# [0,1]<~[2]    2,1,0
#


del([],_ ): [].

del(h <~ [T], a | h = a):
    say('deleting', a, 'from ', T)
    A <- del(T,a)
    A.

del(h <~ [T], a):
    say('h',h, 'T', T)
    h ~> [del(T,a)].

#prepend(a,A): a ~> [A].

#idem(X): X.

perms([],_ ):[].
perms(A,k):
    say(A[k], A)
    A[k] ~> [perms( del(A,A[k]), k+1 )].

# perm(A): #idem(A).
#     #n<- len(A)
#     say(A)
#     [ prepend(A[m], perm( del(A,A[m])) )   | 0 <= m < 2 ].
    #[A[m] ~> [perm(A[0  .. m-1] <~ A[m+1 .. -1])]  | 0 <= m < len(A) ].


main():
    say(perms([1,2,3],0)).
