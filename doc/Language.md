# Funk Language Overview

Funk is an experimental functional programming language inspired by Erlang and Python. It favors clear, expression-oriented code, immutable variables, and recursion/pattern matching over imperative control flow.

This document summarizes the core syntax and features and points to existing examples in the repo. It is derived from the grammar in `funk/funky_ll1.lark` and the preprocessor in `funk/preprocessor.py`.

---

## Core Ideas

- **Immutable variables**: once a name is bound, it cannot be reassigned.
- **Expression-oriented**: the last statement in a function is the return value.
- **No `if` statements**: use **function preconditions** (guards) and pattern matching.
- **Function overloading**: multiple clauses with different patterns/guards can define the same function.
- **Lists as linked lists**: list decomposition is fundamental to recursion.
- **Pattern matching**: supports matching empty lists, head/tail, and fixed-length list patterns.

---

## Basic Syntax

### Function Definitions

```
add(x, y):
    x + y.
```

The final statement in a function is the return value. A function may contain multiple statements, but only the last one returns.

### Variables (Immutable)

Use `<-` to bind a name once:

```
double(x):
    y <- x * 2
    y.
```

Attempting to reassign `y` later is a runtime error.

### Literals

- **Numbers**: integers, hex (`0xFF`), and floats.
- **Strings**: single- or double-quoted; optional Python-like prefixes (`r`, `u`, `b`, `f`) are accepted by the lexer.

### Operators

- **Arithmetic**: `+`, `-`, `*`, `/`, `%`
- **Comparison**: `=`, `!=`, `<`, `<=`, `>`, `>=`
- **Boolean**: `/\\` (and), `\\/` (or)

### Comments

```
# This is a comment
```

---

## Function Overloading and Guards

Funk lets you define multiple clauses for the same function:

```
fibo(0): 0.
fibo(1): 1.
fibo(n):
    fibo(n-1) + fibo(n-2).
```

Guards (preconditions) appear after `|`:

```
sign(x | x < 0): -1.
sign(_): 1.
```

Guards can be arbitrary boolean expressions (not restricted to "pure" guards like Erlang).

### Variadic/Ignore Arguments

You can ignore arguments with `_` and accept trailing arguments with `...` or `etc`:

```
keep_second(_, y): y.

sum([], acc, ...): acc.
sum([], acc, etc): acc.
```

---

## Lists

### List Literals

```
A <- [1,2,3,4].
```

Lists can be **heterogeneous** (any expression can be an element):

```
mix <- [1, "two", [3], f(4)].
```

### Head/Tail Pattern Matching

```
sum([]): 0.
sum(h <~ [t]):
    h + sum(t).
```

`h <~ [t]` binds the head and tail of a list.

### Concatenation Operators

- **Head prepend**: `x ~> [L]`
- **Tail append**: `[L] <~ x`
- **List concatenation**: `[A] ++ [B]`
- **List difference**: `[A] -- [B]`

```
prepend_example(x, L): x ~> [L].
append_example(L, x): [L] <~ x.
concat_example(A, B): [A] ++ [B].
diff_example(A, B): [A] -- [B].
```

### Ranges and List Comprehensions

```
[i | 1 <= i <= 10]          # 1..10
[2 * i | 0 <= i <= 5]       # [0,2,4,6,8,10]
```

Ranges can be exclusive or inclusive in comprehensions:

```
[i | 1 < i < 10]
[i | 1 <= i <= 10]
```

You can also iterate over an existing list:

```
[x * x | x : xs]
```

Inline list ranges in literals use `..`:

```
[0 .. 5]
[A[0] .. A[-1]]
```

---

## Arrays / Indexing

Lists can be indexed:

```
A <- [10,20,30].
x <- A[0]       # 10
y <- A[-1]      # 30 (wraps)
```

Slicing supports ranges:

```
B <- A[0 .. -1]   # full copy
B <- A[..]        # full copy (omitted start/end)
L <- A[..2]       # from start to index 2 (inclusive)
R <- A[2..]       # from index 2 to end
```

For matrices, indexing is `M[i,j]` and slices can use multiple ranges:

```
cell <- M[i,j]
sub  <- M[i0 .. i1, j0 .. j1]
col0 <- M[.., 0]
rows <- M[1.., ..]
```

---

## Conditional Assignment

```
x <-? n % 2 = 0: 1, -1
```

If `n % 2 = 0` is true, `x` becomes `1`, otherwise `-1`.

---

## Functional Features

### Higher-Order Functions

Functions are values and can be passed around:

```
apply_twice(F, x):
    F(F(x)).
```

### Recursion

Recursion is idiomatic (loops are modeled via recursion or comprehensions).

### Pure Functions (Mostly)

Most code is side-effect-free. I/O uses built-in functions like `say`, `file`, `in`, etc.

---

## Includes

Use `use` to include externally defined functions:

```
use foreach, map
```

---

## Preprocessor Macros

The preprocessor supports simple macro replacement using `<->` on its own line:

```
W <-> 50
H <-> 50
```

Each `NAME <-> value` line is removed and later occurrences of `NAME` are replaced with `value` (simple textual substitution).

---

## Example Programs (External Examples Repo)

### FizzBuzz
`$FUNK_EXAMPLES_PATH/fizzbuzz.f`

### Sorting
`include/sort.f` and `$FUNK_EXAMPLES_PATH/merge_sort.f`

### Game of Life
`$FUNK_EXAMPLES_PATH/graphics/game_of_life.f`

### Sudoku (backtracking)
`$FUNK_EXAMPLES_PATH/games/sudoku.f` (uses `sudoku_backtracking` from include libs)

### Connect-4
`$FUNK_EXAMPLES_PATH/games/connect4.f`

### 8-Puzzle
`$FUNK_EXAMPLES_PATH/games/puzzle_8_main.f`

---

## Runtime/Library Helpers

Check the `include/` folder for reusable utilities:

- List ops: `unique.f`, `set_diff.f`, `count.f`, `find.f`
- Matrix ops: `transpose.f`, `diagonals.f`, `antidiagonals.f`
- Higher-order: `map.f`, `foreach.f`, `do_until_success.f`

---

## Notes and Caveats

- Some operators behave differently from other languages:
  - `=` is equality, not assignment.
- Variables are immutable after `<-`.
- `if` is not a keyword; use function guards and pattern matching instead.

---

## Quick Reference

```
# Function
f(x,y): x + y.

# Guarded clause
f(x | x < 0): -1.

# Immutable binding
y <- x * 2

# Lists
[]           # empty
[1,2,3]
h <~ [t]     # head/tail
x ~> [L]     # prepend
[L] <~ x     # append
[A] ++ [B]   # concat
[A] -- [B]   # difference
[0 .. 5]     # range literal
[x | x : xs] # comprehension over list

# Comprehension
[expr | 0 <= i <= 10]
```
