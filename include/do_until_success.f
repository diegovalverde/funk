

_do_until_success(_,[1,B]): [1,B].
_do_until_success([],_): [0,[]].
_do_until_success( f <~ [functions], [0,_]) : 
     func <- f[0]
     done <- func(f[1])
     _do_until_success(functions, done).

do_until_success(functions): _do_until_success(functions, [0,[]]).
