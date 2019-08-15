
# returns a new list after applying function F
# to each individual element


map(_, []):
    say('mmmmm')
    [].

map(F, h <~ [t] ):
       say('map: ', h, ' ', F(h))
       F(h) ~> [map(F, t)].
