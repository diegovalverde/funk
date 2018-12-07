
invalid = 0
int = 1
float = 2
array = 3
empty_array = 4
scalar=5
function = 5

to_str = {0: 'invalid', 1: 'int', 2: 'float', 3: 'array',
          4: 'empty_array', 5: 'function'}

llvm = {int: 'i32', float: 'float'}

def num(s):
    try:
        return int(s)
    except ValueError:
        return float(s)


