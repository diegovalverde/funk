add(x, y): x + y.
pick(0): 40.
pick(n): n.
gate(n | n > 0): n.
gate(_): 0.
truthy(1): 1.
truthy(_): 0.
main():
    z <- add(2, -2)
    say("bytecode smoke ok")
    n <- len([1,2,3])
    arr <- [10,20,30]
    mid <- arr[1]
    r <- pick(z + n - 3) - 40
    t <- truthy(0)
    gate(r + 1) + mid - 21 + t.
