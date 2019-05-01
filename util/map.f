
# returns a new list after applying function F
# to each individual element


map(_, []): [].

map(F, h <~ [t] ):
       F(h) ~> [map(F, t)].


