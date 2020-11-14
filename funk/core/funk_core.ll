; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.16.0"

%struct.tpool = type { [1024 x %struct.tdata], i32 }
%struct.tdata = type { i8, %union.data_type }
%union.data_type = type { double }
%struct.tnode = type { i32, i32, %struct.tpool*, %struct.tdimensions }
%struct.tdimensions = type { i32, [2 x i32] }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }

@g_funk_debug_current_executed_line = global i32 0, align 4
@g_funk_internal_function_tracing_enabled = global i32 1, align 4
@funk_types_str = global [7 x [100 x i8]] [[100 x i8] c"type_invalid\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_int\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_double\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_empty_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_scalar\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_function\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00"], align 16
@g_funk_print_array_max_elements = global i32 30, align 4
@g_funk_print_array_element_per_row = global i32 50, align 4
@g_funk_verbosity = global i32 0, align 4
@funk_sleep.first = internal global i32 1, align 4
@.str = private unnamed_addr constant [11 x i8] c"START %s \0A\00", align 1
@__FUNCTION__.funk_print_node_info = private unnamed_addr constant [21 x i8] c"funk_print_node_info\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"%s[%d :%d] %d-dimensional\00", align 1
@funk_global_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str.2 = private unnamed_addr constant [6 x i8] c"gpool\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"fpool\00", align 1
@.str.4 = private unnamed_addr constant [9 x i8] c"END %s \0A\00", align 1
@__FUNCTION__.funk_copy_node = private unnamed_addr constant [15 x i8] c"funk_copy_node\00", align 1
@__FUNCTION__.set_s2d_user_global_state = private unnamed_addr constant [26 x i8] c"set_s2d_user_global_state\00", align 1
@gRenderLoopState = common global %struct.tnode zeroinitializer, align 8
@.str.5 = private unnamed_addr constant [6 x i8] c">>>>\0A\00", align 1
@__FUNCTION__.get_s2d_user_global_state = private unnamed_addr constant [26 x i8] c"get_s2d_user_global_state\00", align 1
@.str.6 = private unnamed_addr constant [43 x i8] c"-I- Setting conf parameter %d to value %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.8 = private unnamed_addr constant [24 x i8] c"-E- %s Invalid type %d\0A\00", align 1
@__FUNCTION__.funk_print_type = private unnamed_addr constant [16 x i8] c"funk_print_type\00", align 1
@.str.9 = private unnamed_addr constant [4 x i8] c"%s \00", align 1
@__FUNCTION__.funk_init = private unnamed_addr constant [10 x i8] c"funk_init\00", align 1
@funk_functions_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str.10 = private unnamed_addr constant [39 x i8] c"===== FUNK Interactive debugger =====\0A\00", align 1
@.str.11 = private unnamed_addr constant [25 x i8] c"-I- Global pool size %d\0A\00", align 1
@.str.12 = private unnamed_addr constant [26 x i8] c"-I- init_random_seed: %d\0A\00", align 1
@.str.13 = private unnamed_addr constant [24 x i8] c"Press any key to start\0A\00", align 1
@__FUNCTION__.is_list_consecutive_in_memory = private unnamed_addr constant [30 x i8] c"is_list_consecutive_in_memory\00", align 1
@.str.14 = private unnamed_addr constant [50 x i8] c"-E- %s node lhs data type is %d but shall be int\0A\00", align 1
@__FUNCTION__.funk_create_list_slide_2d_var = private unnamed_addr constant [30 x i8] c"funk_create_list_slide_2d_var\00", align 1
@.str.15 = private unnamed_addr constant [14 x i8] c"%s i=%d j=%d\0A\00", align 1
@.str.16 = private unnamed_addr constant [42 x i8] c"-E- %s index %d out of array boundary %d\0A\00", align 1
@.str.17 = private unnamed_addr constant [13 x i8] c"las pelotas\0A\00", align 1
@__FUNCTION__.funk_create_list_slide_1d_var = private unnamed_addr constant [30 x i8] c"funk_create_list_slide_1d_var\00", align 1
@.str.18 = private unnamed_addr constant [76 x i8] c"-E- %s the number of indexes provided %d does not match dimension count %d\0A\00", align 1
@__FUNCTION__.funk_create_list_slide = private unnamed_addr constant [23 x i8] c"funk_create_list_slide\00", align 1
@.str.19 = private unnamed_addr constant [56 x i8] c"-E- %s the index %d >  upper bound %d for dimension %d\0A\00", align 1
@.str.20 = private unnamed_addr constant [44 x i8] c"-E- %s %d dimensions are not yet supported\0A\00", align 1
@.str.21 = private unnamed_addr constant [41 x i8] c"-E- %s index %d out of range for len %d\0A\00", align 1
@__FUNCTION__.funk_create_list = private unnamed_addr constant [17 x i8] c"funk_create_list\00", align 1
@__FUNCTION__.funk_create_2d_matrix = private unnamed_addr constant [22 x i8] c"funk_create_2d_matrix\00", align 1
@.str.22 = private unnamed_addr constant [27 x i8] c">>>>> %d %d pool_tail: %d\0A\00", align 1
@.str.23 = private unnamed_addr constant [16 x i8] c"%s %s[%d] = %d\0A\00", align 1
@__FUNCTION__.funk_create_int_scalar = private unnamed_addr constant [23 x i8] c"funk_create_int_scalar\00", align 1
@.str.24 = private unnamed_addr constant [16 x i8] c"%s %s[%d] = %f\0A\00", align 1
@__FUNCTION__.funk_create_float_scalar = private unnamed_addr constant [25 x i8] c"funk_create_float_scalar\00", align 1
@__FUNCTION__.funk_create_list_int_literal = private unnamed_addr constant [29 x i8] c"funk_create_list_int_literal\00", align 1
@__FUNCTION__.funk_create_2d_matrix_int_literal = private unnamed_addr constant [34 x i8] c"funk_create_2d_matrix_int_literal\00", align 1
@__FUNCTION__.funk_copy_element_from_pool = private unnamed_addr constant [28 x i8] c"funk_copy_element_from_pool\00", align 1
@.str.25 = private unnamed_addr constant [38 x i8] c"-E- Indexes %d, %d are out of bounds\0A\00", align 1
@.str.26 = private unnamed_addr constant [6 x i8] c" %5d \00", align 1
@.str.27 = private unnamed_addr constant [8 x i8] c" %5.5f \00", align 1
@.str.28 = private unnamed_addr constant [6 x i8] c" %5s \00", align 1
@.str.29 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str.30 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.31 = private unnamed_addr constant [10 x i8] c"%s %s[%d]\00", align 1
@__FUNCTION__.funk_get_node_type = private unnamed_addr constant [19 x i8] c"funk_get_node_type\00", align 1
@.str.32 = private unnamed_addr constant [43 x i8] c"-E- %s: offset %d out of bounds for len %d\00", align 1
@.str.33 = private unnamed_addr constant [3 x i8] c"\0A \00", align 1
@__FUNCTION__.funk_set_node_type = private unnamed_addr constant [19 x i8] c"funk_set_node_type\00", align 1
@__FUNCTION__.funk_set_node_value_int = private unnamed_addr constant [24 x i8] c"funk_set_node_value_int\00", align 1
@.str.34 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.35 = private unnamed_addr constant [25 x i8] c"%s %s start: %d len: %d\0A\00", align 1
@__FUNCTION__.funk_get_next_node = private unnamed_addr constant [19 x i8] c"funk_get_next_node\00", align 1
@funk_debug_function_entry_hook.run_until_the_end = internal global i32 0, align 4
@.str.36 = private unnamed_addr constant [38 x i8] c"Stopped at the beginning of function\0A\00", align 1
@.str.37 = private unnamed_addr constant [2 x i8] c">\00", align 1
@__stdinp = external global %struct.__sFILE*, align 8
@.str.38 = private unnamed_addr constant [7 x i8] c"nostop\00", align 1
@.str.39 = private unnamed_addr constant [2 x i8] c"q\00", align 1
@.str.40 = private unnamed_addr constant [2 x i8] c"c\00", align 1
@__FUNCTION__.funk_memcp_arr = private unnamed_addr constant [15 x i8] c"funk_memcp_arr\00", align 1
@.str.41 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.42 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.43 = private unnamed_addr constant [10 x i8] c" = %s[%d]\00", align 1
@.str.44 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
@__FUNCTION__.funk_add_ri = private unnamed_addr constant [12 x i8] c"funk_add_ri\00", align 1
@.str.45 = private unnamed_addr constant [54 x i8] c"-E- Invalid index %d is greater than array size of %d\00", align 1
@.str.46 = private unnamed_addr constant [34 x i8] c"-E- funk_mul_rr: invalid types:\0A \00", align 1
@.str.47 = private unnamed_addr constant [8 x i8] c"lit(%d)\00", align 1
@.str.48 = private unnamed_addr constant [24 x i8] c"-E- %s: invalid types: \00", align 1
@__FUNCTION__.funk_arith_op_rr = private unnamed_addr constant [17 x i8] c"funk_arith_op_rr\00", align 1
@.str.49 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.50 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.51 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.52 = private unnamed_addr constant [40 x i8] c" [...] %d-dimensional with %d elements\0A\00", align 1
@.str.53 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.54 = private unnamed_addr constant [30 x i8] c"-E- File '%s' cannot be read\0A\00", align 1
@.str.55 = private unnamed_addr constant [21 x i8] c"-D- Opened file '%s'\00", align 1
@.str.56 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.57 = private unnamed_addr constant [15 x i8] c"pool[%d] = %d\0A\00", align 1
@.str.58 = private unnamed_addr constant [13 x i8] c"node: %d %d\0A\00", align 1
@.str.59 = private unnamed_addr constant [14 x i8] c"%d:[%d x %d]\0A\00", align 1
@.str.60 = private unnamed_addr constant [66 x i8] c"-E- reshape operation not possible for variable with %d elements\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sleep(i32) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* @funk_sleep.first, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  store i32 0, i32* @funk_sleep.first, align 4
  br label %9

6:                                                ; preds = %1
  %7 = load i32, i32* %2, align 4
  %8 = call i32 @"\01_sleep"(i32 %7)
  br label %9

9:                                                ; preds = %6, %5
  ret void
}

declare i32 @"\01_sleep"(i32) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node_info(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0))
  br label %7

7:                                                ; preds = %5, %1
  %8 = load %struct.tnode*, %struct.tnode** %2, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 2
  %10 = load %struct.tpool*, %struct.tpool** %9, align 8
  %11 = icmp eq %struct.tpool* %10, @funk_global_memory_pool
  %12 = zext i1 %11 to i64
  %13 = select i1 %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %14 = load %struct.tnode*, %struct.tnode** %2, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  %17 = load %struct.tnode*, %struct.tnode** %2, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 1
  %19 = load i32, i32* %18, align 4
  %20 = load %struct.tnode*, %struct.tnode** %2, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 3
  %22 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.1, i64 0, i64 0), i8* %13, i32 %16, i32 %19, i32 %23)
  %25 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %29

27:                                               ; preds = %7
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0))
  br label %29

29:                                               ; preds = %27, %7
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_copy_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %6 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %2
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__.funk_copy_node, i64 0, i64 0))
  br label %10

10:                                               ; preds = %8, %2
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 0
  %13 = load i32, i32* %12, align 8
  %14 = load %struct.tnode*, %struct.tnode** %3, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 0
  store i32 %13, i32* %15, align 8
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 1
  %18 = load i32, i32* %17, align 4
  %19 = load %struct.tnode*, %struct.tnode** %3, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  store i32 %18, i32* %20, align 4
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 3
  %23 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = load %struct.tnode*, %struct.tnode** %3, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 3
  %27 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %26, i32 0, i32 0
  store i32 %24, i32* %27, align 8
  store i32 0, i32* %5, align 4
  br label %28

28:                                               ; preds = %45, %10
  %29 = load i32, i32* %5, align 4
  %30 = icmp slt i32 %29, 2
  br i1 %30, label %31, label %48

31:                                               ; preds = %28
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 3
  %34 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %33, i32 0, i32 1
  %35 = load i32, i32* %5, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [2 x i32], [2 x i32]* %34, i64 0, i64 %36
  %38 = load i32, i32* %37, align 4
  %39 = load %struct.tnode*, %struct.tnode** %3, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 3
  %41 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %40, i32 0, i32 1
  %42 = load i32, i32* %5, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [2 x i32], [2 x i32]* %41, i64 0, i64 %43
  store i32 %38, i32* %44, align 4
  br label %45

45:                                               ; preds = %31
  %46 = load i32, i32* %5, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, i32* %5, align 4
  br label %28

48:                                               ; preds = %28
  %49 = load %struct.tnode*, %struct.tnode** %4, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 2
  %51 = load %struct.tpool*, %struct.tpool** %50, align 8
  %52 = load %struct.tnode*, %struct.tnode** %3, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 2
  store %struct.tpool* %51, %struct.tpool** %53, align 8
  %54 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %58

56:                                               ; preds = %48
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__.funk_copy_node, i64 0, i64 0))
  br label %58

58:                                               ; preds = %56, %48
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @set_s2d_user_global_state(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.set_s2d_user_global_state, i64 0, i64 0))
  br label %7

7:                                                ; preds = %5, %1
  %8 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_print_node_info(%struct.tnode* %8)
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_copy_node(%struct.tnode* @gRenderLoopState, %struct.tnode* %9)
  call void @funk_print_node_info(%struct.tnode* @gRenderLoopState)
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0))
  %11 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %7
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.set_s2d_user_global_state, i64 0, i64 0))
  br label %15

15:                                               ; preds = %13, %7
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @get_s2d_user_global_state(%struct.tnode* noalias sret) #0 {
  %2 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %4, label %6

4:                                                ; preds = %1
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.get_s2d_user_global_state, i64 0, i64 0))
  br label %6

6:                                                ; preds = %4, %1
  call void @funk_print_node_info(%struct.tnode* @gRenderLoopState)
  %7 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %11

9:                                                ; preds = %6
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.get_s2d_user_global_state, i64 0, i64 0))
  br label %11

11:                                               ; preds = %9, %6
  %12 = bitcast %struct.tnode* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %12, i8* align 8 bitcast (%struct.tnode* @gRenderLoopState to i8*), i64 32, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_config_param(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.6, i64 0, i64 0), i32 %5, i32 %6)
  %8 = load i32, i32* %3, align 4
  switch i32 %8, label %14 [
    i32 0, label %9
    i32 1, label %11
  ]

9:                                                ; preds = %2
  %10 = load i32, i32* %4, align 4
  store i32 %10, i32* @g_funk_verbosity, align 4
  br label %14

11:                                               ; preds = %2
  %12 = load i32, i32* %4, align 4
  store i32 %12, i32* @g_funk_print_array_max_elements, align 4
  br label %14

13:                                               ; No predecessors!
  br label %14

14:                                               ; preds = %2, %13, %11, %9
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_type(i8 zeroext) #0 {
  %2 = alloca i8, align 1
  store i8 %0, i8* %2, align 1
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i32
  %5 = icmp sge i32 %4, 0
  br i1 %5, label %6, label %16

6:                                                ; preds = %1
  %7 = load i8, i8* %2, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp slt i32 %8, 7
  br i1 %9, label %10, label %16

10:                                               ; preds = %6
  %11 = load i8, i8* %2, align 1
  %12 = zext i8 %11 to i64
  %13 = getelementptr inbounds [7 x [100 x i8]], [7 x [100 x i8]]* @funk_types_str, i64 0, i64 %12
  %14 = getelementptr inbounds [100 x i8], [100 x i8]* %13, i64 0, i64 0
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.7, i64 0, i64 0), i8* %14)
  br label %20

16:                                               ; preds = %6, %1
  %17 = load i8, i8* %2, align 1
  %18 = zext i8 %17 to i32
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_type, i64 0, i64 0), i32 %18)
  br label %20

20:                                               ; preds = %16, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_init() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_init, i64 0, i64 0))
  %4 = call i64 @time(i64* null)
  %5 = trunc i64 %4 to i32
  store i32 %5, i32* %1, align 4
  %6 = load i32, i32* %1, align 4
  call void @srand(i32 %6)
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 1), align 8
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 1), align 8
  store i32 0, i32* %2, align 4
  br label %7

7:                                                ; preds = %16, %0
  %8 = load i32, i32* %2, align 4
  %9 = icmp slt i32 %8, 1024
  br i1 %9, label %10, label %19

10:                                               ; preds = %7
  %11 = load i32, i32* %2, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 0), i64 0, i64 %12
  %14 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %15 = bitcast %union.data_type* %14 to i32*
  store i32 0, i32* %15, align 8
  br label %16

16:                                               ; preds = %10
  %17 = load i32, i32* %2, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, i32* %2, align 4
  br label %7

19:                                               ; preds = %7
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.10, i64 0, i64 0))
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.11, i64 0, i64 0), i32 1024)
  %22 = load i32, i32* %1, align 4
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.12, i64 0, i64 0), i32 %22)
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.13, i64 0, i64 0))
  %25 = call i32 @getchar()
  ret void
}

declare i64 @time(i64*) #1

declare void @srand(i32) #1

declare i32 @getchar() #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @is_list_consecutive_in_memory(%struct.tnode*, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  %9 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %13

11:                                               ; preds = %2
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.is_list_consecutive_in_memory, i64 0, i64 0))
  br label %13

13:                                               ; preds = %11, %2
  %14 = load i32, i32* %5, align 4
  %15 = icmp sle i32 %14, 1
  br i1 %15, label %16, label %17

16:                                               ; preds = %13
  store i32 1, i32* %3, align 4
  br label %43

17:                                               ; preds = %13
  %18 = load %struct.tnode*, %struct.tnode** %4, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i64 0
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  store i32 %21, i32* %6, align 4
  store i32 1, i32* %7, align 4
  br label %22

22:                                               ; preds = %39, %17
  %23 = load i32, i32* %7, align 4
  %24 = load i32, i32* %5, align 4
  %25 = icmp slt i32 %23, %24
  br i1 %25, label %26, label %42

26:                                               ; preds = %22
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = load i32, i32* %7, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i64 %29
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  store i32 %32, i32* %8, align 4
  %33 = load i32, i32* %6, align 4
  %34 = add nsw i32 %33, 1
  %35 = load i32, i32* %8, align 4
  %36 = icmp ne i32 %34, %35
  br i1 %36, label %37, label %38

37:                                               ; preds = %26
  store i32 0, i32* %3, align 4
  br label %43

38:                                               ; preds = %26
  br label %39

39:                                               ; preds = %38
  %40 = load i32, i32* %7, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %7, align 4
  br label %22

42:                                               ; preds = %22
  store i32 0, i32* %3, align 4
  br label %43

43:                                               ; preds = %42, %37, %16
  %44 = load i32, i32* %3, align 4
  ret i32 %44
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_slide_2d_var(%struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store %struct.tnode* %3, %struct.tnode** %8, align 8
  %11 = load %struct.tnode*, %struct.tnode** %7, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 2
  %13 = load %struct.tpool*, %struct.tpool** %12, align 8
  %14 = getelementptr inbounds %struct.tpool, %struct.tpool* %13, i32 0, i32 0
  %15 = load %struct.tnode*, %struct.tnode** %7, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %14, i64 0, i64 %18
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = zext i8 %21 to i32
  %23 = icmp ne i32 %22, 1
  br i1 %23, label %24, label %38

24:                                               ; preds = %4
  %25 = load %struct.tnode*, %struct.tnode** %7, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 2
  %27 = load %struct.tpool*, %struct.tpool** %26, align 8
  %28 = getelementptr inbounds %struct.tpool, %struct.tpool* %27, i32 0, i32 0
  %29 = load %struct.tnode*, %struct.tnode** %7, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 8
  %32 = zext i32 %31 to i64
  %33 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %28, i64 0, i64 %32
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 0
  %35 = load i8, i8* %34, align 8
  %36 = zext i8 %35 to i32
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.14, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %36)
  br label %38

38:                                               ; preds = %24, %4
  %39 = load %struct.tnode*, %struct.tnode** %8, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 2
  %41 = load %struct.tpool*, %struct.tpool** %40, align 8
  %42 = getelementptr inbounds %struct.tpool, %struct.tpool* %41, i32 0, i32 0
  %43 = load %struct.tnode*, %struct.tnode** %8, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %42, i64 0, i64 %46
  %48 = getelementptr inbounds %struct.tdata, %struct.tdata* %47, i32 0, i32 0
  %49 = load i8, i8* %48, align 8
  %50 = zext i8 %49 to i32
  %51 = icmp ne i32 %50, 1
  br i1 %51, label %52, label %66

52:                                               ; preds = %38
  %53 = load %struct.tnode*, %struct.tnode** %8, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 2
  %55 = load %struct.tpool*, %struct.tpool** %54, align 8
  %56 = getelementptr inbounds %struct.tpool, %struct.tpool* %55, i32 0, i32 0
  %57 = load %struct.tnode*, %struct.tnode** %8, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 0
  %59 = load i32, i32* %58, align 8
  %60 = zext i32 %59 to i64
  %61 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %56, i64 0, i64 %60
  %62 = getelementptr inbounds %struct.tdata, %struct.tdata* %61, i32 0, i32 0
  %63 = load i8, i8* %62, align 8
  %64 = zext i8 %63 to i32
  %65 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.14, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %64)
  br label %66

66:                                               ; preds = %52, %38
  %67 = load %struct.tnode*, %struct.tnode** %7, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 2
  %69 = load %struct.tpool*, %struct.tpool** %68, align 8
  %70 = getelementptr inbounds %struct.tpool, %struct.tpool* %69, i32 0, i32 0
  %71 = load %struct.tnode*, %struct.tnode** %7, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 0
  %73 = load i32, i32* %72, align 8
  %74 = zext i32 %73 to i64
  %75 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %70, i64 0, i64 %74
  %76 = getelementptr inbounds %struct.tdata, %struct.tdata* %75, i32 0, i32 1
  %77 = bitcast %union.data_type* %76 to i32*
  %78 = load i32, i32* %77, align 8
  store i32 %78, i32* %9, align 4
  %79 = load %struct.tnode*, %struct.tnode** %8, align 8
  %80 = getelementptr inbounds %struct.tnode, %struct.tnode* %79, i32 0, i32 2
  %81 = load %struct.tpool*, %struct.tpool** %80, align 8
  %82 = getelementptr inbounds %struct.tpool, %struct.tpool* %81, i32 0, i32 0
  %83 = load %struct.tnode*, %struct.tnode** %8, align 8
  %84 = getelementptr inbounds %struct.tnode, %struct.tnode* %83, i32 0, i32 0
  %85 = load i32, i32* %84, align 8
  %86 = zext i32 %85 to i64
  %87 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %82, i64 0, i64 %86
  %88 = getelementptr inbounds %struct.tdata, %struct.tdata* %87, i32 0, i32 1
  %89 = bitcast %union.data_type* %88 to i32*
  %90 = load i32, i32* %89, align 8
  store i32 %90, i32* %10, align 4
  %91 = load i32, i32* %9, align 4
  %92 = icmp slt i32 %91, 0
  br i1 %92, label %93, label %101

93:                                               ; preds = %66
  %94 = load %struct.tnode*, %struct.tnode** %5, align 8
  %95 = getelementptr inbounds %struct.tnode, %struct.tnode* %94, i32 0, i32 3
  %96 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %95, i32 0, i32 1
  %97 = getelementptr inbounds [2 x i32], [2 x i32]* %96, i64 0, i64 0
  %98 = load i32, i32* %97, align 4
  %99 = load i32, i32* %9, align 4
  %100 = sub i32 %98, %99
  br label %103

101:                                              ; preds = %66
  %102 = load i32, i32* %9, align 4
  br label %103

103:                                              ; preds = %101, %93
  %104 = phi i32 [ %100, %93 ], [ %102, %101 ]
  store i32 %104, i32* %9, align 4
  %105 = load i32, i32* %10, align 4
  %106 = icmp slt i32 %105, 0
  br i1 %106, label %107, label %115

107:                                              ; preds = %103
  %108 = load %struct.tnode*, %struct.tnode** %5, align 8
  %109 = getelementptr inbounds %struct.tnode, %struct.tnode* %108, i32 0, i32 3
  %110 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %109, i32 0, i32 1
  %111 = getelementptr inbounds [2 x i32], [2 x i32]* %110, i64 0, i64 1
  %112 = load i32, i32* %111, align 4
  %113 = load i32, i32* %10, align 4
  %114 = sub i32 %112, %113
  br label %117

115:                                              ; preds = %103
  %116 = load i32, i32* %10, align 4
  br label %117

117:                                              ; preds = %115, %107
  %118 = phi i32 [ %114, %107 ], [ %116, %115 ]
  store i32 %118, i32* %10, align 4
  %119 = load i32, i32* %9, align 4
  %120 = load i32, i32* %10, align 4
  %121 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %119, i32 %120)
  %122 = load i32, i32* %9, align 4
  %123 = load %struct.tnode*, %struct.tnode** %5, align 8
  %124 = getelementptr inbounds %struct.tnode, %struct.tnode* %123, i32 0, i32 3
  %125 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %124, i32 0, i32 1
  %126 = getelementptr inbounds [2 x i32], [2 x i32]* %125, i64 0, i64 0
  %127 = load i32, i32* %126, align 4
  %128 = icmp uge i32 %122, %127
  br i1 %128, label %129, label %137

129:                                              ; preds = %117
  %130 = load i32, i32* %9, align 4
  %131 = load %struct.tnode*, %struct.tnode** %5, align 8
  %132 = getelementptr inbounds %struct.tnode, %struct.tnode* %131, i32 0, i32 3
  %133 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %132, i32 0, i32 1
  %134 = getelementptr inbounds [2 x i32], [2 x i32]* %133, i64 0, i64 0
  %135 = load i32, i32* %134, align 4
  %136 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.16, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %130, i32 %135)
  br label %137

137:                                              ; preds = %129, %117
  %138 = load i32, i32* %10, align 4
  %139 = load %struct.tnode*, %struct.tnode** %5, align 8
  %140 = getelementptr inbounds %struct.tnode, %struct.tnode* %139, i32 0, i32 3
  %141 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %140, i32 0, i32 1
  %142 = getelementptr inbounds [2 x i32], [2 x i32]* %141, i64 0, i64 1
  %143 = load i32, i32* %142, align 4
  %144 = icmp uge i32 %138, %143
  br i1 %144, label %145, label %153

145:                                              ; preds = %137
  %146 = load i32, i32* %10, align 4
  %147 = load %struct.tnode*, %struct.tnode** %5, align 8
  %148 = getelementptr inbounds %struct.tnode, %struct.tnode* %147, i32 0, i32 3
  %149 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %148, i32 0, i32 1
  %150 = getelementptr inbounds [2 x i32], [2 x i32]* %149, i64 0, i64 1
  %151 = load i32, i32* %150, align 4
  %152 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.16, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %146, i32 %151)
  br label %153

153:                                              ; preds = %145, %137
  %154 = load %struct.tnode*, %struct.tnode** %5, align 8
  %155 = getelementptr inbounds %struct.tnode, %struct.tnode* %154, i32 0, i32 2
  %156 = load %struct.tpool*, %struct.tpool** %155, align 8
  %157 = load %struct.tnode*, %struct.tnode** %6, align 8
  %158 = getelementptr inbounds %struct.tnode, %struct.tnode* %157, i32 0, i32 2
  store %struct.tpool* %156, %struct.tpool** %158, align 8
  %159 = load %struct.tnode*, %struct.tnode** %6, align 8
  %160 = getelementptr inbounds %struct.tnode, %struct.tnode* %159, i32 0, i32 3
  %161 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %160, i32 0, i32 0
  store i32 0, i32* %161, align 8
  %162 = load %struct.tnode*, %struct.tnode** %6, align 8
  %163 = getelementptr inbounds %struct.tnode, %struct.tnode* %162, i32 0, i32 1
  store i32 1, i32* %163, align 4
  %164 = load %struct.tnode*, %struct.tnode** %5, align 8
  %165 = getelementptr inbounds %struct.tnode, %struct.tnode* %164, i32 0, i32 0
  %166 = load i32, i32* %165, align 8
  %167 = load %struct.tnode*, %struct.tnode** %5, align 8
  %168 = getelementptr inbounds %struct.tnode, %struct.tnode* %167, i32 0, i32 3
  %169 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %168, i32 0, i32 1
  %170 = getelementptr inbounds [2 x i32], [2 x i32]* %169, i64 0, i64 1
  %171 = load i32, i32* %170, align 4
  %172 = load i32, i32* %9, align 4
  %173 = mul i32 %171, %172
  %174 = add i32 %166, %173
  %175 = load i32, i32* %10, align 4
  %176 = add i32 %174, %175
  %177 = load %struct.tnode*, %struct.tnode** %6, align 8
  %178 = getelementptr inbounds %struct.tnode, %struct.tnode* %177, i32 0, i32 0
  store i32 %176, i32* %178, align 8
  %179 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_print_node_info(%struct.tnode* %179)
  %180 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.17, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_slide_1d_var(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %8 = load %struct.tnode*, %struct.tnode** %6, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 2
  %10 = load %struct.tpool*, %struct.tpool** %9, align 8
  %11 = getelementptr inbounds %struct.tpool, %struct.tpool* %10, i32 0, i32 0
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %11, i64 0, i64 %15
  %17 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 0
  %18 = load i8, i8* %17, align 8
  %19 = zext i8 %18 to i32
  %20 = icmp ne i32 %19, 1
  br i1 %20, label %21, label %35

21:                                               ; preds = %3
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 2
  %24 = load %struct.tpool*, %struct.tpool** %23, align 8
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 0
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 0
  %28 = load i32, i32* %27, align 8
  %29 = zext i32 %28 to i64
  %30 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %25, i64 0, i64 %29
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i8, i8* %31, align 8
  %33 = zext i8 %32 to i32
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.14, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_1d_var, i64 0, i64 0), i32 %33)
  br label %35

35:                                               ; preds = %21, %3
  %36 = load %struct.tnode*, %struct.tnode** %6, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 2
  %38 = load %struct.tpool*, %struct.tpool** %37, align 8
  %39 = getelementptr inbounds %struct.tpool, %struct.tpool* %38, i32 0, i32 0
  %40 = load %struct.tnode*, %struct.tnode** %6, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 0
  %42 = load i32, i32* %41, align 8
  %43 = zext i32 %42 to i64
  %44 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %39, i64 0, i64 %43
  %45 = getelementptr inbounds %struct.tdata, %struct.tdata* %44, i32 0, i32 1
  %46 = bitcast %union.data_type* %45 to i32*
  %47 = load i32, i32* %46, align 8
  store i32 %47, i32* %7, align 4
  %48 = load i32, i32* %7, align 4
  %49 = icmp slt i32 %48, 0
  br i1 %49, label %50, label %58

50:                                               ; preds = %35
  %51 = load %struct.tnode*, %struct.tnode** %5, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 3
  %53 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %52, i32 0, i32 1
  %54 = getelementptr inbounds [2 x i32], [2 x i32]* %53, i64 0, i64 0
  %55 = load i32, i32* %54, align 4
  %56 = load i32, i32* %7, align 4
  %57 = sub i32 %55, %56
  br label %60

58:                                               ; preds = %35
  %59 = load i32, i32* %7, align 4
  br label %60

60:                                               ; preds = %58, %50
  %61 = phi i32 [ %57, %50 ], [ %59, %58 ]
  store i32 %61, i32* %7, align 4
  %62 = load i32, i32* %7, align 4
  %63 = load %struct.tnode*, %struct.tnode** %4, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 3
  %65 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %64, i32 0, i32 1
  %66 = getelementptr inbounds [2 x i32], [2 x i32]* %65, i64 0, i64 0
  %67 = load i32, i32* %66, align 4
  %68 = icmp uge i32 %62, %67
  br i1 %68, label %69, label %77

69:                                               ; preds = %60
  %70 = load i32, i32* %7, align 4
  %71 = load %struct.tnode*, %struct.tnode** %4, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 3
  %73 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %72, i32 0, i32 1
  %74 = getelementptr inbounds [2 x i32], [2 x i32]* %73, i64 0, i64 0
  %75 = load i32, i32* %74, align 4
  %76 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.16, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_1d_var, i64 0, i64 0), i32 %70, i32 %75)
  br label %77

77:                                               ; preds = %69, %60
  %78 = load %struct.tnode*, %struct.tnode** %4, align 8
  %79 = getelementptr inbounds %struct.tnode, %struct.tnode* %78, i32 0, i32 2
  %80 = load %struct.tpool*, %struct.tpool** %79, align 8
  %81 = load %struct.tnode*, %struct.tnode** %5, align 8
  %82 = getelementptr inbounds %struct.tnode, %struct.tnode* %81, i32 0, i32 2
  store %struct.tpool* %80, %struct.tpool** %82, align 8
  %83 = load %struct.tnode*, %struct.tnode** %5, align 8
  %84 = getelementptr inbounds %struct.tnode, %struct.tnode* %83, i32 0, i32 3
  %85 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %84, i32 0, i32 0
  store i32 0, i32* %85, align 8
  %86 = load %struct.tnode*, %struct.tnode** %5, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 1
  store i32 1, i32* %87, align 4
  %88 = load %struct.tnode*, %struct.tnode** %4, align 8
  %89 = getelementptr inbounds %struct.tnode, %struct.tnode* %88, i32 0, i32 0
  %90 = load i32, i32* %89, align 8
  %91 = load %struct.tnode*, %struct.tnode** %4, align 8
  %92 = getelementptr inbounds %struct.tnode, %struct.tnode* %91, i32 0, i32 3
  %93 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %92, i32 0, i32 1
  %94 = getelementptr inbounds [2 x i32], [2 x i32]* %93, i64 0, i64 0
  %95 = load i32, i32* %94, align 4
  %96 = load i32, i32* %7, align 4
  %97 = mul i32 %95, %96
  %98 = add i32 %90, %97
  %99 = load %struct.tnode*, %struct.tnode** %5, align 8
  %100 = getelementptr inbounds %struct.tnode, %struct.tnode* %99, i32 0, i32 0
  store i32 %98, i32* %100, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_slide(%struct.tnode*, %struct.tnode*, i32*, i32) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32* %2, i32** %7, align 8
  store i32 %3, i32* %8, align 4
  %10 = load i32, i32* %8, align 4
  %11 = load %struct.tnode*, %struct.tnode** %6, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 3
  %13 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %10, %14
  br i1 %15, label %16, label %23

16:                                               ; preds = %4
  %17 = load i32, i32* %8, align 4
  %18 = load %struct.tnode*, %struct.tnode** %6, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 3
  %20 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([76 x i8], [76 x i8]* @.str.18, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i64 0, i64 0), i32 %17, i32 %21)
  br label %23

23:                                               ; preds = %16, %4
  store i32 0, i32* %9, align 4
  br label %24

24:                                               ; preds = %58, %23
  %25 = load i32, i32* %9, align 4
  %26 = load i32, i32* %8, align 4
  %27 = icmp slt i32 %25, %26
  br i1 %27, label %28, label %61

28:                                               ; preds = %24
  %29 = load i32*, i32** %7, align 8
  %30 = load i32, i32* %9, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds i32, i32* %29, i64 %31
  %33 = load i32, i32* %32, align 4
  %34 = load %struct.tnode*, %struct.tnode** %6, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 3
  %36 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %35, i32 0, i32 1
  %37 = load i32, i32* %9, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [2 x i32], [2 x i32]* %36, i64 0, i64 %38
  %40 = load i32, i32* %39, align 4
  %41 = icmp uge i32 %33, %40
  br i1 %41, label %42, label %57

42:                                               ; preds = %28
  %43 = load i32*, i32** %7, align 8
  %44 = load i32, i32* %9, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds i32, i32* %43, i64 %45
  %47 = load i32, i32* %46, align 4
  %48 = load %struct.tnode*, %struct.tnode** %6, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 3
  %50 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %49, i32 0, i32 1
  %51 = load i32, i32* %9, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [2 x i32], [2 x i32]* %50, i64 0, i64 %52
  %54 = load i32, i32* %53, align 4
  %55 = load i32, i32* %9, align 4
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.19, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i64 0, i64 0), i32 %47, i32 %54, i32 %55)
  br label %57

57:                                               ; preds = %42, %28
  br label %58

58:                                               ; preds = %57
  %59 = load i32, i32* %9, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, i32* %9, align 4
  br label %24

61:                                               ; preds = %24
  %62 = load %struct.tnode*, %struct.tnode** %5, align 8
  %63 = getelementptr inbounds %struct.tnode, %struct.tnode* %62, i32 0, i32 2
  %64 = load %struct.tpool*, %struct.tpool** %63, align 8
  %65 = load %struct.tnode*, %struct.tnode** %6, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 2
  store %struct.tpool* %64, %struct.tpool** %66, align 8
  %67 = load %struct.tnode*, %struct.tnode** %6, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 3
  %69 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %68, i32 0, i32 0
  store i32 0, i32* %69, align 8
  %70 = load %struct.tnode*, %struct.tnode** %6, align 8
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %70, i32 0, i32 1
  store i32 1, i32* %71, align 4
  %72 = load i32, i32* %8, align 4
  %73 = icmp eq i32 %72, 1
  br i1 %73, label %74, label %84

74:                                               ; preds = %61
  %75 = load %struct.tnode*, %struct.tnode** %5, align 8
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %75, i32 0, i32 0
  %77 = load i32, i32* %76, align 8
  %78 = load i32*, i32** %7, align 8
  %79 = getelementptr inbounds i32, i32* %78, i64 0
  %80 = load i32, i32* %79, align 4
  %81 = add i32 %77, %80
  %82 = load %struct.tnode*, %struct.tnode** %6, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 0
  store i32 %81, i32* %83, align 8
  br label %111

84:                                               ; preds = %61
  %85 = load i32, i32* %8, align 4
  %86 = icmp eq i32 %85, 2
  br i1 %86, label %87, label %107

87:                                               ; preds = %84
  %88 = load %struct.tnode*, %struct.tnode** %5, align 8
  %89 = getelementptr inbounds %struct.tnode, %struct.tnode* %88, i32 0, i32 0
  %90 = load i32, i32* %89, align 8
  %91 = load %struct.tnode*, %struct.tnode** %6, align 8
  %92 = getelementptr inbounds %struct.tnode, %struct.tnode* %91, i32 0, i32 3
  %93 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %92, i32 0, i32 1
  %94 = getelementptr inbounds [2 x i32], [2 x i32]* %93, i64 0, i64 1
  %95 = load i32, i32* %94, align 4
  %96 = load i32*, i32** %7, align 8
  %97 = getelementptr inbounds i32, i32* %96, i64 0
  %98 = load i32, i32* %97, align 4
  %99 = mul i32 %95, %98
  %100 = add i32 %90, %99
  %101 = load i32*, i32** %7, align 8
  %102 = getelementptr inbounds i32, i32* %101, i64 1
  %103 = load i32, i32* %102, align 4
  %104 = add i32 %100, %103
  %105 = load %struct.tnode*, %struct.tnode** %6, align 8
  %106 = getelementptr inbounds %struct.tnode, %struct.tnode* %105, i32 0, i32 0
  store i32 %104, i32* %106, align 8
  br label %110

107:                                              ; preds = %84
  %108 = load i32, i32* %8, align 4
  %109 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i64 0, i64 0), i32 %108)
  br label %110

110:                                              ; preds = %107, %87
  br label %111

111:                                              ; preds = %110, %74
  %112 = load %struct.tnode*, %struct.tnode** %6, align 8
  %113 = getelementptr inbounds %struct.tnode, %struct.tnode* %112, i32 0, i32 0
  %114 = load i32, i32* %113, align 8
  %115 = load %struct.tnode*, %struct.tnode** %5, align 8
  %116 = getelementptr inbounds %struct.tnode, %struct.tnode* %115, i32 0, i32 1
  %117 = load i32, i32* %116, align 4
  %118 = icmp uge i32 %114, %117
  br i1 %118, label %119, label %127

119:                                              ; preds = %111
  %120 = load %struct.tnode*, %struct.tnode** %6, align 8
  %121 = getelementptr inbounds %struct.tnode, %struct.tnode* %120, i32 0, i32 0
  %122 = load i32, i32* %121, align 8
  %123 = load %struct.tnode*, %struct.tnode** %5, align 8
  %124 = getelementptr inbounds %struct.tnode, %struct.tnode* %123, i32 0, i32 1
  %125 = load i32, i32* %124, align 4
  %126 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.21, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i64 0, i64 0), i32 %122, i32 %125)
  br label %127

127:                                              ; preds = %119, %111
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list(%struct.tpool*, %struct.tnode*, %struct.tnode*, i32) #0 {
  %5 = alloca %struct.tpool*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store i32 %3, i32* %8, align 4
  %10 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %14

12:                                               ; preds = %4
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_list, i64 0, i64 0))
  br label %14

14:                                               ; preds = %12, %4
  %15 = load %struct.tpool*, %struct.tpool** %5, align 8
  %16 = load %struct.tnode*, %struct.tnode** %6, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 2
  store %struct.tpool* %15, %struct.tpool** %17, align 8
  %18 = load %struct.tnode*, %struct.tnode** %6, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 3
  %20 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %19, i32 0, i32 0
  store i32 1, i32* %20, align 8
  %21 = load %struct.tnode*, %struct.tnode** %7, align 8
  %22 = load i32, i32* %8, align 4
  %23 = call i32 @is_list_consecutive_in_memory(%struct.tnode* %21, i32 %22)
  %24 = icmp eq i32 %23, 1
  br i1 %24, label %25, label %35

25:                                               ; preds = %14
  %26 = load %struct.tnode*, %struct.tnode** %7, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i64 0
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 0
  %29 = load i32, i32* %28, align 8
  %30 = load %struct.tnode*, %struct.tnode** %6, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 0
  store i32 %29, i32* %31, align 8
  %32 = load i32, i32* %8, align 4
  %33 = load %struct.tnode*, %struct.tnode** %6, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 1
  store i32 %32, i32* %34, align 4
  br label %87

35:                                               ; preds = %14
  %36 = load %struct.tpool*, %struct.tpool** %5, align 8
  %37 = getelementptr inbounds %struct.tpool, %struct.tpool* %36, i32 0, i32 1
  %38 = load i32, i32* %37, align 8
  %39 = load %struct.tnode*, %struct.tnode** %6, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 0
  store i32 %38, i32* %40, align 8
  %41 = load i32, i32* %8, align 4
  %42 = load %struct.tnode*, %struct.tnode** %6, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 1
  store i32 %41, i32* %43, align 4
  %44 = load %struct.tpool*, %struct.tpool** %5, align 8
  %45 = getelementptr inbounds %struct.tpool, %struct.tpool* %44, i32 0, i32 1
  %46 = load i32, i32* %45, align 8
  %47 = load i32, i32* %8, align 4
  %48 = add i32 %46, %47
  %49 = urem i32 %48, 1024
  %50 = load %struct.tpool*, %struct.tpool** %5, align 8
  %51 = getelementptr inbounds %struct.tpool, %struct.tpool* %50, i32 0, i32 1
  store i32 %49, i32* %51, align 8
  store i32 0, i32* %9, align 4
  br label %52

52:                                               ; preds = %83, %35
  %53 = load i32, i32* %9, align 4
  %54 = load i32, i32* %8, align 4
  %55 = icmp slt i32 %53, %54
  br i1 %55, label %56, label %86

56:                                               ; preds = %52
  %57 = load %struct.tpool*, %struct.tpool** %5, align 8
  %58 = getelementptr inbounds %struct.tpool, %struct.tpool* %57, i32 0, i32 0
  %59 = load %struct.tnode*, %struct.tnode** %6, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 0
  %61 = load i32, i32* %60, align 8
  %62 = load i32, i32* %9, align 4
  %63 = add i32 %61, %62
  %64 = zext i32 %63 to i64
  %65 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %58, i64 0, i64 %64
  %66 = load %struct.tnode*, %struct.tnode** %7, align 8
  %67 = load i32, i32* %9, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i64 %68
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 2
  %71 = load %struct.tpool*, %struct.tpool** %70, align 8
  %72 = getelementptr inbounds %struct.tpool, %struct.tpool* %71, i32 0, i32 0
  %73 = load %struct.tnode*, %struct.tnode** %7, align 8
  %74 = load i32, i32* %9, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i64 %75
  %77 = getelementptr inbounds %struct.tnode, %struct.tnode* %76, i32 0, i32 0
  %78 = load i32, i32* %77, align 8
  %79 = zext i32 %78 to i64
  %80 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %72, i64 0, i64 %79
  %81 = bitcast %struct.tdata* %65 to i8*
  %82 = bitcast %struct.tdata* %80 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %81, i8* align 8 %82, i64 16, i1 false)
  br label %83

83:                                               ; preds = %56
  %84 = load i32, i32* %9, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, i32* %9, align 4
  br label %52

86:                                               ; preds = %52
  br label %87

87:                                               ; preds = %86, %25
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_2d_matrix(%struct.tpool*, %struct.tnode*, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tpool*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %6, align 8
  store %struct.tnode* %1, %struct.tnode** %7, align 8
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %11 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %5
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_2d_matrix, i64 0, i64 0))
  br label %15

15:                                               ; preds = %13, %5
  %16 = load %struct.tpool*, %struct.tpool** %6, align 8
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = load %struct.tnode*, %struct.tnode** %8, align 8
  %19 = load i32, i32* %9, align 4
  %20 = load i32, i32* %10, align 4
  %21 = mul nsw i32 %19, %20
  call void @funk_create_list(%struct.tpool* %16, %struct.tnode* %17, %struct.tnode* %18, i32 %21)
  %22 = load %struct.tnode*, %struct.tnode** %7, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 3
  %24 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %23, i32 0, i32 0
  store i32 2, i32* %24, align 8
  %25 = load i32, i32* %9, align 4
  %26 = load %struct.tnode*, %struct.tnode** %7, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 3
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 1
  %29 = getelementptr inbounds [2 x i32], [2 x i32]* %28, i64 0, i64 0
  store i32 %25, i32* %29, align 4
  %30 = load i32, i32* %10, align 4
  %31 = load %struct.tnode*, %struct.tnode** %7, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 3
  %33 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %32, i32 0, i32 1
  %34 = getelementptr inbounds [2 x i32], [2 x i32]* %33, i64 0, i64 1
  store i32 %30, i32* %34, align 4
  %35 = load %struct.tnode*, %struct.tnode** %7, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 0
  %37 = load i32, i32* %36, align 8
  %38 = load %struct.tnode*, %struct.tnode** %7, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = load %struct.tpool*, %struct.tpool** %6, align 8
  %42 = getelementptr inbounds %struct.tpool, %struct.tpool* %41, i32 0, i32 1
  %43 = load i32, i32* %42, align 8
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.22, i64 0, i64 0), i32 %37, i32 %40, i32 %43)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_scalar(%struct.tpool*, %struct.tnode*, i8*, i32) #0 {
  %5 = alloca %struct.tpool*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load %struct.tpool*, %struct.tpool** %5, align 8
  %10 = getelementptr inbounds %struct.tpool, %struct.tpool* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 8
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 0
  store i32 %11, i32* %13, align 8
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  store i32 1, i32* %15, align 4
  %16 = load %struct.tpool*, %struct.tpool** %5, align 8
  %17 = load %struct.tnode*, %struct.tnode** %6, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 2
  store %struct.tpool* %16, %struct.tpool** %18, align 8
  %19 = load %struct.tnode*, %struct.tnode** %6, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 3
  %21 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %20, i32 0, i32 0
  store i32 1, i32* %21, align 8
  %22 = load %struct.tpool*, %struct.tpool** %5, align 8
  %23 = getelementptr inbounds %struct.tpool, %struct.tpool* %22, i32 0, i32 1
  %24 = load i32, i32* %23, align 8
  %25 = add i32 %24, 1
  %26 = urem i32 %25, 1024
  %27 = load %struct.tpool*, %struct.tpool** %5, align 8
  %28 = getelementptr inbounds %struct.tpool, %struct.tpool* %27, i32 0, i32 1
  store i32 %26, i32* %28, align 8
  %29 = load i32, i32* %8, align 4
  %30 = trunc i32 %29 to i8
  %31 = load %struct.tpool*, %struct.tpool** %5, align 8
  %32 = getelementptr inbounds %struct.tpool, %struct.tpool* %31, i32 0, i32 0
  %33 = load %struct.tnode*, %struct.tnode** %6, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 0
  %35 = load i32, i32* %34, align 8
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %32, i64 0, i64 %36
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 0
  store i8 %30, i8* %38, align 8
  %39 = load i32, i32* %8, align 4
  switch i32 %39, label %66 [
    i32 1, label %40
    i32 2, label %53
  ]

40:                                               ; preds = %4
  %41 = load i8*, i8** %7, align 8
  %42 = bitcast i8* %41 to i32*
  %43 = load i32, i32* %42, align 4
  %44 = load %struct.tpool*, %struct.tpool** %5, align 8
  %45 = getelementptr inbounds %struct.tpool, %struct.tpool* %44, i32 0, i32 0
  %46 = load %struct.tnode*, %struct.tnode** %6, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 0
  %48 = load i32, i32* %47, align 8
  %49 = zext i32 %48 to i64
  %50 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %45, i64 0, i64 %49
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 1
  %52 = bitcast %union.data_type* %51 to i32*
  store i32 %43, i32* %52, align 8
  br label %66

53:                                               ; preds = %4
  %54 = load i8*, i8** %7, align 8
  %55 = bitcast i8* %54 to double*
  %56 = load double, double* %55, align 8
  %57 = load %struct.tpool*, %struct.tpool** %5, align 8
  %58 = getelementptr inbounds %struct.tpool, %struct.tpool* %57, i32 0, i32 0
  %59 = load %struct.tnode*, %struct.tnode** %6, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 0
  %61 = load i32, i32* %60, align 8
  %62 = zext i32 %61 to i64
  %63 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %58, i64 0, i64 %62
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 1
  %65 = bitcast %union.data_type* %64 to double*
  store double %56, double* %65, align 8
  br label %66

66:                                               ; preds = %4, %53, %40
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_int_scalar(%struct.tpool*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tpool*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %19

9:                                                ; preds = %3
  %10 = load %struct.tpool*, %struct.tpool** %4, align 8
  %11 = icmp eq %struct.tpool* %10, @funk_global_memory_pool
  %12 = zext i1 %11 to i64
  %13 = select i1 %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %14 = load %struct.tpool*, %struct.tpool** %4, align 8
  %15 = getelementptr inbounds %struct.tpool, %struct.tpool* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 8
  %17 = load i32, i32* %6, align 4
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_int_scalar, i64 0, i64 0), i8* %13, i32 %16, i32 %17)
  br label %19

19:                                               ; preds = %9, %3
  %20 = load %struct.tpool*, %struct.tpool** %4, align 8
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = bitcast i32* %6 to i8*
  call void @funk_create_scalar(%struct.tpool* %20, %struct.tnode* %21, i8* %22, i32 1)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_float_scalar(%struct.tpool*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tpool*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  store %struct.tpool* %0, %struct.tpool** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %7 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %19

9:                                                ; preds = %3
  %10 = load %struct.tpool*, %struct.tpool** %4, align 8
  %11 = icmp eq %struct.tpool* %10, @funk_global_memory_pool
  %12 = zext i1 %11 to i64
  %13 = select i1 %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %14 = load %struct.tpool*, %struct.tpool** %4, align 8
  %15 = getelementptr inbounds %struct.tpool, %struct.tpool* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 8
  %17 = load double, double* %6, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.24, i64 0, i64 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_float_scalar, i64 0, i64 0), i8* %13, i32 %16, double %17)
  br label %19

19:                                               ; preds = %9, %3
  %20 = load %struct.tpool*, %struct.tpool** %4, align 8
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = bitcast double* %6 to i8*
  call void @funk_create_scalar(%struct.tpool* %20, %struct.tnode* %21, i8* %22, i32 2)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_int_literal(%struct.tpool*, %struct.tnode*, i32*, i32) #0 {
  %5 = alloca %struct.tpool*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32* %2, i32** %7, align 8
  store i32 %3, i32* %8, align 4
  %10 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %14

12:                                               ; preds = %4
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_create_list_int_literal, i64 0, i64 0))
  br label %14

14:                                               ; preds = %12, %4
  %15 = load %struct.tpool*, %struct.tpool** %5, align 8
  %16 = getelementptr inbounds %struct.tpool, %struct.tpool* %15, i32 0, i32 1
  %17 = load i32, i32* %16, align 8
  %18 = load %struct.tnode*, %struct.tnode** %6, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 0
  store i32 %17, i32* %19, align 8
  %20 = load i32, i32* %8, align 4
  %21 = load %struct.tnode*, %struct.tnode** %6, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  store i32 %20, i32* %22, align 4
  %23 = load %struct.tpool*, %struct.tpool** %5, align 8
  %24 = load %struct.tnode*, %struct.tnode** %6, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 2
  store %struct.tpool* %23, %struct.tpool** %25, align 8
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 3
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 0
  store i32 1, i32* %28, align 8
  %29 = load %struct.tpool*, %struct.tpool** %5, align 8
  %30 = getelementptr inbounds %struct.tpool, %struct.tpool* %29, i32 0, i32 1
  %31 = load i32, i32* %30, align 8
  %32 = load i32, i32* %8, align 4
  %33 = add i32 %31, %32
  %34 = urem i32 %33, 1024
  %35 = load %struct.tpool*, %struct.tpool** %5, align 8
  %36 = getelementptr inbounds %struct.tpool, %struct.tpool* %35, i32 0, i32 1
  store i32 %34, i32* %36, align 8
  store i32 0, i32* %9, align 4
  br label %37

37:                                               ; preds = %68, %14
  %38 = load i32, i32* %9, align 4
  %39 = load i32, i32* %8, align 4
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %41, label %71

41:                                               ; preds = %37
  %42 = load %struct.tpool*, %struct.tpool** %5, align 8
  %43 = getelementptr inbounds %struct.tpool, %struct.tpool* %42, i32 0, i32 0
  %44 = load %struct.tnode*, %struct.tnode** %6, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 0
  %46 = load i32, i32* %45, align 8
  %47 = load i32, i32* %9, align 4
  %48 = add i32 %46, %47
  %49 = zext i32 %48 to i64
  %50 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %43, i64 0, i64 %49
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 0
  store i8 1, i8* %51, align 8
  %52 = load i32*, i32** %7, align 8
  %53 = load i32, i32* %9, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds i32, i32* %52, i64 %54
  %56 = load i32, i32* %55, align 4
  %57 = load %struct.tpool*, %struct.tpool** %5, align 8
  %58 = getelementptr inbounds %struct.tpool, %struct.tpool* %57, i32 0, i32 0
  %59 = load %struct.tnode*, %struct.tnode** %6, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 0
  %61 = load i32, i32* %60, align 8
  %62 = load i32, i32* %9, align 4
  %63 = add i32 %61, %62
  %64 = zext i32 %63 to i64
  %65 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %58, i64 0, i64 %64
  %66 = getelementptr inbounds %struct.tdata, %struct.tdata* %65, i32 0, i32 1
  %67 = bitcast %union.data_type* %66 to i32*
  store i32 %56, i32* %67, align 8
  br label %68

68:                                               ; preds = %41
  %69 = load i32, i32* %9, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, i32* %9, align 4
  br label %37

71:                                               ; preds = %37
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_2d_matrix_int_literal(%struct.tpool*, %struct.tnode*, i32*, i32, i32) #0 {
  %6 = alloca %struct.tpool*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %6, align 8
  store %struct.tnode* %1, %struct.tnode** %7, align 8
  store i32* %2, i32** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %11 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %5
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_2d_matrix_int_literal, i64 0, i64 0))
  br label %15

15:                                               ; preds = %13, %5
  %16 = load %struct.tpool*, %struct.tpool** %6, align 8
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = load i32*, i32** %8, align 8
  %19 = load i32, i32* %9, align 4
  %20 = load i32, i32* %10, align 4
  %21 = mul nsw i32 %19, %20
  call void @funk_create_list_int_literal(%struct.tpool* %16, %struct.tnode* %17, i32* %18, i32 %21)
  %22 = load %struct.tnode*, %struct.tnode** %7, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 3
  %24 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %23, i32 0, i32 0
  store i32 2, i32* %24, align 8
  %25 = load i32, i32* %9, align 4
  %26 = load %struct.tnode*, %struct.tnode** %7, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 3
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 1
  %29 = getelementptr inbounds [2 x i32], [2 x i32]* %28, i64 0, i64 0
  store i32 %25, i32* %29, align 4
  %30 = load i32, i32* %10, align 4
  %31 = load %struct.tnode*, %struct.tnode** %7, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 3
  %33 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %32, i32 0, i32 1
  %34 = getelementptr inbounds [2 x i32], [2 x i32]* %33, i64 0, i64 1
  store i32 %30, i32* %34, align 4
  %35 = load %struct.tnode*, %struct.tnode** %7, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 0
  %37 = load i32, i32* %36, align 8
  %38 = load %struct.tnode*, %struct.tnode** %7, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = load %struct.tpool*, %struct.tpool** %6, align 8
  %42 = getelementptr inbounds %struct.tpool, %struct.tpool* %41, i32 0, i32 1
  %43 = load i32, i32* %42, align 8
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.22, i64 0, i64 0), i32 %37, i32 %40, i32 %43)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_copy_element_from_pool(%struct.tpool*, %struct.tnode*, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tpool*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %6, align 8
  store %struct.tnode* %1, %struct.tnode** %7, align 8
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %16

14:                                               ; preds = %5
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_copy_element_from_pool, i64 0, i64 0))
  br label %16

16:                                               ; preds = %14, %5
  %17 = load %struct.tnode*, %struct.tnode** %8, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 3
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 1
  %20 = getelementptr inbounds [2 x i32], [2 x i32]* %19, i64 0, i64 0
  %21 = load i32, i32* %20, align 4
  %22 = load i32, i32* %9, align 4
  %23 = mul i32 %21, %22
  %24 = load i32, i32* %10, align 4
  %25 = add i32 %23, %24
  store i32 %25, i32* %11, align 4
  %26 = load i32, i32* %11, align 4
  %27 = load %struct.tnode*, %struct.tnode** %8, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  %30 = icmp uge i32 %26, %29
  br i1 %30, label %31, label %35

31:                                               ; preds = %16
  %32 = load i32, i32* %9, align 4
  %33 = load i32, i32* %10, align 4
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.25, i64 0, i64 0), i32 %32, i32 %33)
  br label %45

35:                                               ; preds = %16
  %36 = load %struct.tnode*, %struct.tnode** %8, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 0
  %38 = load i32, i32* %37, align 8
  %39 = load i32, i32* %11, align 4
  %40 = add i32 %38, %39
  %41 = load %struct.tnode*, %struct.tnode** %7, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 0
  store i32 %40, i32* %42, align 8
  %43 = load %struct.tnode*, %struct.tnode** %7, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 1
  store i32 1, i32* %44, align 4
  br label %45

45:                                               ; preds = %35, %31
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_scalar_element(i8, i64) #0 {
  %3 = alloca %struct.tdata, align 8
  %4 = bitcast %struct.tdata* %3 to { i8, i64 }*
  %5 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %4, i32 0, i32 0
  store i8 %0, i8* %5, align 8
  %6 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %4, i32 0, i32 1
  store i64 %1, i64* %6, align 8
  %7 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 0
  %8 = load i8, i8* %7, align 8
  %9 = zext i8 %8 to i32
  switch i32 %9, label %22 [
    i32 1, label %10
    i32 2, label %15
    i32 4, label %20
  ]

10:                                               ; preds = %2
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %12 = bitcast %union.data_type* %11 to i32*
  %13 = load i32, i32* %12, align 8
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.26, i64 0, i64 0), i32 %13)
  br label %24

15:                                               ; preds = %2
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.27, i64 0, i64 0), double %18)
  br label %24

20:                                               ; preds = %2
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.28, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.29, i64 0, i64 0))
  br label %24

22:                                               ; preds = %2
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.28, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i64 0, i64 0))
  br label %24

24:                                               ; preds = %22, %20, %15, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_node_type(%struct.tnode*, i32, i8*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i8* %2, i8** %6, align 8
  %7 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %22

9:                                                ; preds = %3
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 2
  %12 = load %struct.tpool*, %struct.tpool** %11, align 8
  %13 = icmp eq %struct.tpool* %12, @funk_global_memory_pool
  %14 = zext i1 %13 to i64
  %15 = select i1 %13, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = load i32, i32* %5, align 4
  %20 = add i32 %18, %19
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.31, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i8* %15, i32 %20)
  br label %22

22:                                               ; preds = %9, %3
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = icmp ugt i32 %25, 0
  br i1 %26, label %27, label %39

27:                                               ; preds = %22
  %28 = load i32, i32* %5, align 4
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = icmp uge i32 %28, %31
  br i1 %32, label %33, label %39

33:                                               ; preds = %27
  %34 = load i32, i32* %5, align 4
  %35 = load %struct.tnode*, %struct.tnode** %4, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 1
  %37 = load i32, i32* %36, align 4
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.32, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 %34, i32 %37)
  br label %39

39:                                               ; preds = %33, %27, %22
  %40 = load %struct.tnode*, %struct.tnode** %4, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 2
  %42 = load %struct.tpool*, %struct.tpool** %41, align 8
  %43 = getelementptr inbounds %struct.tpool, %struct.tpool* %42, i32 0, i32 0
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 0
  %46 = load i32, i32* %45, align 8
  %47 = load i32, i32* %5, align 4
  %48 = add i32 %46, %47
  %49 = zext i32 %48 to i64
  %50 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %43, i64 0, i64 %49
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 0
  %52 = load i8, i8* %51, align 8
  %53 = load i8*, i8** %6, align 8
  store i8 %52, i8* %53, align 1
  %54 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %60

56:                                               ; preds = %39
  %57 = load i8*, i8** %6, align 8
  %58 = load i8, i8* %57, align 1
  call void @funk_print_type(i8 zeroext %58)
  %59 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.33, i64 0, i64 0))
  br label %60

60:                                               ; preds = %56, %39
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_type(%struct.tnode*, i32, i8 zeroext) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i8 %2, i8* %6, align 1
  %7 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %11

9:                                                ; preds = %3
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0))
  br label %11

11:                                               ; preds = %9, %3
  %12 = load i32, i32* %5, align 4
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 4
  %16 = icmp uge i32 %12, %15
  br i1 %16, label %17, label %23

17:                                               ; preds = %11
  %18 = load i32, i32* %5, align 4
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 4
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.32, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 %18, i32 %21)
  br label %23

23:                                               ; preds = %17, %11
  %24 = load i8, i8* %6, align 1
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 2
  %27 = load %struct.tpool*, %struct.tpool** %26, align 8
  %28 = getelementptr inbounds %struct.tpool, %struct.tpool* %27, i32 0, i32 0
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 8
  %32 = load i32, i32* %5, align 4
  %33 = add i32 %31, %32
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %28, i64 0, i64 %34
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %35, i32 0, i32 0
  store i8 %24, i8* %36, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_node_value_int(%struct.tnode*, i32, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %11

9:                                                ; preds = %3
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0))
  br label %11

11:                                               ; preds = %9, %3
  %12 = load i32, i32* %5, align 4
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 4
  %16 = icmp uge i32 %12, %15
  br i1 %16, label %17, label %23

17:                                               ; preds = %11
  %18 = load i32, i32* %5, align 4
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 4
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.32, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 %18, i32 %21)
  br label %23

23:                                               ; preds = %17, %11
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 2
  %26 = load %struct.tpool*, %struct.tpool** %25, align 8
  %27 = getelementptr inbounds %struct.tpool, %struct.tpool* %26, i32 0, i32 0
  %28 = load %struct.tnode*, %struct.tnode** %4, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 0
  %30 = load i32, i32* %29, align 8
  %31 = load i32, i32* %5, align 4
  %32 = add i32 %30, %31
  %33 = zext i32 %32 to i64
  %34 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %27, i64 0, i64 %33
  %35 = getelementptr inbounds %struct.tdata, %struct.tdata* %34, i32 0, i32 0
  store i8 1, i8* %35, align 8
  %36 = load i32, i32* %6, align 4
  %37 = load %struct.tnode*, %struct.tnode** %4, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 2
  %39 = load %struct.tpool*, %struct.tpool** %38, align 8
  %40 = getelementptr inbounds %struct.tpool, %struct.tpool* %39, i32 0, i32 0
  %41 = load %struct.tnode*, %struct.tnode** %4, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 0
  %43 = load i32, i32* %42, align 8
  %44 = load i32, i32* %5, align 4
  %45 = add i32 %43, %44
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %40, i64 0, i64 %46
  %48 = getelementptr inbounds %struct.tdata, %struct.tdata* %47, i32 0, i32 1
  %49 = bitcast %union.data_type* %48 to i32*
  store i32 %36, i32* %49, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @foo() #0 {
  %1 = alloca %struct.tnode, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_pool(%struct.tpool*) #0 {
  %2 = alloca %struct.tpool*, align 8
  %3 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %2, align 8
  store i32 0, i32* %3, align 4
  br label %4

4:                                                ; preds = %28, %1
  %5 = load i32, i32* %3, align 4
  %6 = icmp slt i32 %5, 64
  br i1 %6, label %7, label %31

7:                                                ; preds = %4
  %8 = load %struct.tpool*, %struct.tpool** %2, align 8
  %9 = getelementptr inbounds %struct.tpool, %struct.tpool* %8, i32 0, i32 0
  %10 = load i32, i32* %3, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %9, i64 0, i64 %11
  %13 = bitcast %struct.tdata* %12 to { i8, i64 }*
  %14 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %13, i32 0, i32 0
  %15 = load i8, i8* %14, align 8
  %16 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %13, i32 0, i32 1
  %17 = load i64, i64* %16, align 8
  call void @funk_print_scalar_element(i8 %15, i64 %17)
  %18 = load i32, i32* %3, align 4
  %19 = icmp sgt i32 %18, 0
  br i1 %19, label %20, label %27

20:                                               ; preds = %7
  %21 = load i32, i32* %3, align 4
  %22 = add nsw i32 %21, 1
  %23 = srem i32 %22, 7
  %24 = icmp eq i32 %23, 0
  br i1 %24, label %25, label %27

25:                                               ; preds = %20
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.34, i64 0, i64 0))
  br label %27

27:                                               ; preds = %25, %20, %7
  br label %28

28:                                               ; preds = %27
  %29 = load i32, i32* %3, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, i32* %3, align 4
  br label %4

31:                                               ; preds = %4
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.34, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_next_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %6 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %22

8:                                                ; preds = %2
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 2
  %11 = load %struct.tpool*, %struct.tpool** %10, align 8
  %12 = icmp eq %struct.tpool* %11, @funk_global_memory_pool
  %13 = zext i1 %12 to i64
  %14 = select i1 %12, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %15 = load %struct.tnode*, %struct.tnode** %4, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = load %struct.tnode*, %struct.tnode** %4, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 1
  %20 = load i32, i32* %19, align 4
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.35, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_next_node, i64 0, i64 0), i8* %14, i32 %17, i32 %20)
  br label %22

22:                                               ; preds = %8, %2
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 2
  %25 = load %struct.tpool*, %struct.tpool** %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %3, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 2
  store %struct.tpool* %25, %struct.tpool** %27, align 8
  %28 = load %struct.tnode*, %struct.tnode** %4, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 3
  %30 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 8
  %32 = load %struct.tnode*, %struct.tnode** %3, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 3
  %34 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %33, i32 0, i32 0
  store i32 %31, i32* %34, align 8
  store i32 0, i32* %5, align 4
  br label %35

35:                                               ; preds = %52, %22
  %36 = load i32, i32* %5, align 4
  %37 = icmp slt i32 %36, 2
  br i1 %37, label %38, label %55

38:                                               ; preds = %35
  %39 = load %struct.tnode*, %struct.tnode** %4, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 3
  %41 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %40, i32 0, i32 1
  %42 = load i32, i32* %5, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [2 x i32], [2 x i32]* %41, i64 0, i64 %43
  %45 = load i32, i32* %44, align 4
  %46 = load %struct.tnode*, %struct.tnode** %3, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 3
  %48 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %47, i32 0, i32 1
  %49 = load i32, i32* %5, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [2 x i32], [2 x i32]* %48, i64 0, i64 %50
  store i32 %45, i32* %51, align 4
  br label %52

52:                                               ; preds = %38
  %53 = load i32, i32* %5, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, i32* %5, align 4
  br label %35

55:                                               ; preds = %35
  %56 = load %struct.tnode*, %struct.tnode** %4, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = load i32, i32* %57, align 4
  %59 = icmp eq i32 %58, 0
  br i1 %59, label %60, label %89

60:                                               ; preds = %55
  %61 = load %struct.tnode*, %struct.tnode** %4, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 0
  %63 = load i32, i32* %62, align 8
  %64 = load %struct.tnode*, %struct.tnode** %3, align 8
  %65 = getelementptr inbounds %struct.tnode, %struct.tnode* %64, i32 0, i32 0
  store i32 %63, i32* %65, align 8
  %66 = load %struct.tnode*, %struct.tnode** %3, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 1
  store i32 1, i32* %67, align 4
  %68 = load %struct.tnode*, %struct.tnode** %3, align 8
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i32 0, i32 2
  %70 = load %struct.tpool*, %struct.tpool** %69, align 8
  %71 = getelementptr inbounds %struct.tpool, %struct.tpool* %70, i32 0, i32 0
  %72 = load %struct.tnode*, %struct.tnode** %3, align 8
  %73 = getelementptr inbounds %struct.tnode, %struct.tnode* %72, i32 0, i32 0
  %74 = load i32, i32* %73, align 8
  %75 = zext i32 %74 to i64
  %76 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %71, i64 0, i64 %75
  %77 = getelementptr inbounds %struct.tdata, %struct.tdata* %76, i32 0, i32 0
  store i8 4, i8* %77, align 8
  %78 = load %struct.tnode*, %struct.tnode** %3, align 8
  %79 = getelementptr inbounds %struct.tnode, %struct.tnode* %78, i32 0, i32 2
  %80 = load %struct.tpool*, %struct.tpool** %79, align 8
  %81 = getelementptr inbounds %struct.tpool, %struct.tpool* %80, i32 0, i32 0
  %82 = load %struct.tnode*, %struct.tnode** %3, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 0
  %84 = load i32, i32* %83, align 8
  %85 = zext i32 %84 to i64
  %86 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %81, i64 0, i64 %85
  %87 = getelementptr inbounds %struct.tdata, %struct.tdata* %86, i32 0, i32 1
  %88 = bitcast %union.data_type* %87 to i32*
  store i32 0, i32* %88, align 8
  br label %102

89:                                               ; preds = %55
  %90 = load %struct.tnode*, %struct.tnode** %4, align 8
  %91 = getelementptr inbounds %struct.tnode, %struct.tnode* %90, i32 0, i32 1
  %92 = load i32, i32* %91, align 4
  %93 = sub i32 %92, 1
  %94 = load %struct.tnode*, %struct.tnode** %3, align 8
  %95 = getelementptr inbounds %struct.tnode, %struct.tnode* %94, i32 0, i32 1
  store i32 %93, i32* %95, align 4
  %96 = load %struct.tnode*, %struct.tnode** %4, align 8
  %97 = getelementptr inbounds %struct.tnode, %struct.tnode* %96, i32 0, i32 0
  %98 = load i32, i32* %97, align 8
  %99 = add i32 %98, 1
  %100 = load %struct.tnode*, %struct.tnode** %3, align 8
  %101 = getelementptr inbounds %struct.tnode, %struct.tnode* %100, i32 0, i32 0
  store i32 %99, i32* %101, align 8
  br label %102

102:                                              ; preds = %89, %60
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_function_entry_hook() #0 {
  %1 = alloca [8 x i8], align 1
  %2 = load i32, i32* @funk_debug_function_entry_hook.run_until_the_end, align 4
  %3 = icmp eq i32 %2, 1
  br i1 %3, label %4, label %5

4:                                                ; preds = %0
  br label %39

5:                                                ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.36, i64 0, i64 0))
  br label %7

7:                                                ; preds = %35, %5
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.37, i64 0, i64 0))
  %9 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i64 0, i64 0
  %10 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8
  %11 = call i8* @fgets(i8* %9, i32 8, %struct.__sFILE* %10)
  %12 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i64 0, i64 0
  %13 = call i32 @strncmp(i8* %12, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i64 5)
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %16, label %15

15:                                               ; preds = %7
  call void @funk_print_pool(%struct.tpool* @funk_global_memory_pool)
  br label %34

16:                                               ; preds = %7
  %17 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i64 0, i64 0
  %18 = call i32 @strncmp(i8* %17, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0), i64 5)
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %21, label %20

20:                                               ; preds = %16
  call void @funk_print_pool(%struct.tpool* @funk_functions_memory_pool)
  br label %33

21:                                               ; preds = %16
  %22 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i64 0, i64 0
  %23 = call i32 @strncmp(i8* %22, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.38, i64 0, i64 0), i64 6)
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %26, label %25

25:                                               ; preds = %21
  store i32 1, i32* @funk_debug_function_entry_hook.run_until_the_end, align 4
  br label %32

26:                                               ; preds = %21
  %27 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i64 0, i64 0
  %28 = call i32 @strncmp(i8* %27, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.39, i64 0, i64 0), i64 1)
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %31, label %30

30:                                               ; preds = %26
  call void @exit(i32 0) #4
  unreachable

31:                                               ; preds = %26
  br label %32

32:                                               ; preds = %31, %25
  br label %33

33:                                               ; preds = %32, %20
  br label %34

34:                                               ; preds = %33, %15
  br label %35

35:                                               ; preds = %34
  %36 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i64 0, i64 0
  %37 = call i32 @strncmp(i8* %36, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.40, i64 0, i64 0), i64 1)
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %7, label %39

39:                                               ; preds = %4, %35
  ret void
}

declare i8* @fgets(i8*, i32, %struct.__sFILE*) #1

declare i32 @strncmp(i8*, i8*, i64) #1

; Function Attrs: noreturn
declare void @exit(i32) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_memcp_arr(%struct.tnode*, %struct.tnode*, i32, i8 zeroext) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i8, align 1
  %9 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store i32 %2, i32* %7, align 4
  store i8 %3, i8* %8, align 1
  %10 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %14

12:                                               ; preds = %4
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__.funk_memcp_arr, i64 0, i64 0))
  br label %14

14:                                               ; preds = %12, %4
  store i32 0, i32* %9, align 4
  br label %15

15:                                               ; preds = %28, %14
  %16 = load i32, i32* %9, align 4
  %17 = load i32, i32* %7, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %31

19:                                               ; preds = %15
  %20 = load %struct.tnode*, %struct.tnode** %5, align 8
  %21 = load i32, i32* %9, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i64 %22
  %24 = load %struct.tnode*, %struct.tnode** %6, align 8
  %25 = load i32, i32* %9, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i64 %26
  call void @funk_copy_node(%struct.tnode* %23, %struct.tnode* %27)
  br label %28

28:                                               ; preds = %19
  %29 = load i32, i32* %9, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, i32* %9, align 4
  br label %15

31:                                               ; preds = %15
  %32 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %34, label %36

34:                                               ; preds = %31
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__.funk_memcp_arr, i64 0, i64 0))
  br label %36

36:                                               ; preds = %34, %31
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @debug_print_arith_operation(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %9, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 2
  %15 = load %struct.tpool*, %struct.tpool** %14, align 8
  %16 = icmp eq %struct.tpool* %15, @funk_global_memory_pool
  %17 = zext i1 %16 to i64
  %18 = select i1 %16, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %19 = load %struct.tnode*, %struct.tnode** %9, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = load i32, i32* %10, align 4
  %23 = add i32 %21, %22
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.41, i64 0, i64 0), i8* %18, i32 %23)
  %25 = load %struct.tnode*, %struct.tnode** %9, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 2
  %27 = load %struct.tpool*, %struct.tpool** %26, align 8
  %28 = getelementptr inbounds %struct.tpool, %struct.tpool* %27, i32 0, i32 0
  %29 = load %struct.tnode*, %struct.tnode** %9, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 8
  %32 = load i32, i32* %10, align 4
  %33 = add i32 %31, %32
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %28, i64 0, i64 %34
  %36 = bitcast %struct.tdata* %35 to { i8, i64 }*
  %37 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %36, i32 0, i32 0
  %38 = load i8, i8* %37, align 8
  %39 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %36, i32 0, i32 1
  %40 = load i64, i64* %39, align 8
  call void @funk_print_scalar_element(i8 %38, i64 %40)
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.42, i64 0, i64 0))
  %42 = load %struct.tnode*, %struct.tnode** %11, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 2
  %44 = load %struct.tpool*, %struct.tpool** %43, align 8
  %45 = icmp eq %struct.tpool* %44, @funk_global_memory_pool
  %46 = zext i1 %45 to i64
  %47 = select i1 %45, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %48 = load %struct.tnode*, %struct.tnode** %11, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 0
  %50 = load i32, i32* %49, align 8
  %51 = load i32, i32* %12, align 4
  %52 = add i32 %50, %51
  %53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.41, i64 0, i64 0), i8* %47, i32 %52)
  %54 = load %struct.tnode*, %struct.tnode** %11, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 2
  %56 = load %struct.tpool*, %struct.tpool** %55, align 8
  %57 = getelementptr inbounds %struct.tpool, %struct.tpool* %56, i32 0, i32 0
  %58 = load %struct.tnode*, %struct.tnode** %11, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 0
  %60 = load i32, i32* %59, align 8
  %61 = load i32, i32* %12, align 4
  %62 = add i32 %60, %61
  %63 = zext i32 %62 to i64
  %64 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %57, i64 0, i64 %63
  %65 = bitcast %struct.tdata* %64 to { i8, i64 }*
  %66 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %65, i32 0, i32 0
  %67 = load i8, i8* %66, align 8
  %68 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %65, i32 0, i32 1
  %69 = load i64, i64* %68, align 8
  call void @funk_print_scalar_element(i8 %67, i64 %69)
  %70 = load %struct.tnode*, %struct.tnode** %7, align 8
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %70, i32 0, i32 2
  %72 = load %struct.tpool*, %struct.tpool** %71, align 8
  %73 = icmp eq %struct.tpool* %72, @funk_global_memory_pool
  %74 = zext i1 %73 to i64
  %75 = select i1 %73, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %76 = load %struct.tnode*, %struct.tnode** %7, align 8
  %77 = getelementptr inbounds %struct.tnode, %struct.tnode* %76, i32 0, i32 0
  %78 = load i32, i32* %77, align 8
  %79 = load i32, i32* %8, align 4
  %80 = add i32 %78, %79
  %81 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.43, i64 0, i64 0), i8* %75, i32 %80)
  %82 = load %struct.tnode*, %struct.tnode** %7, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 2
  %84 = load %struct.tpool*, %struct.tpool** %83, align 8
  %85 = getelementptr inbounds %struct.tpool, %struct.tpool* %84, i32 0, i32 0
  %86 = load %struct.tnode*, %struct.tnode** %7, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 0
  %88 = load i32, i32* %87, align 8
  %89 = load i32, i32* %8, align 4
  %90 = add i32 %88, %89
  %91 = zext i32 %90 to i64
  %92 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %85, i64 0, i64 %91
  %93 = bitcast %struct.tdata* %92 to { i8, i64 }*
  %94 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %93, i32 0, i32 0
  %95 = load i8, i8* %94, align 8
  %96 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %93, i32 0, i32 1
  %97 = load i64, i64* %96, align 8
  call void @funk_print_scalar_element(i8 %95, i64 %97)
  %98 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.44, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tdata, align 8
  %12 = alloca %struct.tdata*, align 8
  %13 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %14 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %18

16:                                               ; preds = %5
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__FUNCTION__.funk_add_ri, i64 0, i64 0))
  br label %18

18:                                               ; preds = %16, %5
  %19 = load i32, i32* %9, align 4
  %20 = load %struct.tnode*, %struct.tnode** %8, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 4
  %23 = icmp ugt i32 %19, %22
  br i1 %23, label %24, label %30

24:                                               ; preds = %18
  %25 = load i32, i32* %9, align 4
  %26 = load %struct.tnode*, %struct.tnode** %8, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = load i32, i32* %27, align 4
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.45, i64 0, i64 0), i32 %25, i32 %28)
  br label %30

30:                                               ; preds = %24, %18
  %31 = load i32, i32* %7, align 4
  %32 = load %struct.tnode*, %struct.tnode** %6, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = load i32, i32* %33, align 4
  %35 = icmp ugt i32 %31, %34
  br i1 %35, label %36, label %42

36:                                               ; preds = %30
  %37 = load i32, i32* %7, align 4
  %38 = load %struct.tnode*, %struct.tnode** %6, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.45, i64 0, i64 0), i32 %37, i32 %40)
  br label %42

42:                                               ; preds = %36, %30
  %43 = load %struct.tnode*, %struct.tnode** %8, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 2
  %45 = load %struct.tpool*, %struct.tpool** %44, align 8
  %46 = getelementptr inbounds %struct.tpool, %struct.tpool* %45, i32 0, i32 0
  %47 = load %struct.tnode*, %struct.tnode** %8, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 0
  %49 = load i32, i32* %48, align 8
  %50 = load i32, i32* %9, align 4
  %51 = add i32 %49, %50
  %52 = zext i32 %51 to i64
  %53 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %46, i64 0, i64 %52
  %54 = bitcast %struct.tdata* %11 to i8*
  %55 = bitcast %struct.tdata* %53 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %54, i8* align 8 %55, i64 16, i1 false)
  %56 = load %struct.tnode*, %struct.tnode** %6, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 2
  %58 = load %struct.tpool*, %struct.tpool** %57, align 8
  %59 = getelementptr inbounds %struct.tpool, %struct.tpool* %58, i32 0, i32 0
  %60 = load %struct.tnode*, %struct.tnode** %6, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 0
  %62 = load i32, i32* %61, align 8
  %63 = load i32, i32* %7, align 4
  %64 = add i32 %62, %63
  %65 = zext i32 %64 to i64
  %66 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %59, i64 0, i64 %65
  store %struct.tdata* %66, %struct.tdata** %12, align 8
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 0
  %68 = load i8, i8* %67, align 8
  store i8 %68, i8* %13, align 1
  %69 = load i8, i8* %13, align 1
  %70 = zext i8 %69 to i32
  %71 = icmp eq i32 %70, 1
  br i1 %71, label %72, label %83

72:                                               ; preds = %42
  %73 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 1
  %74 = bitcast %union.data_type* %73 to i32*
  %75 = load i32, i32* %74, align 8
  %76 = load i32, i32* %10, align 4
  %77 = add nsw i32 %75, %76
  %78 = load %struct.tdata*, %struct.tdata** %12, align 8
  %79 = getelementptr inbounds %struct.tdata, %struct.tdata* %78, i32 0, i32 1
  %80 = bitcast %union.data_type* %79 to i32*
  store i32 %77, i32* %80, align 8
  %81 = load %struct.tdata*, %struct.tdata** %12, align 8
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  store i8 1, i8* %82, align 8
  br label %104

83:                                               ; preds = %42
  %84 = load i8, i8* %13, align 1
  %85 = zext i8 %84 to i32
  %86 = icmp eq i32 %85, 2
  br i1 %86, label %87, label %99

87:                                               ; preds = %83
  %88 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 1
  %89 = bitcast %union.data_type* %88 to double*
  %90 = load double, double* %89, align 8
  %91 = load i32, i32* %10, align 4
  %92 = sitofp i32 %91 to double
  %93 = fadd double %90, %92
  %94 = load %struct.tdata*, %struct.tdata** %12, align 8
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %94, i32 0, i32 1
  %96 = bitcast %union.data_type* %95 to double*
  store double %93, double* %96, align 8
  %97 = load %struct.tdata*, %struct.tdata** %12, align 8
  %98 = getelementptr inbounds %struct.tdata, %struct.tdata* %97, i32 0, i32 0
  store i8 2, i8* %98, align 8
  br label %103

99:                                               ; preds = %83
  %100 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.46, i64 0, i64 0))
  %101 = load %struct.tdata*, %struct.tdata** %12, align 8
  %102 = getelementptr inbounds %struct.tdata, %struct.tdata* %101, i32 0, i32 0
  store i8 0, i8* %102, align 8
  br label %103

103:                                              ; preds = %99, %87
  br label %104

104:                                              ; preds = %103, %72
  %105 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %106 = icmp ne i32 %105, 0
  br i1 %106, label %107, label %147

107:                                              ; preds = %104
  %108 = load %struct.tnode*, %struct.tnode** %8, align 8
  %109 = getelementptr inbounds %struct.tnode, %struct.tnode* %108, i32 0, i32 2
  %110 = load %struct.tpool*, %struct.tpool** %109, align 8
  %111 = icmp eq %struct.tpool* %110, @funk_global_memory_pool
  %112 = zext i1 %111 to i64
  %113 = select i1 %111, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %114 = load %struct.tnode*, %struct.tnode** %8, align 8
  %115 = getelementptr inbounds %struct.tnode, %struct.tnode* %114, i32 0, i32 0
  %116 = load i32, i32* %115, align 8
  %117 = load i32, i32* %9, align 4
  %118 = add i32 %116, %117
  %119 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.41, i64 0, i64 0), i8* %113, i32 %118)
  %120 = bitcast %struct.tdata* %11 to { i8, i64 }*
  %121 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %120, i32 0, i32 0
  %122 = load i8, i8* %121, align 8
  %123 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %120, i32 0, i32 1
  %124 = load i64, i64* %123, align 8
  call void @funk_print_scalar_element(i8 %122, i64 %124)
  %125 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.42, i64 0, i64 0))
  %126 = load i32, i32* %10, align 4
  %127 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.47, i64 0, i64 0), i32 %126)
  %128 = load %struct.tnode*, %struct.tnode** %6, align 8
  %129 = getelementptr inbounds %struct.tnode, %struct.tnode* %128, i32 0, i32 2
  %130 = load %struct.tpool*, %struct.tpool** %129, align 8
  %131 = icmp eq %struct.tpool* %130, @funk_global_memory_pool
  %132 = zext i1 %131 to i64
  %133 = select i1 %131, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0)
  %134 = load %struct.tnode*, %struct.tnode** %6, align 8
  %135 = getelementptr inbounds %struct.tnode, %struct.tnode* %134, i32 0, i32 0
  %136 = load i32, i32* %135, align 8
  %137 = load i32, i32* %7, align 4
  %138 = add i32 %136, %137
  %139 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.43, i64 0, i64 0), i8* %133, i32 %138)
  %140 = load %struct.tdata*, %struct.tdata** %12, align 8
  %141 = bitcast %struct.tdata* %140 to { i8, i64 }*
  %142 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %141, i32 0, i32 0
  %143 = load i8, i8* %142, align 8
  %144 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %141, i32 0, i32 1
  %145 = load i64, i64* %144, align 8
  call void @funk_print_scalar_element(i8 %143, i64 %145)
  %146 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.44, i64 0, i64 0))
  br label %147

147:                                              ; preds = %107, %104
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %21

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fmul double %14, %17
  %19 = load i8*, i8** %5, align 8
  %20 = bitcast i8* %19 to double*
  store double %18, double* %20, align 8
  br label %31

21:                                               ; preds = %4
  %22 = load i8*, i8** %6, align 8
  %23 = bitcast i8* %22 to i32*
  %24 = load i32, i32* %23, align 4
  %25 = load i8*, i8** %7, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = mul nsw i32 %24, %27
  %29 = load i8*, i8** %5, align 8
  %30 = bitcast i8* %29 to i32*
  store i32 %28, i32* %30, align 4
  br label %31

31:                                               ; preds = %21, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %21

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fdiv double %14, %17
  %19 = load i8*, i8** %5, align 8
  %20 = bitcast i8* %19 to double*
  store double %18, double* %20, align 8
  br label %31

21:                                               ; preds = %4
  %22 = load i8*, i8** %6, align 8
  %23 = bitcast i8* %22 to i32*
  %24 = load i32, i32* %23, align 4
  %25 = load i8*, i8** %7, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = sdiv i32 %24, %27
  %29 = load i8*, i8** %5, align 8
  %30 = bitcast i8* %29 to i32*
  store i32 %28, i32* %30, align 4
  br label %31

31:                                               ; preds = %21, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %21

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fadd double %14, %17
  %19 = load i8*, i8** %5, align 8
  %20 = bitcast i8* %19 to double*
  store double %18, double* %20, align 8
  br label %31

21:                                               ; preds = %4
  %22 = load i8*, i8** %6, align 8
  %23 = bitcast i8* %22 to i32*
  %24 = load i32, i32* %23, align 4
  %25 = load i8*, i8** %7, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = add nsw i32 %24, %27
  %29 = load i8*, i8** %5, align 8
  %30 = bitcast i8* %29 to i32*
  store i32 %28, i32* %30, align 4
  br label %31

31:                                               ; preds = %21, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %21

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fsub double %14, %17
  %19 = load i8*, i8** %5, align 8
  %20 = bitcast i8* %19 to double*
  store double %18, double* %20, align 8
  br label %31

21:                                               ; preds = %4
  %22 = load i8*, i8** %6, align 8
  %23 = bitcast i8* %22 to i32*
  %24 = load i32, i32* %23, align 4
  %25 = load i8*, i8** %7, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = sub nsw i32 %24, %27
  %29 = load i8*, i8** %5, align 8
  %30 = bitcast i8* %29 to i32*
  store i32 %28, i32* %30, align 4
  br label %31

31:                                               ; preds = %21, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mod(i8*, i8*, i8*, i32) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %9 = load i8*, i8** %6, align 8
  %10 = bitcast i8* %9 to i32*
  %11 = load i32, i32* %10, align 4
  %12 = load i8*, i8** %7, align 8
  %13 = bitcast i8* %12 to i32*
  %14 = load i32, i32* %13, align 4
  %15 = srem i32 %11, %14
  %16 = load i8*, i8** %5, align 8
  %17 = bitcast i8* %16 to i32*
  store i32 %15, i32* %17, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_arith_op_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32, void (i8*, i8*, i8*, i32)*) #0 {
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca %struct.tnode*, align 8
  %11 = alloca i32, align 4
  %12 = alloca %struct.tnode*, align 8
  %13 = alloca i32, align 4
  %14 = alloca void (i8*, i8*, i8*, i32)*, align 8
  %15 = alloca %struct.tdata, align 8
  %16 = alloca %struct.tdata, align 8
  %17 = alloca %struct.tdata*, align 8
  %18 = alloca i8, align 1
  %19 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %8, align 8
  store i32 %1, i32* %9, align 4
  store %struct.tnode* %2, %struct.tnode** %10, align 8
  store i32 %3, i32* %11, align 4
  store %struct.tnode* %4, %struct.tnode** %12, align 8
  store i32 %5, i32* %13, align 4
  store void (i8*, i8*, i8*, i32)* %6, void (i8*, i8*, i8*, i32)** %14, align 8
  %20 = load i32, i32* %11, align 4
  %21 = load %struct.tnode*, %struct.tnode** %10, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = load i32, i32* %22, align 4
  %24 = icmp ugt i32 %20, %23
  br i1 %24, label %25, label %31

25:                                               ; preds = %7
  %26 = load i32, i32* %11, align 4
  %27 = load %struct.tnode*, %struct.tnode** %10, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.45, i64 0, i64 0), i32 %26, i32 %29)
  br label %31

31:                                               ; preds = %25, %7
  %32 = load i32, i32* %13, align 4
  %33 = load %struct.tnode*, %struct.tnode** %12, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = icmp ugt i32 %32, %35
  br i1 %36, label %37, label %43

37:                                               ; preds = %31
  %38 = load i32, i32* %13, align 4
  %39 = load %struct.tnode*, %struct.tnode** %12, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 1
  %41 = load i32, i32* %40, align 4
  %42 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.45, i64 0, i64 0), i32 %38, i32 %41)
  br label %43

43:                                               ; preds = %37, %31
  %44 = load i32, i32* %9, align 4
  %45 = load %struct.tnode*, %struct.tnode** %8, align 8
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %45, i32 0, i32 1
  %47 = load i32, i32* %46, align 4
  %48 = icmp ugt i32 %44, %47
  br i1 %48, label %49, label %55

49:                                               ; preds = %43
  %50 = load i32, i32* %9, align 4
  %51 = load %struct.tnode*, %struct.tnode** %8, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 1
  %53 = load i32, i32* %52, align 4
  %54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.45, i64 0, i64 0), i32 %50, i32 %53)
  br label %55

55:                                               ; preds = %49, %43
  %56 = load %struct.tnode*, %struct.tnode** %10, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 2
  %58 = load %struct.tpool*, %struct.tpool** %57, align 8
  %59 = getelementptr inbounds %struct.tpool, %struct.tpool* %58, i32 0, i32 0
  %60 = load %struct.tnode*, %struct.tnode** %10, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 0
  %62 = load i32, i32* %61, align 8
  %63 = load i32, i32* %11, align 4
  %64 = add i32 %62, %63
  %65 = zext i32 %64 to i64
  %66 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %59, i64 0, i64 %65
  %67 = bitcast %struct.tdata* %15 to i8*
  %68 = bitcast %struct.tdata* %66 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %67, i8* align 8 %68, i64 16, i1 false)
  %69 = load %struct.tnode*, %struct.tnode** %12, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 2
  %71 = load %struct.tpool*, %struct.tpool** %70, align 8
  %72 = getelementptr inbounds %struct.tpool, %struct.tpool* %71, i32 0, i32 0
  %73 = load %struct.tnode*, %struct.tnode** %12, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 0
  %75 = load i32, i32* %74, align 8
  %76 = load i32, i32* %13, align 4
  %77 = add i32 %75, %76
  %78 = zext i32 %77 to i64
  %79 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %72, i64 0, i64 %78
  %80 = bitcast %struct.tdata* %16 to i8*
  %81 = bitcast %struct.tdata* %79 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %80, i8* align 8 %81, i64 16, i1 false)
  %82 = load %struct.tnode*, %struct.tnode** %8, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 2
  %84 = load %struct.tpool*, %struct.tpool** %83, align 8
  %85 = getelementptr inbounds %struct.tpool, %struct.tpool* %84, i32 0, i32 0
  %86 = load %struct.tnode*, %struct.tnode** %8, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 0
  %88 = load i32, i32* %87, align 8
  %89 = load i32, i32* %9, align 4
  %90 = add i32 %88, %89
  %91 = zext i32 %90 to i64
  %92 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %85, i64 0, i64 %91
  store %struct.tdata* %92, %struct.tdata** %17, align 8
  %93 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %94 = load i8, i8* %93, align 8
  store i8 %94, i8* %18, align 1
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 0
  %96 = load i8, i8* %95, align 8
  store i8 %96, i8* %19, align 1
  %97 = load i8, i8* %19, align 1
  %98 = zext i8 %97 to i32
  %99 = icmp eq i32 %98, 4
  br i1 %99, label %100, label %101

100:                                              ; preds = %55
  store i8 1, i8* %19, align 1
  br label %101

101:                                              ; preds = %100, %55
  %102 = load i8, i8* %18, align 1
  %103 = zext i8 %102 to i32
  %104 = icmp eq i32 %103, 4
  br i1 %104, label %105, label %106

105:                                              ; preds = %101
  store i8 1, i8* %18, align 1
  br label %106

106:                                              ; preds = %105, %101
  %107 = load i8, i8* %18, align 1
  %108 = zext i8 %107 to i32
  %109 = icmp eq i32 %108, 1
  br i1 %109, label %110, label %128

110:                                              ; preds = %106
  %111 = load i8, i8* %19, align 1
  %112 = zext i8 %111 to i32
  %113 = icmp eq i32 %112, 1
  br i1 %113, label %114, label %128

114:                                              ; preds = %110
  %115 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %116 = load %struct.tdata*, %struct.tdata** %17, align 8
  %117 = getelementptr inbounds %struct.tdata, %struct.tdata* %116, i32 0, i32 1
  %118 = bitcast %union.data_type* %117 to i32*
  %119 = bitcast i32* %118 to i8*
  %120 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %121 = bitcast %union.data_type* %120 to i32*
  %122 = bitcast i32* %121 to i8*
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
  %124 = bitcast %union.data_type* %123 to i32*
  %125 = bitcast i32* %124 to i8*
  call void %115(i8* %119, i8* %122, i8* %125, i32 0)
  %126 = load %struct.tdata*, %struct.tdata** %17, align 8
  %127 = getelementptr inbounds %struct.tdata, %struct.tdata* %126, i32 0, i32 0
  store i8 1, i8* %127, align 8
  br label %205

128:                                              ; preds = %110, %106
  %129 = load i8, i8* %18, align 1
  %130 = zext i8 %129 to i32
  %131 = icmp eq i32 %130, 2
  br i1 %131, label %132, label %150

132:                                              ; preds = %128
  %133 = load i8, i8* %19, align 1
  %134 = zext i8 %133 to i32
  %135 = icmp eq i32 %134, 2
  br i1 %135, label %136, label %150

136:                                              ; preds = %132
  %137 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %138 = load %struct.tdata*, %struct.tdata** %17, align 8
  %139 = getelementptr inbounds %struct.tdata, %struct.tdata* %138, i32 0, i32 1
  %140 = bitcast %union.data_type* %139 to double*
  %141 = bitcast double* %140 to i8*
  %142 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %143 = bitcast %union.data_type* %142 to double*
  %144 = bitcast double* %143 to i8*
  %145 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
  %146 = bitcast %union.data_type* %145 to double*
  %147 = bitcast double* %146 to i8*
  call void %137(i8* %141, i8* %144, i8* %147, i32 1)
  %148 = load %struct.tdata*, %struct.tdata** %17, align 8
  %149 = getelementptr inbounds %struct.tdata, %struct.tdata* %148, i32 0, i32 0
  store i8 2, i8* %149, align 8
  br label %204

150:                                              ; preds = %132, %128
  %151 = load i8, i8* %18, align 1
  %152 = zext i8 %151 to i32
  %153 = icmp eq i32 %152, 2
  br i1 %153, label %154, label %172

154:                                              ; preds = %150
  %155 = load i8, i8* %19, align 1
  %156 = zext i8 %155 to i32
  %157 = icmp eq i32 %156, 1
  br i1 %157, label %158, label %172

158:                                              ; preds = %154
  %159 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %160 = load %struct.tdata*, %struct.tdata** %17, align 8
  %161 = getelementptr inbounds %struct.tdata, %struct.tdata* %160, i32 0, i32 1
  %162 = bitcast %union.data_type* %161 to double*
  %163 = bitcast double* %162 to i8*
  %164 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %165 = bitcast %union.data_type* %164 to double*
  %166 = bitcast double* %165 to i8*
  %167 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
  %168 = bitcast %union.data_type* %167 to i32*
  %169 = bitcast i32* %168 to i8*
  call void %159(i8* %163, i8* %166, i8* %169, i32 1)
  %170 = load %struct.tdata*, %struct.tdata** %17, align 8
  %171 = getelementptr inbounds %struct.tdata, %struct.tdata* %170, i32 0, i32 0
  store i8 2, i8* %171, align 8
  br label %203

172:                                              ; preds = %154, %150
  %173 = load i8, i8* %18, align 1
  %174 = zext i8 %173 to i32
  %175 = icmp eq i32 %174, 1
  br i1 %175, label %176, label %194

176:                                              ; preds = %172
  %177 = load i8, i8* %19, align 1
  %178 = zext i8 %177 to i32
  %179 = icmp eq i32 %178, 2
  br i1 %179, label %180, label %194

180:                                              ; preds = %176
  %181 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %182 = load %struct.tdata*, %struct.tdata** %17, align 8
  %183 = getelementptr inbounds %struct.tdata, %struct.tdata* %182, i32 0, i32 1
  %184 = bitcast %union.data_type* %183 to double*
  %185 = bitcast double* %184 to i8*
  %186 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %187 = bitcast %union.data_type* %186 to i32*
  %188 = bitcast i32* %187 to i8*
  %189 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
  %190 = bitcast %union.data_type* %189 to double*
  %191 = bitcast double* %190 to i8*
  call void %181(i8* %185, i8* %188, i8* %191, i32 1)
  %192 = load %struct.tdata*, %struct.tdata** %17, align 8
  %193 = getelementptr inbounds %struct.tdata, %struct.tdata* %192, i32 0, i32 0
  store i8 2, i8* %193, align 8
  br label %202

194:                                              ; preds = %176, %172
  %195 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.48, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0))
  %196 = load i8, i8* %18, align 1
  call void @funk_print_type(i8 zeroext %196)
  %197 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.42, i64 0, i64 0))
  %198 = load i8, i8* %19, align 1
  call void @funk_print_type(i8 zeroext %198)
  %199 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.34, i64 0, i64 0))
  %200 = load %struct.tdata*, %struct.tdata** %17, align 8
  %201 = getelementptr inbounds %struct.tdata, %struct.tdata* %200, i32 0, i32 0
  store i8 0, i8* %201, align 8
  br label %202

202:                                              ; preds = %194, %180
  br label %203

203:                                              ; preds = %202, %158
  br label %204

204:                                              ; preds = %203, %136
  br label %205

205:                                              ; preds = %204, %114
  %206 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %207 = icmp ne i32 %206, 0
  br i1 %207, label %208, label %215

208:                                              ; preds = %205
  %209 = load %struct.tnode*, %struct.tnode** %8, align 8
  %210 = load i32, i32* %9, align 4
  %211 = load %struct.tnode*, %struct.tnode** %10, align 8
  %212 = load i32, i32* %11, align 4
  %213 = load %struct.tnode*, %struct.tnode** %12, align 8
  %214 = load i32, i32* %13, align 4
  call void @debug_print_arith_operation(%struct.tnode* %209, i32 %210, %struct.tnode* %211, i32 %212, %struct.tnode* %213, i32 %214)
  br label %215

215:                                              ; preds = %208, %205
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_mul)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_add)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_sub)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_div)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mod_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32, i32* %8, align 4
  %15 = load %struct.tnode*, %struct.tnode** %9, align 8
  %16 = load i32, i32* %10, align 4
  %17 = load %struct.tnode*, %struct.tnode** %11, align 8
  %18 = load i32, i32* %12, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_mod)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rf(%struct.tnode*, i32, %struct.tnode*, i32, double) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store double %4, double* %10, align 8
  %12 = load double, double* %10, align 8
  call void @funk_create_float_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %11, double %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_add)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_rf(%struct.tnode*, i32, %struct.tnode*, i32, double) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store double %4, double* %10, align 8
  %12 = load double, double* %10, align 8
  call void @funk_create_float_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %11, double %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_sub)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_dimension(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.49, i64 0, i64 0))
  store i32 0, i32* %3, align 4
  br label %5

5:                                                ; preds = %21, %1
  %6 = load i32, i32* %3, align 4
  %7 = load %struct.tnode*, %struct.tnode** %2, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 3
  %9 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %8, i32 0, i32 0
  %10 = load i32, i32* %9, align 8
  %11 = icmp ult i32 %6, %10
  br i1 %11, label %12, label %24

12:                                               ; preds = %5
  %13 = load %struct.tnode*, %struct.tnode** %2, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 3
  %15 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %14, i32 0, i32 1
  %16 = load i32, i32* %3, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [2 x i32], [2 x i32]* %15, i64 0, i64 %17
  %19 = load i32, i32* %18, align 4
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.50, i64 0, i64 0), i32 %19)
  br label %21

21:                                               ; preds = %12
  %22 = load i32, i32* %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %3, align 4
  br label %5

24:                                               ; preds = %5
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.51, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_scalar(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %6 = load %struct.tnode*, %struct.tnode** %2, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 3
  %8 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %7, i32 0, i32 0
  %9 = load i32, i32* %8, align 8
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %26

11:                                               ; preds = %1
  %12 = load %struct.tnode*, %struct.tnode** %2, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 2
  %14 = load %struct.tpool*, %struct.tpool** %13, align 8
  %15 = getelementptr inbounds %struct.tpool, %struct.tpool* %14, i32 0, i32 0
  %16 = load %struct.tnode*, %struct.tnode** %2, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %15, i64 0, i64 %19
  %21 = bitcast %struct.tdata* %20 to { i8, i64 }*
  %22 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %21, i32 0, i32 0
  %23 = load i8, i8* %22, align 8
  %24 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %21, i32 0, i32 1
  %25 = load i64, i64* %24, align 8
  call void @funk_print_scalar_element(i8 %23, i64 %25)
  br label %133

26:                                               ; preds = %1
  %27 = load %struct.tnode*, %struct.tnode** %2, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 3
  %29 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %28, i32 0, i32 0
  %30 = load i32, i32* %29, align 8
  %31 = icmp eq i32 %30, 1
  br i1 %31, label %32, label %63

32:                                               ; preds = %26
  %33 = load %struct.tnode*, %struct.tnode** %2, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 0
  %35 = load i32, i32* %34, align 8
  store i32 %35, i32* %3, align 4
  br label %36

36:                                               ; preds = %59, %32
  %37 = load i32, i32* %3, align 4
  %38 = load %struct.tnode*, %struct.tnode** %2, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 0
  %40 = load i32, i32* %39, align 8
  %41 = load %struct.tnode*, %struct.tnode** %2, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 1
  %43 = load i32, i32* %42, align 4
  %44 = add i32 %40, %43
  %45 = icmp ult i32 %37, %44
  br i1 %45, label %46, label %62

46:                                               ; preds = %36
  %47 = load %struct.tnode*, %struct.tnode** %2, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 2
  %49 = load %struct.tpool*, %struct.tpool** %48, align 8
  %50 = getelementptr inbounds %struct.tpool, %struct.tpool* %49, i32 0, i32 0
  %51 = load i32, i32* %3, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %50, i64 0, i64 %52
  %54 = bitcast %struct.tdata* %53 to { i8, i64 }*
  %55 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %54, i32 0, i32 0
  %56 = load i8, i8* %55, align 8
  %57 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %54, i32 0, i32 1
  %58 = load i64, i64* %57, align 8
  call void @funk_print_scalar_element(i8 %56, i64 %58)
  br label %59

59:                                               ; preds = %46
  %60 = load i32, i32* %3, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, i32* %3, align 4
  br label %36

62:                                               ; preds = %36
  br label %132

63:                                               ; preds = %26
  %64 = load %struct.tnode*, %struct.tnode** %2, align 8
  %65 = getelementptr inbounds %struct.tnode, %struct.tnode* %64, i32 0, i32 3
  %66 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %65, i32 0, i32 0
  %67 = load i32, i32* %66, align 8
  %68 = icmp eq i32 %67, 2
  br i1 %68, label %69, label %122

69:                                               ; preds = %63
  %70 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.34, i64 0, i64 0))
  store i32 0, i32* %4, align 4
  br label %71

71:                                               ; preds = %118, %69
  %72 = load i32, i32* %4, align 4
  %73 = load %struct.tnode*, %struct.tnode** %2, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 3
  %75 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %74, i32 0, i32 1
  %76 = getelementptr inbounds [2 x i32], [2 x i32]* %75, i64 0, i64 0
  %77 = load i32, i32* %76, align 4
  %78 = icmp ult i32 %72, %77
  br i1 %78, label %79, label %121

79:                                               ; preds = %71
  store i32 0, i32* %5, align 4
  br label %80

80:                                               ; preds = %113, %79
  %81 = load i32, i32* %5, align 4
  %82 = load %struct.tnode*, %struct.tnode** %2, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 3
  %84 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %83, i32 0, i32 1
  %85 = getelementptr inbounds [2 x i32], [2 x i32]* %84, i64 0, i64 1
  %86 = load i32, i32* %85, align 4
  %87 = icmp ult i32 %81, %86
  br i1 %87, label %88, label %116

88:                                               ; preds = %80
  %89 = load %struct.tnode*, %struct.tnode** %2, align 8
  %90 = getelementptr inbounds %struct.tnode, %struct.tnode* %89, i32 0, i32 2
  %91 = load %struct.tpool*, %struct.tpool** %90, align 8
  %92 = getelementptr inbounds %struct.tpool, %struct.tpool* %91, i32 0, i32 0
  %93 = load %struct.tnode*, %struct.tnode** %2, align 8
  %94 = getelementptr inbounds %struct.tnode, %struct.tnode* %93, i32 0, i32 0
  %95 = load i32, i32* %94, align 8
  %96 = load i32, i32* %4, align 4
  %97 = load %struct.tnode*, %struct.tnode** %2, align 8
  %98 = getelementptr inbounds %struct.tnode, %struct.tnode* %97, i32 0, i32 3
  %99 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %98, i32 0, i32 1
  %100 = getelementptr inbounds [2 x i32], [2 x i32]* %99, i64 0, i64 1
  %101 = load i32, i32* %100, align 4
  %102 = mul i32 %96, %101
  %103 = add i32 %95, %102
  %104 = load i32, i32* %5, align 4
  %105 = add i32 %103, %104
  %106 = zext i32 %105 to i64
  %107 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %92, i64 0, i64 %106
  %108 = bitcast %struct.tdata* %107 to { i8, i64 }*
  %109 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %108, i32 0, i32 0
  %110 = load i8, i8* %109, align 8
  %111 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %108, i32 0, i32 1
  %112 = load i64, i64* %111, align 8
  call void @funk_print_scalar_element(i8 %110, i64 %112)
  br label %113

113:                                              ; preds = %88
  %114 = load i32, i32* %5, align 4
  %115 = add nsw i32 %114, 1
  store i32 %115, i32* %5, align 4
  br label %80

116:                                              ; preds = %80
  %117 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.34, i64 0, i64 0))
  br label %118

118:                                              ; preds = %116
  %119 = load i32, i32* %4, align 4
  %120 = add nsw i32 %119, 1
  store i32 %120, i32* %4, align 4
  br label %71

121:                                              ; preds = %71
  br label %131

122:                                              ; preds = %63
  %123 = load %struct.tnode*, %struct.tnode** %2, align 8
  %124 = getelementptr inbounds %struct.tnode, %struct.tnode* %123, i32 0, i32 3
  %125 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %124, i32 0, i32 0
  %126 = load i32, i32* %125, align 8
  %127 = load %struct.tnode*, %struct.tnode** %2, align 8
  %128 = getelementptr inbounds %struct.tnode, %struct.tnode* %127, i32 0, i32 1
  %129 = load i32, i32* %128, align 4
  %130 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.52, i64 0, i64 0), i32 %126, i32 %129)
  br label %131

131:                                              ; preds = %122, %121
  br label %132

132:                                              ; preds = %131, %62
  br label %133

133:                                              ; preds = %132, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_2d_array(%struct.tnode*, i32, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 2
  %9 = load %struct.tpool*, %struct.tpool** %8, align 8
  %10 = getelementptr inbounds %struct.tpool, %struct.tpool* %9, i32 0, i32 0
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 0
  %13 = load i32, i32* %12, align 8
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 3
  %16 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %15, i32 0, i32 1
  %17 = getelementptr inbounds [2 x i32], [2 x i32]* %16, i64 0, i64 1
  %18 = load i32, i32* %17, align 4
  %19 = load i32, i32* %5, align 4
  %20 = mul i32 %18, %19
  %21 = add i32 %13, %20
  %22 = load i32, i32* %6, align 4
  %23 = add i32 %21, %22
  %24 = zext i32 %23 to i64
  %25 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %10, i64 0, i64 %24
  %26 = bitcast %struct.tdata* %25 to { i8, i64 }*
  %27 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %26, i32 0, i32 0
  %28 = load i8, i8* %27, align 8
  %29 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %26, i32 0, i32 1
  %30 = load i64, i64* %29, align 8
  call void @funk_print_scalar_element(i8 %28, i64 %30)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define float @funk_ToFloat(%struct.tnode*) #0 {
  %2 = alloca float, align 4
  %3 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  %4 = load %struct.tnode*, %struct.tnode** %3, align 8
  %5 = getelementptr inbounds %struct.tnode, %struct.tnode* %4, i32 0, i32 2
  %6 = load %struct.tpool*, %struct.tpool** %5, align 8
  %7 = getelementptr inbounds %struct.tpool, %struct.tpool* %6, i32 0, i32 0
  %8 = load %struct.tnode*, %struct.tnode** %3, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 0
  %10 = load i32, i32* %9, align 8
  %11 = zext i32 %10 to i64
  %12 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %7, i64 0, i64 %11
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i8, i8* %13, align 8
  %15 = zext i8 %14 to i32
  %16 = icmp eq i32 %15, 1
  br i1 %16, label %17, label %31

17:                                               ; preds = %1
  %18 = load %struct.tnode*, %struct.tnode** %3, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 2
  %20 = load %struct.tpool*, %struct.tpool** %19, align 8
  %21 = getelementptr inbounds %struct.tpool, %struct.tpool* %20, i32 0, i32 0
  %22 = load %struct.tnode*, %struct.tnode** %3, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %21, i64 0, i64 %25
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
  %28 = bitcast %union.data_type* %27 to i32*
  %29 = load i32, i32* %28, align 8
  %30 = sitofp i32 %29 to float
  store float %30, float* %2, align 4
  br label %70

31:                                               ; preds = %1
  %32 = load %struct.tnode*, %struct.tnode** %3, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 2
  %34 = load %struct.tpool*, %struct.tpool** %33, align 8
  %35 = getelementptr inbounds %struct.tpool, %struct.tpool* %34, i32 0, i32 0
  %36 = load %struct.tnode*, %struct.tnode** %3, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 0
  %38 = load i32, i32* %37, align 8
  %39 = zext i32 %38 to i64
  %40 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %35, i64 0, i64 %39
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 0
  %42 = load i8, i8* %41, align 8
  %43 = zext i8 %42 to i32
  %44 = icmp eq i32 %43, 2
  br i1 %44, label %45, label %59

45:                                               ; preds = %31
  %46 = load %struct.tnode*, %struct.tnode** %3, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 2
  %48 = load %struct.tpool*, %struct.tpool** %47, align 8
  %49 = getelementptr inbounds %struct.tpool, %struct.tpool* %48, i32 0, i32 0
  %50 = load %struct.tnode*, %struct.tnode** %3, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 0
  %52 = load i32, i32* %51, align 8
  %53 = zext i32 %52 to i64
  %54 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %49, i64 0, i64 %53
  %55 = getelementptr inbounds %struct.tdata, %struct.tdata* %54, i32 0, i32 1
  %56 = bitcast %union.data_type* %55 to double*
  %57 = load double, double* %56, align 8
  %58 = fptrunc double %57 to float
  store float %58, float* %2, align 4
  br label %70

59:                                               ; preds = %31
  %60 = load %struct.tnode*, %struct.tnode** %3, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 2
  %62 = load %struct.tpool*, %struct.tpool** %61, align 8
  %63 = getelementptr inbounds %struct.tpool, %struct.tpool* %62, i32 0, i32 0
  %64 = load %struct.tnode*, %struct.tnode** %3, align 8
  %65 = getelementptr inbounds %struct.tnode, %struct.tnode* %64, i32 0, i32 0
  %66 = load i32, i32* %65, align 8
  %67 = zext i32 %66 to i64
  %68 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %63, i64 0, i64 %67
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 0
  store i8 0, i8* %69, align 8
  store float 0.000000e+00, float* %2, align 4
  br label %70

70:                                               ; preds = %59, %45, %17
  %71 = load float, float* %2, align 4
  ret float %71
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_read_list_from_file(%struct.tpool*, %struct.tnode*, i8*) #0 {
  %4 = alloca %struct.tpool*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca %struct.__sFILE*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i8* %2, i8** %6, align 8
  %10 = load i8*, i8** %6, align 8
  %11 = call %struct.__sFILE* @"\01_fopen"(i8* %10, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.53, i64 0, i64 0))
  store %struct.__sFILE* %11, %struct.__sFILE** %7, align 8
  %12 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %13 = icmp eq %struct.__sFILE* %12, null
  br i1 %13, label %14, label %17

14:                                               ; preds = %3
  %15 = load i8*, i8** %6, align 8
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.54, i64 0, i64 0), i8* %15)
  call void @exit(i32 1) #4
  unreachable

17:                                               ; preds = %3
  %18 = load i8*, i8** %6, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.55, i64 0, i64 0), i8* %18)
  store i32 0, i32* %8, align 4
  store i32 0, i32* %9, align 4
  %20 = load %struct.tpool*, %struct.tpool** %4, align 8
  %21 = getelementptr inbounds %struct.tpool, %struct.tpool* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 8
  %23 = load %struct.tnode*, %struct.tnode** %5, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 0
  store i32 %22, i32* %24, align 8
  %25 = load %struct.tnode*, %struct.tnode** %5, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 3
  %27 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %26, i32 0, i32 0
  store i32 1, i32* %27, align 8
  %28 = load %struct.tpool*, %struct.tpool** %4, align 8
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 2
  store %struct.tpool* %28, %struct.tpool** %30, align 8
  br label %31

31:                                               ; preds = %35, %17
  %32 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %33 = call i32 (%struct.__sFILE*, i8*, ...) @fscanf(%struct.__sFILE* %32, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.56, i64 0, i64 0), i32* %8)
  %34 = icmp eq i32 %33, 1
  br i1 %34, label %35, label %68

35:                                               ; preds = %31
  %36 = load %struct.tpool*, %struct.tpool** %4, align 8
  %37 = getelementptr inbounds %struct.tpool, %struct.tpool* %36, i32 0, i32 1
  %38 = load i32, i32* %37, align 8
  %39 = load i32, i32* %8, align 4
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.57, i64 0, i64 0), i32 %38, i32 %39)
  %41 = load i32, i32* %8, align 4
  %42 = load %struct.tpool*, %struct.tpool** %4, align 8
  %43 = getelementptr inbounds %struct.tpool, %struct.tpool* %42, i32 0, i32 0
  %44 = load %struct.tpool*, %struct.tpool** %4, align 8
  %45 = getelementptr inbounds %struct.tpool, %struct.tpool* %44, i32 0, i32 1
  %46 = load i32, i32* %45, align 8
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %43, i64 0, i64 %47
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 1
  %50 = bitcast %union.data_type* %49 to i32*
  store i32 %41, i32* %50, align 8
  %51 = load %struct.tpool*, %struct.tpool** %4, align 8
  %52 = getelementptr inbounds %struct.tpool, %struct.tpool* %51, i32 0, i32 0
  %53 = load %struct.tpool*, %struct.tpool** %4, align 8
  %54 = getelementptr inbounds %struct.tpool, %struct.tpool* %53, i32 0, i32 1
  %55 = load i32, i32* %54, align 8
  %56 = zext i32 %55 to i64
  %57 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %52, i64 0, i64 %56
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 0
  store i8 1, i8* %58, align 8
  %59 = load %struct.tpool*, %struct.tpool** %4, align 8
  %60 = getelementptr inbounds %struct.tpool, %struct.tpool* %59, i32 0, i32 1
  %61 = load i32, i32* %60, align 8
  %62 = add i32 %61, 1
  %63 = urem i32 %62, 1024
  %64 = load %struct.tpool*, %struct.tpool** %4, align 8
  %65 = getelementptr inbounds %struct.tpool, %struct.tpool* %64, i32 0, i32 1
  store i32 %63, i32* %65, align 8
  %66 = load i32, i32* %9, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, i32* %9, align 4
  br label %31

68:                                               ; preds = %31
  %69 = load i32, i32* %9, align 4
  %70 = load %struct.tnode*, %struct.tnode** %5, align 8
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %70, i32 0, i32 1
  store i32 %69, i32* %71, align 4
  %72 = load %struct.tnode*, %struct.tnode** %5, align 8
  %73 = getelementptr inbounds %struct.tnode, %struct.tnode* %72, i32 0, i32 0
  %74 = load i32, i32* %73, align 8
  %75 = load %struct.tnode*, %struct.tnode** %5, align 8
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %75, i32 0, i32 1
  %77 = load i32, i32* %76, align 4
  %78 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.58, i64 0, i64 0), i32 %74, i32 %77)
  %79 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %80 = call i32 @fclose(%struct.__sFILE* %79)
  ret void
}

declare %struct.__sFILE* @"\01_fopen"(i8*, i8*) #1

declare i32 @fscanf(%struct.__sFILE*, i8*, ...) #1

declare i32 @fclose(%struct.__sFILE*) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @reshape(%struct.tnode*, i32*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32* %1, i32** %5, align 8
  store i32 %2, i32* %6, align 4
  %9 = load i32, i32* %6, align 4
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 3
  %12 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %11, i32 0, i32 0
  store i32 %9, i32* %12, align 8
  store i32 1, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %13

13:                                               ; preds = %43, %3
  %14 = load i32, i32* %8, align 4
  %15 = load i32, i32* %6, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %20

17:                                               ; preds = %13
  %18 = load i32, i32* %8, align 4
  %19 = icmp slt i32 %18, 2
  br label %20

20:                                               ; preds = %17, %13
  %21 = phi i1 [ false, %13 ], [ %19, %17 ]
  br i1 %21, label %22, label %46

22:                                               ; preds = %20
  %23 = load i32*, i32** %5, align 8
  %24 = load i32, i32* %8, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i32, i32* %23, i64 %25
  %27 = load i32, i32* %26, align 4
  %28 = load %struct.tnode*, %struct.tnode** %4, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 3
  %30 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %29, i32 0, i32 1
  %31 = load i32, i32* %8, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [2 x i32], [2 x i32]* %30, i64 0, i64 %32
  store i32 %27, i32* %33, align 4
  %34 = load %struct.tnode*, %struct.tnode** %4, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 3
  %36 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %35, i32 0, i32 1
  %37 = load i32, i32* %8, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [2 x i32], [2 x i32]* %36, i64 0, i64 %38
  %40 = load i32, i32* %39, align 4
  %41 = load i32, i32* %7, align 4
  %42 = mul i32 %41, %40
  store i32 %42, i32* %7, align 4
  br label %43

43:                                               ; preds = %22
  %44 = load i32, i32* %8, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, i32* %8, align 4
  br label %13

46:                                               ; preds = %20
  %47 = load %struct.tnode*, %struct.tnode** %4, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 3
  %49 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %48, i32 0, i32 0
  %50 = load i32, i32* %49, align 8
  %51 = load %struct.tnode*, %struct.tnode** %4, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 3
  %53 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %52, i32 0, i32 1
  %54 = getelementptr inbounds [2 x i32], [2 x i32]* %53, i64 0, i64 0
  %55 = load i32, i32* %54, align 4
  %56 = load %struct.tnode*, %struct.tnode** %4, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 3
  %58 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %57, i32 0, i32 1
  %59 = getelementptr inbounds [2 x i32], [2 x i32]* %58, i64 0, i64 1
  %60 = load i32, i32* %59, align 4
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.59, i64 0, i64 0), i32 %50, i32 %55, i32 %60)
  %62 = load i32, i32* %7, align 4
  %63 = load %struct.tnode*, %struct.tnode** %4, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 1
  %65 = load i32, i32* %64, align 4
  %66 = icmp ugt i32 %62, %65
  br i1 %66, label %67, label %72

67:                                               ; preds = %46
  %68 = load %struct.tnode*, %struct.tnode** %4, align 8
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i32 0, i32 1
  %70 = load i32, i32* %69, align 4
  %71 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([66 x i8], [66 x i8]* @.str.60, i64 0, i64 0), i32 %70)
  br label %72

72:                                               ; preds = %67, %46
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 9.0.1 "}
