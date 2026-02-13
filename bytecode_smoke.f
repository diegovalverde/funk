add(x, y): x + y.
pick(0): 40.
pick(n): n.
gate(n | n > 0): n.
gate(_): 0.
main():
    z <- add(2, -2)
    say("bytecode smoke ok")
    n <- len([1,2,3])
    r <- pick(z + n - 3) - 40
    gate(r + 1) - 1.
