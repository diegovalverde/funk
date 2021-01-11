
use sort
N <-> 20

assert(actual, expected | actual != expected ):
    say('Assertion failed actual ', actual, '!= expected ', expected)
    exit().
assert(a,b):
    say(a,'=',b)
    1.

fib(0, _, _): 0.
fib(1, _, result): result.

fib(n, result, next):
    x <- result+next # TODO: bug doing the addition as argument not working
    fib(n-1, next, x).

fibo(n): fib(n,0,1).

_sum([]): 0.
_sum( x <~ [A]):
     x +_sum(A).

triangular_series(n): (n*n + n)/2.

coeffs(r | r < 1.):[0., 0., 0., 0.16, 0.].
coeffs(r | r < 86.): [0.85, 0.04, 0.85, -0.04, 1.6].
coeffs(r | r < 93.): [0.2, -0.26, 0.23, 0.22, 1.6].
coeffs(_): [0.28, -0.15, 0.26, 0.24, 0.44].

lt(x , y | x < y): 1.
lt(x , y ): 0.

float_test(prev_x, prev_y,r, e_x, e_y):
    c <- coeffs(r)
    x <- c[0] * prev_x + c[1] * prev_y
    y <- c[2] * prev_x + c[3] * prev_y + c[4]
    epsilon <- 0.001
    assert( lt(x - e_x, epsilon), 1)
    assert( lt(y - e_y, epsilon), 1)
    1.

arr_eq([],[]): 1.
arr_eq(A,B | len(A) != len(B)): 0.
arr_eq(a <~ [A] , b <~ [B] | a != b): 0.
arr_eq(a <~ [A] , b <~ [B]): arr_eq(A,B).


main():


      #say('Test strings')
      #assert('hello',echo('hello'))
      say('==== floating point ===')
      epsilon <- 0.001
      float_test(0.23408, 6.28606, 85.0, 0.45041, 1.5475 )

      #assert(coeffs(0.5),[0., 0., 0., 0.16, 0.]
      # assert((91.017126 < 1.000000),  0)
      # assert(91.017126 < 86.000000, 0)
      # assert(91.017126 < 93.000000, 1)
      # assert(71.836580 < 1.00000, 0)

      # prev_x 0.13734 prev_y 4.89916 r 95.48303
      # prev_x <- 0.13734
      # prev_y <- 4.89916
      # # assert(0.28* prev_y - 0.15 * prev_x,  1.35116)
      # assert((0.26 * prev_x + 0.24 * prev_y) + 0.44,  1.65151)

      say('==== Test Arrays === ')
      assert(len( [0] ), 1)
      assert(len( [0] ), len( [1] ))
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

      # test the array slicing
      assert(len(A[0 .. len(A)/2]),4)
      assert(sum(A[0 .. len(A)/2]),10)
      assert(len(A[len(A)/2 + 1 .. -1]),3)
      assert(sum(A[len(A)/2 + 1 .. -1]),18)
      assert(len(A[2 .. 3]),2)
      assert(sum(A[2 .. 3]),7)
      assert(len(A[0 .. -1]),len(A))
      #assert(sum(A[0 .. -1]),sum(A))




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
      assert(sum([0,1]),1)
      assert(sum([0,0]),0)
      assert(sum([1,0]),1)
      assert(sum([5,5,5]),15)
      assert(sum([5,5,5]),_sum([5,5,5]))
      assert(sum([0]),0)
      assert(triangular_series(7), sum(A))

      one <- 1
      two <- 2
      three <- 3
      numbers <- [one, two, three]
      say(numbers)

      assert(len(numbers),3)
      assert(numbers[0],1)
      assert(numbers[1],2)
      assert(numbers[2],3)

      assert(numbers[0],one)
      assert(numbers[1],two)
      assert(numbers[2],three)
      assert(sum(numbers),6)

      assert(sum([one+1, two+1, three+1]),9)
      assert(sum([one+1, two+1, three+1]), sum(numbers)+3)

      #test sort
      assert(arr_eq([1,2,3], [1,2,3]), 1)
      assert(arr_eq([1,2,3,4], [1,2,3,4]), 1)
      assert(arr_eq([1,2,3], [1,2,3,4]), 0)
      assert(arr_eq([1,2,3], [5,2,3]), 0)
      assert(arr_eq([10,100], sort([100,10]) ), 1)
      assert(arr_eq(sort([3,2,1]), [1,2,3]), 1)
      assert(arr_eq(sort([2, 5, 4, 3, 1]), [1,2,3,4,5]), 1)

      assert(arr_eq(sort([12,8,2,9,15,4,13,0,6,11,7,1,14,5,3,10]), [i | 0 <= i <= 15]), 1)
      assert(arr_eq(sort([98,95,92,90,93,96,91,99,94,97]), [i | 90 <= i <= 99]), 1)

      say('All tests passed ;)').
