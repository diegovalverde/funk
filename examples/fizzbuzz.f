use foreach

fbz(x | x % 15 = 0): say('FizzBuzz') .
fbz(x | x % 3 = 0): say('Fizz') .
fbz(x | x % 5 = 0): say('Buzz') .
fbz(x) : say(x).

main():
    Y <- [x | 1 <= x <= 100]
    foreach( Y ,  fbz ).