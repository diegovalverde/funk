#use map
N <-> 20

assert(actual, expected | actual != expected ):
    say('Assertion failed actual ', actual, '!= expected ', expected)
    exit().
assert(a,b):
    say(a,'=',b)
    1.

fib(0, _, _): 0.
fib(1, _, result):
    result + 0. # TODO: Bug returning 'result' not working...

fib(n, result, next):
    x <- result+next # TODO: bug doing the addition as argument not working
    fib(n-1, next, x).

fibo(n):
    fib(n,0,1).

_sum([]): 0.
_sum( x <~ [A]):
     x + _sum(A).

triangular_series(n): (n*n + n)/2.


main():
      #say('Test strings')
      #assert('hello',echo('hello'))

      say('==== Test Arrays === ')
      A <- [1,2,3,4,5,6,7]
      assert(A[0], 1)
      assert(A[1], 2)
      assert(A[-1], 7) # last element
      assert(A[-2], 6)
      assert(A[7], 1)  # wraps around
      assert(A[8], 2)  # wraps around
      assert(len(A), 7)
      assert(sum([0 | 1 <= i <= 10]),0)
      assert(sum([1 | 1 <= i <= 10]),10)
      assert(sum([1 | 10 <= i <= 20]),11)
      assert(sum([1 | 100 <= i < 200]),100)
      assert(sum([1 | 100 <= i <= 200]),101)
      assert(sum([1 | 1000 <= i < 2000]),1000)
      assert(len([1 | 100 <= i < 200]),100)
      assert(len([1 | 57 <= i <= 59]),3)
      assert(len([1 | 1997 <= i < 2000]),3)
      assert(len(A),7)
      assert(len(A),len(A))


      say('====== Test Matrix =====')
      M1 <- [[1,0,0,0],
            [0,1,0,0],
            [0,0,1,0],
            [0,0,0,1]]

      #say(M1)
      #assert(len(M1),16)

      #assert(sum(reshape(M,[1])), 4)
      M2 <- [[j | 0<= j <= 3] | 0 <= i <= 3]
      assert(len(M2),16)
      x <- 0
      assert(M2[x,x],0)
      #[[assert(M2[i,j],j) | 0 <= j <= 3] | 0 <= i <= 3]

      say(M2)

      a <- 0
      b <- 2
      say(M2[a..b , a..b])
      sub_matrix <- M2[a..b , a..b]
      assert(sum(M2[a..b , a..b]),9)
      assert(sum(M2[a..b , a..b]),sum(sub_matrix))
      assert(sum(M2[a..b , a..b]),sum([[j | 0<= j <= 2] | 0 <= i <= 2]))
      assert(sum(sub_matrix),9)
      assert(sum(sub_matrix), M2[a,a] + M2[a+1,a] + M2[a+2,a] +
                               M2[a,a+1] + M2[a+1,a+1] + M2[a+2,a+1] +
                               M2[a,a+2] + M2[a+1,a+2] + M2[a+2,a+2])

      assert(sum([0 | 1<= j <= 10]),0)
      assert(sum([1 | 1<= j <= 10]),10)

      say('==== Test triangular series === ')
      assert(triangular_series(7), _sum(A))  # Something fails if you do sum instead of _sum
      assert(triangular_series(len(A)), _sum(A))
      assert(triangular_series(10), _sum([1,2,3,4,5,6,7,8,9,10]))
      assert(triangular_series(N), _sum([i | 0 <= i <= N]))
      assert(triangular_series(29), _sum([i | 0 < i < 30]))


      #n <- rand_range(1,100)
      #say('Test: triangular sum for n=',n)
      #assert(triangular_series(n), sum([i | 0 <= i <= n])+0)
      #say('ok')
      #t1 <- [assert(triangular_series(k), sum([i | 0 <= i <= k])) | 0 <= k <= rand_range(1,100)]


      say('==== Test fibonachi ====')
      assert(fibo(15), 610)

      fib_nums <- [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987]
      t2 <- [assert(fibo(i), fib_nums[i]) | 0 <= i < 16]

      #mapped_fibo <- map(fibo,[i | 0 <= i < 16])
      #t3 <- [assert(mapped_fibo[i], fib_nums[i]) | 0 <= i < 16]

      # cnt1 <- sum(M[i-1: i+1, j-1: j+1]) - M[i,j])
      # cnt2 <- M[i-1, j]  + M[i+1,  j] + M[i, j-1]  +
      #        M[i, j+1]  + M[i-1,j-1] + M[i-1,j+1] +
      #        M[i+1,j-1] + M[i+1,j+1]
      # assert(cnt1, 100)
      # assert(cnt2, 100)

      say('====== test sum =======')
      assert(sum([1,1,1]),_sum([1,1,1]))
      assert(sum(A),_sum(A))
      assert(triangular_series(7), sum(A))


      say('All tests passed ;)').
