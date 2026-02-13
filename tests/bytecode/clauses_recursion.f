pick(0): 40.
pick(n | n > 0): n.
pick(_): 0.

acc(0, total): total.
acc(n, total | n > 0): acc(n - 1, total + n).
acc(_, _): 0.

main():
    pick(0) - 40 + pick(3) - 3 + pick(-1) + acc(5, 0) - 15.
