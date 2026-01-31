use tchk, t_arr_eq, and_guard
use accum, all, any, arg_eq, arg_neq, argmax, argmin, count, do_until_success
use find, find_all, max, min, neg, abs, nth, unique, set_diff, inverse
use transpose, diagonals, antidiagonals, shift_matrix, replace_matrix_element, sem_matrix
use roll, hroll

t_fail(_): [0,[]].
t_ok(x): [1,x].

test_include_core():
    # accum (sum)
    tchk(accum([1,2,3]), 6)

    # all / any (value aggregation)
    tchk(all([1,1,1], 1), 1)
    tchk(all([1,0,1], 1), 0)
    tchk(any([0,0,1], 1), 1)
    tchk(any([0,0,0], 1), 0)

    # arg_eq / arg_neq
    tchk(arg_eq([3,1,2], 1), 1)
    tchk(t_arr_eq(arg_neq([1,2,1], 1), [1]), 1)

    # count/find/find_all
    tchk(count([1,2,1,3], 1), 2)
    tchk(find(3, [1,2,3,4]), 2)
    tchk(t_arr_eq(find_all([1,2,3,2,4], 2), [1,3]), 1)

    # min/max and argmin/argmax
    tchk(min([3,1,2]), 1)
    tchk(max([3,1,2]), 3)
    tchk(argmin([3,1,2]), 1)
    tchk(argmax([3,1,2]), 0)

    # abs/neg/nth
    tchk(abs(0-5), 5)
    tchk(t_arr_eq(neg([0,1,0]), [1,0,1]), 1)
    tchk(t_arr_eq(nth([9,8,7], 1), [8,7]), 1)

    # unique/set_diff
    tchk(t_arr_eq(unique([1,1,2,3]), [1,2,3]), 1)
    tchk(t_arr_eq(set_diff([1,2,3], [2]), [1,3]), 1)

    # transpose/diagonals/antidiagonals
    M <- [[1,2,3],[4,5,6],[7,8,9]]
    tchk(t_arr_eq(transpose(M), [[1,4,7],[2,5,8],[3,6,9]]), 1)
    tchk(t_arr_eq(diagonals(M), [[2,6],[3],[1,5,9],[4,8],[7]]), 1)
    tchk(t_arr_eq(antidiagonals(M), [[4,2],[1],[7,5,3],[8,6],[9]]), 1)

    # inverse, replace_matrix_element, sem_matrix, shift_matrix
    tchk(t_arr_eq(inverse([1,2,3]), [3,2,1]), 1)
    M2 <- replace_matrix_element(M, 9, [1,1])
    tchk(M2[1,1], 9)
    tchk(t_arr_eq(sem_matrix(3,3,1,1), [[0,0,0],[0,1,0],[0,0,0]]), 1)
    tchk(t_arr_eq(shift_matrix(M, [1,0]), M), 1)

    # do_until_success
    tchk(t_arr_eq(do_until_success([ [t_fail, 1], [t_ok, 2] ]), [1,2]), 1)

    # roll/hroll
    tchk(t_arr_eq(roll(M,1,1), [[9,7,8],[3,1,2],[6,4,5]]), 1)
    tchk(t_arr_eq(hroll(M,1), [[3,1,2],[6,4,5],[9,7,8]]), 1)

    # boolean AND (/\) guard chaining
    tchk(and_guard(2,2), 1)
    tchk(and_guard(2,3), 0)

    1.
