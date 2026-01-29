t_arr_eq([],[]): 1.
t_arr_eq(A,B | len(A) != len(B)): 0.
t_arr_eq(a <~ [A] , b <~ [B] | a != b): 0.
t_arr_eq(a <~ [A] , b <~ [B]): t_arr_eq(A,B).
