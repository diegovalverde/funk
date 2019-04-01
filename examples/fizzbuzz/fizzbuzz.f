#
# Example program: FizzBuzz!
#
use foreach

fbz(x | x % 15 = 0): say(x, ' FizzBuzz') .
fbz(x | x % 3 = 0):  say(x, ' Fizz') .
fbz(x | x % 5 = 0):  say(x, ' Buzz') .
fbz(x) : say(x).

main():
    foreach( [x | 1 <= x <= 100] ,  fbz ).