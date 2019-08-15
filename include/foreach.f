
foreach([],_): 1.

foreach( head <~ [tail], F):
    F(head)
    foreach(tail, F).

