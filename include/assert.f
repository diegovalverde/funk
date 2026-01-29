

assert(actual, expected | actual != expected ):
    say('Assertion failed actual ', actual, '!= expected ', expected)
    exit().
    
assert(a,b):
    say(a,'=',b)
    1.

assert(line, actual, expected | actual != expected ):
    say('Assertion failed on line: ', line, ' actual ', actual, '!= expected ', expected)
    exit().
    
assert(line,a,b):
    say('line :', line, ' : ',  a,'=',b)
    1.

# array equality helper
arr_eq([],[]): 1.
arr_eq(A,B | len(A) != len(B)): 0.
arr_eq(a <~ [A] , b <~ [B] | a != b): 0.
arr_eq(a <~ [A] , b <~ [B]): arr_eq(A,B).
