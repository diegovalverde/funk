#
# Example program: FizzBuzz!
#
use foreach

fbz(x | x % 15 = 0):
    say(x, ' FizzBuzz')
    1.
fbz(x | x % 3 = 0):
    say(x, ' Fizz')
    1.
fbz(x | x % 5 = 0):
    say(x, ' Buzz')
    1.
fbz(x):
    say(x)
    1.

main():
    foreach( [x | 1 <= x <= 100] ,  fbz ).
