use sort

custom_function(l,r | l[0] < r[0]): 1.
custom_function(l,r ): 0.

argmax(L): 
    list <- [ [L[i],i] | 0 <= i < len(L) ]
    sorted_list <- sort(list, custom_function )
    [ sorted_list[i,1] | 0 <= i < len(sorted_list) ].