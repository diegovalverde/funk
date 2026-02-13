add(x, y): x + y.
pick(0): 40.
pick(n): n.
main():
    z <- add(2, -2)
    say("bytecode smoke ok")
    n <- len([1,2,3])
    pick(z + n - 3) - 40.
