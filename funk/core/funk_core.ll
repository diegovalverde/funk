; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.16.0"

%struct.tnode = type { i32, i32, %struct.tpool*, %struct.tdimensions }
%struct.tpool = type { [6000 x %struct.tdata], i32 }
%struct.tdata = type { i8, %union.data_type }
%union.data_type = type { double }
%struct.tdimensions = type { i32, [2 x i32] }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }

@g_funk_debug_current_executed_line = global i32 0, align 4
@g_funk_internal_function_tracing_enabled = global i32 0, align 4
@funk_types_str = global [7 x [100 x i8]] [[100 x i8] c"type_invalid\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_int\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_double\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_empty_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_scalar\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_function\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00"], align 16
@g_funk_print_array_max_elements = global i32 30, align 4
@g_funk_print_array_element_per_row = global i32 50, align 4
@g_debug_continue = global i32 0, align 4
@g_funk_verbosity = global i32 0, align 4
@.str = private unnamed_addr constant [36 x i8] c"%s wrapping around %d + %d = %d:%d\0A\00", align 1
@__FUNCTION__.get_node = private unnamed_addr constant [9 x i8] c"get_node\00", align 1
@g_debug_node_tail = global i32 0, align 4
@g_debug_nodes = common global [1024 x %struct.tnode] zeroinitializer, align 16
@.str.1 = private unnamed_addr constant [5 x i8] c"%d: \00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3 = private unnamed_addr constant [11 x i8] c"collision \00", align 1
@funk_sleep.first = internal global i32 1, align 4
@funk_global_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str.4 = private unnamed_addr constant [53 x i8] c"%s -I- wrapping around pool %s. tail = %d, max = %d\0A\00", align 1
@__FUNCTION__.funk_increment_pool_tail = private unnamed_addr constant [25 x i8] c"funk_increment_pool_tail\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"gpool\00", align 1
@.str.6 = private unnamed_addr constant [6 x i8] c"fpool\00", align 1
@.str.7 = private unnamed_addr constant [11 x i8] c"START %s \0A\00", align 1
@__FUNCTION__.funk_print_node_info = private unnamed_addr constant [21 x i8] c"funk_print_node_info\00", align 1
@.str.8 = private unnamed_addr constant [26 x i8] c"%s[%d :%d] %d-dimensional\00", align 1
@.str.9 = private unnamed_addr constant [9 x i8] c"END %s \0A\00", align 1
@__FUNCTION__.funk_copy_node = private unnamed_addr constant [15 x i8] c"funk_copy_node\00", align 1
@__FUNCTION__.set_s2d_user_global_state = private unnamed_addr constant [26 x i8] c"set_s2d_user_global_state\00", align 1
@gRenderLoopState = common global %struct.tnode zeroinitializer, align 8
@.str.10 = private unnamed_addr constant [6 x i8] c">>>>\0A\00", align 1
@__FUNCTION__.get_s2d_user_global_state = private unnamed_addr constant [26 x i8] c"get_s2d_user_global_state\00", align 1
@.str.11 = private unnamed_addr constant [43 x i8] c"-I- Setting conf parameter %d to value %d\0A\00", align 1
@.str.12 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.13 = private unnamed_addr constant [24 x i8] c"-E- %s Invalid type %d\0A\00", align 1
@__FUNCTION__.funk_print_type = private unnamed_addr constant [16 x i8] c"funk_print_type\00", align 1
@.str.14 = private unnamed_addr constant [13 x i8] c"-I- Exiting\0A\00", align 1
@.str.15 = private unnamed_addr constant [4 x i8] c"%s \00", align 1
@__FUNCTION__.funk_init = private unnamed_addr constant [10 x i8] c"funk_init\00", align 1
@funk_functions_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str.16 = private unnamed_addr constant [39 x i8] c"===== FUNK Interactive debugger =====\0A\00", align 1
@.str.17 = private unnamed_addr constant [25 x i8] c"-I- Global pool size %d\0A\00", align 1
@.str.18 = private unnamed_addr constant [26 x i8] c"-I- init_random_seed: %d\0A\00", align 1
@.str.19 = private unnamed_addr constant [24 x i8] c"Press any key to start\0A\00", align 1
@__FUNCTION__.is_list_consecutive_in_memory = private unnamed_addr constant [30 x i8] c"is_list_consecutive_in_memory\00", align 1
@.str.20 = private unnamed_addr constant [50 x i8] c"-E- %s node lhs data type is %d but shall be int\0A\00", align 1
@__FUNCTION__.funk_create_list_slide_2d_var = private unnamed_addr constant [30 x i8] c"funk_create_list_slide_2d_var\00", align 1
@.str.21 = private unnamed_addr constant [42 x i8] c"-E- %s index %d out of array boundary %d\0A\00", align 1
@__FUNCTION__.funk_create_list_slide_1d_var = private unnamed_addr constant [30 x i8] c"funk_create_list_slide_1d_var\00", align 1
@.str.22 = private unnamed_addr constant [76 x i8] c"-E- %s the number of indexes provided %d does not match dimension count %d\0A\00", align 1
@__FUNCTION__.funk_create_list_slide = private unnamed_addr constant [23 x i8] c"funk_create_list_slide\00", align 1
@.str.23 = private unnamed_addr constant [56 x i8] c"-E- %s the index %d >  upper bound %d for dimension %d\0A\00", align 1
@.str.24 = private unnamed_addr constant [44 x i8] c"-E- %s %d dimensions are not yet supported\0A\00", align 1
@.str.25 = private unnamed_addr constant [41 x i8] c"-E- %s index %d out of range for len %d\0A\00", align 1
@__FUNCTION__.funk_create_list = private unnamed_addr constant [17 x i8] c"funk_create_list\00", align 1
@.str.26 = private unnamed_addr constant [63 x i8] c"->>>>> I- List is not consecutive in pool. Will create a copy\0A\00", align 1
@.str.27 = private unnamed_addr constant [9 x i8] c"NNNNNNN\0A\00", align 1
@.str.28 = private unnamed_addr constant [5 x i8] c"%d  \00", align 1
@__FUNCTION__.funk_create_2d_matrix = private unnamed_addr constant [22 x i8] c"funk_create_2d_matrix\00", align 1
@.str.29 = private unnamed_addr constant [27 x i8] c">>>>> %d %d pool_tail: %d\0A\00", align 1
@.str.30 = private unnamed_addr constant [16 x i8] c"%s %s[%d] = %d\0A\00", align 1
@__FUNCTION__.funk_create_int_scalar = private unnamed_addr constant [23 x i8] c"funk_create_int_scalar\00", align 1
@.str.31 = private unnamed_addr constant [16 x i8] c"%s %s[%d] = %f\0A\00", align 1
@__FUNCTION__.funk_create_float_scalar = private unnamed_addr constant [25 x i8] c"funk_create_float_scalar\00", align 1
@__FUNCTION__.funk_create_list_int_literal = private unnamed_addr constant [29 x i8] c"funk_create_list_int_literal\00", align 1
@__FUNCTION__.funk_create_2d_matrix_int_literal = private unnamed_addr constant [34 x i8] c"funk_create_2d_matrix_int_literal\00", align 1
@__FUNCTION__.funk_copy_element_from_pool = private unnamed_addr constant [28 x i8] c"funk_copy_element_from_pool\00", align 1
@.str.32 = private unnamed_addr constant [38 x i8] c"-E- Indexes %d, %d are out of bounds\0A\00", align 1
@.str.33 = private unnamed_addr constant [6 x i8] c" %3d \00", align 1
@.str.34 = private unnamed_addr constant [8 x i8] c" %5.5f \00", align 1
@.str.35 = private unnamed_addr constant [6 x i8] c" %5s \00", align 1
@.str.36 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str.37 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.38 = private unnamed_addr constant [10 x i8] c"%s %s[%d]\00", align 1
@__FUNCTION__.funk_get_node_type = private unnamed_addr constant [19 x i8] c"funk_get_node_type\00", align 1
@.str.39 = private unnamed_addr constant [43 x i8] c"-E- %s: offset %d out of bounds for len %d\00", align 1
@.str.40 = private unnamed_addr constant [3 x i8] c"\0A \00", align 1
@__FUNCTION__.funk_set_node_type = private unnamed_addr constant [19 x i8] c"funk_set_node_type\00", align 1
@__FUNCTION__.funk_set_node_value_int = private unnamed_addr constant [24 x i8] c"funk_set_node_value_int\00", align 1
@__FUNCTION__.funk_get_node_value_int = private unnamed_addr constant [24 x i8] c"funk_get_node_value_int\00", align 1
@.str.41 = private unnamed_addr constant [12 x i8] c"tail @: %d\0A\00", align 1
@.str.42 = private unnamed_addr constant [25 x i8] c"%s %s start: %d len: %d\0A\00", align 1
@__FUNCTION__.funk_get_next_node = private unnamed_addr constant [19 x i8] c"funk_get_next_node\00", align 1
@.str.43 = private unnamed_addr constant [67 x i8] c"\0A\0A\0A=== funk_global_memory_pool.tail = %d about to reach max of %d\0A\00", align 1
@.str.44 = private unnamed_addr constant [16 x i8] c"\0A\0A\0A=== %s === \0A\00", align 1
@.str.45 = private unnamed_addr constant [2 x i8] c">\00", align 1
@__stdinp = external global %struct.__sFILE*, align 8
@.str.46 = private unnamed_addr constant [11 x i8] c"begin len:\00", align 1
@.str.47 = private unnamed_addr constant [6 x i8] c"%d %d\00", align 1
@.str.48 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.49 = private unnamed_addr constant [2 x i8] c"q\00", align 1
@.str.50 = private unnamed_addr constant [5 x i8] c"fnod\00", align 1
@.str.51 = private unnamed_addr constant [5 x i8] c"gnod\00", align 1
@.str.52 = private unnamed_addr constant [3 x i8] c"rs\00", align 1
@.str.53 = private unnamed_addr constant [2 x i8] c"c\00", align 1
@__FUNCTION__.funk_memcp_arr = private unnamed_addr constant [15 x i8] c"funk_memcp_arr\00", align 1
@.str.54 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.55 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.56 = private unnamed_addr constant [10 x i8] c" = %s[%d]\00", align 1
@.str.57 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
@.str.58 = private unnamed_addr constant [54 x i8] c"-E- Invalid index %d is greater than array size of %d\00", align 1
@.str.59 = private unnamed_addr constant [24 x i8] c"-E- %s: invalid types: \00", align 1
@__FUNCTION__.funk_arith_op_rr = private unnamed_addr constant [17 x i8] c"funk_arith_op_rr\00", align 1
@.str.60 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.61 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.62 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.63 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@__FUNCTION__.print_scalar = private unnamed_addr constant [13 x i8] c"print_scalar\00", align 1
@.str.64 = private unnamed_addr constant [22 x i8] c">------------------<\0A\00", align 1
@.str.65 = private unnamed_addr constant [10 x i8] c"%d x %d \0A\00", align 1
@.str.66 = private unnamed_addr constant [40 x i8] c" [...] %d-dimensional with %d elements\0A\00", align 1
@.str.67 = private unnamed_addr constant [65 x i8] c"%s Error cannot address as a matrix since node has %d dimensions\00", align 1
@__FUNCTION__.print_2d_array_element_reg_reg = private unnamed_addr constant [31 x i8] c"print_2d_array_element_reg_reg\00", align 1
@.str.68 = private unnamed_addr constant [29 x i8] c"XXXXXXX %d, %d: dimension %d\00", align 1
@.str.69 = private unnamed_addr constant [9 x i8] c"ERROR %s\00", align 1
@__FUNCTION__.funk_ToFloat = private unnamed_addr constant [13 x i8] c"funk_ToFloat\00", align 1
@.str.70 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.71 = private unnamed_addr constant [30 x i8] c"-E- File '%s' cannot be read\0A\00", align 1
@.str.72 = private unnamed_addr constant [21 x i8] c"-D- Opened file '%s'\00", align 1
@.str.73 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.74 = private unnamed_addr constant [66 x i8] c"-E- reshape operation not possible for variable with %d elements\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tdata* @get_node(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %6 = load %struct.tnode*, %struct.tnode** %3, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 0
  %8 = load i32, i32* %7, align 8
  %9 = load i32, i32* %4, align 4
  %10 = add i32 %8, %9
  store i32 %10, i32* %5, align 4
  %11 = load i32, i32* %5, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %27

13:                                               ; preds = %2
  %14 = load i32, i32* %5, align 4
  %15 = urem i32 %14, 6000
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %27

17:                                               ; preds = %13
  %18 = load %struct.tnode*, %struct.tnode** %3, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = load i32, i32* %4, align 4
  %22 = load i32, i32* %5, align 4
  %23 = load %struct.tnode*, %struct.tnode** %3, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.get_node, i64 0, i64 0), i32 %20, i32 %21, i32 %22, i32 %25)
  br label %27

27:                                               ; preds = %17, %13, %2
  %28 = load %struct.tnode*, %struct.tnode** %3, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 2
  %30 = load %struct.tpool*, %struct.tpool** %29, align 8
  %31 = getelementptr inbounds %struct.tpool, %struct.tpool* %30, i32 0, i32 0
  %32 = load i32, i32* %5, align 4
  %33 = urem i32 %32, 6000
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds [6000 x %struct.tdata], [6000 x %struct.tdata]* %31, i64 0, i64 %34
  ret %struct.tdata* %35
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_register_node(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load i32, i32* @g_debug_node_tail, align 4
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %4
  %6 = load %struct.tnode*, %struct.tnode** %2, align 8
  %7 = bitcast %struct.tnode* %5 to i8*
  %8 = bitcast %struct.tnode* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %7, i8* align 8 %8, i64 32, i1 false)
  %9 = load i32, i32* @g_debug_node_tail, align 4
  %10 = add nsw i32 %9, 1
  %11 = srem i32 %10, 1024
  store i32 %11, i32* @g_debug_node_tail, align 4
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_nodes(%struct.tpool*) #0 {
  %2 = alloca %struct.tpool*, align 8
  %3 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %2, align 8
  store i32 0, i32* %3, align 4
  br label %4

4:                                                ; preds = %24, %1
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* @g_debug_node_tail, align 4
  %7 = icmp slt i32 %5, %6
  br i1 %7, label %8, label %27

8:                                                ; preds = %4
  %9 = load %struct.tpool*, %struct.tpool** %2, align 8
  %10 = load i32, i32* %3, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %11
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 2
  %14 = load %struct.tpool*, %struct.tpool** %13, align 8
  %15 = icmp eq %struct.tpool* %9, %14
  br i1 %15, label %16, label %23

16:                                               ; preds = %8
  %17 = load i32, i32* %3, align 4
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i32 %17)
  %19 = load i32, i32* %3, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %20
  call void @funk_print_node_info(%struct.tnode* %21)
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
  br label %23

23:                                               ; preds = %16, %8
  br label %24

24:                                               ; preds = %23
  %25 = load i32, i32* %3, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, i32* %3, align 4
  br label %4

27:                                               ; preds = %4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node_info(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0))
  br label %7

7:                                                ; preds = %5, %1
  %8 = load %struct.tnode*, %struct.tnode** %2, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 2
  %10 = load %struct.tpool*, %struct.tpool** %9, align 8
  %11 = icmp eq %struct.tpool* %10, @funk_global_memory_pool
  %12 = zext i1 %11 to i64
  %13 = select i1 %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0)
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
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.8, i64 0, i64 0), i8* %13, i32 %16, i32 %19, i32 %23)
  %25 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %29

27:                                               ; preds = %7
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([21 x i8], [21 x i8]* @__FUNCTION__.funk_print_node_info, i64 0, i64 0))
  br label %29

29:                                               ; preds = %27, %7
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_collision_checker() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  br label %3

3:                                                ; preds = %184, %0
  %4 = load i32, i32* %1, align 4
  %5 = icmp slt i32 %4, 6000
  br i1 %5, label %6, label %187

6:                                                ; preds = %3
  store i32 0, i32* %2, align 4
  br label %7

7:                                                ; preds = %180, %6
  %8 = load i32, i32* %2, align 4
  %9 = icmp slt i32 %8, 6000
  br i1 %9, label %10, label %183

10:                                               ; preds = %7
  %11 = load i32, i32* %1, align 4
  %12 = load i32, i32* %2, align 4
  %13 = icmp eq i32 %11, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %10
  br label %180

15:                                               ; preds = %10
  %16 = load i32, i32* %1, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %17
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 2
  %20 = load %struct.tpool*, %struct.tpool** %19, align 8
  %21 = load i32, i32* %2, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %22
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 2
  %25 = load %struct.tpool*, %struct.tpool** %24, align 8
  %26 = icmp eq %struct.tpool* %20, %25
  br i1 %26, label %27, label %179

27:                                               ; preds = %15
  %28 = load i32, i32* %1, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %29
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 16
  %33 = load i32, i32* %2, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %34
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 0
  %37 = load i32, i32* %36, align 16
  %38 = icmp uge i32 %32, %37
  br i1 %38, label %39, label %57

39:                                               ; preds = %27
  %40 = load i32, i32* %1, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %41
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 0
  %44 = load i32, i32* %43, align 16
  %45 = load i32, i32* %2, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %46
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 0
  %49 = load i32, i32* %48, align 16
  %50 = load i32, i32* %2, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %51
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = load i32, i32* %53, align 4
  %55 = add i32 %49, %54
  %56 = icmp ule i32 %44, %55
  br i1 %56, label %171, label %57

57:                                               ; preds = %39, %27
  %58 = load i32, i32* %2, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %59
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 0
  %62 = load i32, i32* %61, align 16
  %63 = load i32, i32* %1, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %64
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 0
  %67 = load i32, i32* %66, align 16
  %68 = icmp uge i32 %62, %67
  br i1 %68, label %69, label %87

69:                                               ; preds = %57
  %70 = load i32, i32* %2, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %71
  %73 = getelementptr inbounds %struct.tnode, %struct.tnode* %72, i32 0, i32 0
  %74 = load i32, i32* %73, align 16
  %75 = load i32, i32* %1, align 4
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %76
  %78 = getelementptr inbounds %struct.tnode, %struct.tnode* %77, i32 0, i32 0
  %79 = load i32, i32* %78, align 16
  %80 = load i32, i32* %1, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %81
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 1
  %84 = load i32, i32* %83, align 4
  %85 = add i32 %79, %84
  %86 = icmp ule i32 %74, %85
  br i1 %86, label %171, label %87

87:                                               ; preds = %69, %57
  %88 = load i32, i32* %1, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %89
  %91 = getelementptr inbounds %struct.tnode, %struct.tnode* %90, i32 0, i32 0
  %92 = load i32, i32* %91, align 16
  %93 = load i32, i32* %1, align 4
  %94 = sext i32 %93 to i64
  %95 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %94
  %96 = getelementptr inbounds %struct.tnode, %struct.tnode* %95, i32 0, i32 1
  %97 = load i32, i32* %96, align 4
  %98 = add i32 %92, %97
  %99 = load i32, i32* %2, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %100
  %102 = getelementptr inbounds %struct.tnode, %struct.tnode* %101, i32 0, i32 0
  %103 = load i32, i32* %102, align 16
  %104 = icmp uge i32 %98, %103
  br i1 %104, label %105, label %129

105:                                              ; preds = %87
  %106 = load i32, i32* %1, align 4
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %107
  %109 = getelementptr inbounds %struct.tnode, %struct.tnode* %108, i32 0, i32 0
  %110 = load i32, i32* %109, align 16
  %111 = load i32, i32* %1, align 4
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %112
  %114 = getelementptr inbounds %struct.tnode, %struct.tnode* %113, i32 0, i32 1
  %115 = load i32, i32* %114, align 4
  %116 = add i32 %110, %115
  %117 = load i32, i32* %2, align 4
  %118 = sext i32 %117 to i64
  %119 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %118
  %120 = getelementptr inbounds %struct.tnode, %struct.tnode* %119, i32 0, i32 0
  %121 = load i32, i32* %120, align 16
  %122 = load i32, i32* %2, align 4
  %123 = sext i32 %122 to i64
  %124 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %123
  %125 = getelementptr inbounds %struct.tnode, %struct.tnode* %124, i32 0, i32 1
  %126 = load i32, i32* %125, align 4
  %127 = add i32 %121, %126
  %128 = icmp ule i32 %116, %127
  br i1 %128, label %171, label %129

129:                                              ; preds = %105, %87
  %130 = load i32, i32* %2, align 4
  %131 = sext i32 %130 to i64
  %132 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %131
  %133 = getelementptr inbounds %struct.tnode, %struct.tnode* %132, i32 0, i32 0
  %134 = load i32, i32* %133, align 16
  %135 = load i32, i32* %2, align 4
  %136 = sext i32 %135 to i64
  %137 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %136
  %138 = getelementptr inbounds %struct.tnode, %struct.tnode* %137, i32 0, i32 1
  %139 = load i32, i32* %138, align 4
  %140 = add i32 %134, %139
  %141 = load i32, i32* %1, align 4
  %142 = sext i32 %141 to i64
  %143 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %142
  %144 = getelementptr inbounds %struct.tnode, %struct.tnode* %143, i32 0, i32 0
  %145 = load i32, i32* %144, align 16
  %146 = icmp uge i32 %140, %145
  br i1 %146, label %147, label %179

147:                                              ; preds = %129
  %148 = load i32, i32* %2, align 4
  %149 = sext i32 %148 to i64
  %150 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %149
  %151 = getelementptr inbounds %struct.tnode, %struct.tnode* %150, i32 0, i32 0
  %152 = load i32, i32* %151, align 16
  %153 = load i32, i32* %2, align 4
  %154 = sext i32 %153 to i64
  %155 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %154
  %156 = getelementptr inbounds %struct.tnode, %struct.tnode* %155, i32 0, i32 1
  %157 = load i32, i32* %156, align 4
  %158 = add i32 %152, %157
  %159 = load i32, i32* %1, align 4
  %160 = sext i32 %159 to i64
  %161 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %160
  %162 = getelementptr inbounds %struct.tnode, %struct.tnode* %161, i32 0, i32 0
  %163 = load i32, i32* %162, align 16
  %164 = load i32, i32* %1, align 4
  %165 = sext i32 %164 to i64
  %166 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %165
  %167 = getelementptr inbounds %struct.tnode, %struct.tnode* %166, i32 0, i32 1
  %168 = load i32, i32* %167, align 4
  %169 = add i32 %163, %168
  %170 = icmp ule i32 %158, %169
  br i1 %170, label %171, label %179

171:                                              ; preds = %147, %105, %69, %39
  %172 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i64 0, i64 0))
  %173 = load i32, i32* %1, align 4
  %174 = sext i32 %173 to i64
  %175 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %174
  call void @funk_print_node_info(%struct.tnode* %175)
  %176 = load i32, i32* %2, align 4
  %177 = sext i32 %176 to i64
  %178 = getelementptr inbounds [1024 x %struct.tnode], [1024 x %struct.tnode]* @g_debug_nodes, i64 0, i64 %177
  call void @funk_print_node_info(%struct.tnode* %178)
  br label %179

179:                                              ; preds = %171, %147, %129, %15
  br label %180

180:                                              ; preds = %179, %14
  %181 = load i32, i32* %2, align 4
  %182 = add nsw i32 %181, 1
  store i32 %182, i32* %2, align 4
  br label %7

183:                                              ; preds = %7
  br label %184

184:                                              ; preds = %183
  %185 = load i32, i32* %1, align 4
  %186 = add nsw i32 %185, 1
  store i32 %186, i32* %1, align 4
  br label %3

187:                                              ; preds = %3
  ret void
}

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
define void @funk_increment_pool_tail(%struct.tpool*, i32) #0 {
  %3 = alloca %struct.tpool*, align 8
  %4 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %struct.tpool*, %struct.tpool** %3, align 8
  %6 = icmp eq %struct.tpool* %5, @funk_global_memory_pool
  br i1 %6, label %7, label %23

7:                                                ; preds = %2
  %8 = load %struct.tpool*, %struct.tpool** %3, align 8
  %9 = getelementptr inbounds %struct.tpool, %struct.tpool* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 8
  %11 = load i32, i32* %4, align 4
  %12 = add i32 %10, %11
  %13 = icmp uge i32 %12, 6000
  br i1 %13, label %14, label %23

14:                                               ; preds = %7
  %15 = load %struct.tpool*, %struct.tpool** %3, align 8
  %16 = icmp eq %struct.tpool* %15, @funk_global_memory_pool
  %17 = zext i1 %16 to i64
  %18 = select i1 %16, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0)
  %19 = load %struct.tpool*, %struct.tpool** %3, align 8
  %20 = getelementptr inbounds %struct.tpool, %struct.tpool* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 8
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([53 x i8], [53 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_increment_pool_tail, i64 0, i64 0), i8* %18, i32 %21, i32 6000)
  store i32 0, i32* @g_debug_continue, align 4
  br label %23

23:                                               ; preds = %14, %7, %2
  %24 = load %struct.tpool*, %struct.tpool** %3, align 8
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 8
  %27 = load i32, i32* %4, align 4
  %28 = add i32 %26, %27
  %29 = urem i32 %28, 6000
  %30 = load %struct.tpool*, %struct.tpool** %3, align 8
  %31 = getelementptr inbounds %struct.tpool, %struct.tpool* %30, i32 0, i32 1
  store i32 %29, i32* %31, align 8
  ret void
}

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
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__.funk_copy_node, i64 0, i64 0))
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
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__.funk_copy_node, i64 0, i64 0))
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
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.set_s2d_user_global_state, i64 0, i64 0))
  br label %7

7:                                                ; preds = %5, %1
  %8 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_print_node_info(%struct.tnode* %8)
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_copy_node(%struct.tnode* @gRenderLoopState, %struct.tnode* %9)
  call void @funk_print_node_info(%struct.tnode* @gRenderLoopState)
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i64 0, i64 0))
  %11 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %7
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.set_s2d_user_global_state, i64 0, i64 0))
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
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.get_s2d_user_global_state, i64 0, i64 0))
  br label %6

6:                                                ; preds = %4, %1
  call void @funk_print_node_info(%struct.tnode* @gRenderLoopState)
  %7 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %11

9:                                                ; preds = %6
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @__FUNCTION__.get_s2d_user_global_state, i64 0, i64 0))
  br label %11

11:                                               ; preds = %9, %6
  %12 = bitcast %struct.tnode* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %12, i8* align 8 bitcast (%struct.tnode* @gRenderLoopState to i8*), i64 32, i1 false)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_set_config_param(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.11, i64 0, i64 0), i32 %5, i32 %6)
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
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.12, i64 0, i64 0), i8* %14)
  br label %20

16:                                               ; preds = %6, %1
  %17 = load i8, i8* %2, align 1
  %18 = zext i8 %17 to i32
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.13, i64 0, i64 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_type, i64 0, i64 0), i32 %18)
  br label %20

20:                                               ; preds = %16, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_exit() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.14, i64 0, i64 0))
  call void @exit(i32 0) #4
  unreachable
}

; Function Attrs: noreturn
declare void @exit(i32) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_init() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_init, i64 0, i64 0))
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
  %9 = icmp slt i32 %8, 6000
  br i1 %9, label %10, label %19

10:                                               ; preds = %7
  %11 = load i32, i32* %2, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [6000 x %struct.tdata], [6000 x %struct.tdata]* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 0), i64 0, i64 %12
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
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.16, i64 0, i64 0))
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.17, i64 0, i64 0), i32 6000)
  %22 = load i32, i32* %1, align 4
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.18, i64 0, i64 0), i32 %22)
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.19, i64 0, i64 0))
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
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.is_list_consecutive_in_memory, i64 0, i64 0))
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
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 0
  %14 = load i8, i8* %13, align 8
  %15 = zext i8 %14 to i32
  %16 = icmp ne i32 %15, 1
  br i1 %16, label %17, label %24

17:                                               ; preds = %4
  %18 = load %struct.tnode*, %struct.tnode** %7, align 8
  %19 = call %struct.tdata* @get_node(%struct.tnode* %18, i32 0)
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = zext i8 %21 to i32
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %22)
  br label %24

24:                                               ; preds = %17, %4
  %25 = load %struct.tnode*, %struct.tnode** %8, align 8
  %26 = call %struct.tdata* @get_node(%struct.tnode* %25, i32 0)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  %28 = load i8, i8* %27, align 8
  %29 = zext i8 %28 to i32
  %30 = icmp ne i32 %29, 1
  br i1 %30, label %31, label %38

31:                                               ; preds = %24
  %32 = load %struct.tnode*, %struct.tnode** %8, align 8
  %33 = call %struct.tdata* @get_node(%struct.tnode* %32, i32 0)
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 0
  %35 = load i8, i8* %34, align 8
  %36 = zext i8 %35 to i32
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %36)
  br label %38

38:                                               ; preds = %31, %24
  %39 = load %struct.tnode*, %struct.tnode** %7, align 8
  %40 = call %struct.tdata* @get_node(%struct.tnode* %39, i32 0)
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 1
  %42 = bitcast %union.data_type* %41 to i32*
  %43 = load i32, i32* %42, align 8
  store i32 %43, i32* %9, align 4
  %44 = load %struct.tnode*, %struct.tnode** %8, align 8
  %45 = call %struct.tdata* @get_node(%struct.tnode* %44, i32 0)
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to i32*
  %48 = load i32, i32* %47, align 8
  store i32 %48, i32* %10, align 4
  %49 = load i32, i32* %9, align 4
  %50 = icmp slt i32 %49, 0
  br i1 %50, label %51, label %59

51:                                               ; preds = %38
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 3
  %54 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %53, i32 0, i32 1
  %55 = getelementptr inbounds [2 x i32], [2 x i32]* %54, i64 0, i64 0
  %56 = load i32, i32* %55, align 4
  %57 = load i32, i32* %9, align 4
  %58 = sub i32 %56, %57
  br label %61

59:                                               ; preds = %38
  %60 = load i32, i32* %9, align 4
  br label %61

61:                                               ; preds = %59, %51
  %62 = phi i32 [ %58, %51 ], [ %60, %59 ]
  store i32 %62, i32* %9, align 4
  %63 = load i32, i32* %10, align 4
  %64 = icmp slt i32 %63, 0
  br i1 %64, label %65, label %73

65:                                               ; preds = %61
  %66 = load %struct.tnode*, %struct.tnode** %5, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 3
  %68 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %67, i32 0, i32 1
  %69 = getelementptr inbounds [2 x i32], [2 x i32]* %68, i64 0, i64 1
  %70 = load i32, i32* %69, align 4
  %71 = load i32, i32* %10, align 4
  %72 = sub i32 %70, %71
  br label %75

73:                                               ; preds = %61
  %74 = load i32, i32* %10, align 4
  br label %75

75:                                               ; preds = %73, %65
  %76 = phi i32 [ %72, %65 ], [ %74, %73 ]
  store i32 %76, i32* %10, align 4
  %77 = load i32, i32* %10, align 4
  %78 = load %struct.tnode*, %struct.tnode** %5, align 8
  %79 = getelementptr inbounds %struct.tnode, %struct.tnode* %78, i32 0, i32 3
  %80 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %79, i32 0, i32 1
  %81 = getelementptr inbounds [2 x i32], [2 x i32]* %80, i64 0, i64 0
  %82 = load i32, i32* %81, align 4
  %83 = icmp uge i32 %77, %82
  br i1 %83, label %84, label %92

84:                                               ; preds = %75
  %85 = load i32, i32* %10, align 4
  %86 = load %struct.tnode*, %struct.tnode** %5, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 3
  %88 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %87, i32 0, i32 1
  %89 = getelementptr inbounds [2 x i32], [2 x i32]* %88, i64 0, i64 0
  %90 = load i32, i32* %89, align 4
  %91 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.21, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %85, i32 %90)
  br label %92

92:                                               ; preds = %84, %75
  %93 = load i32, i32* %9, align 4
  %94 = load %struct.tnode*, %struct.tnode** %5, align 8
  %95 = getelementptr inbounds %struct.tnode, %struct.tnode* %94, i32 0, i32 3
  %96 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %95, i32 0, i32 1
  %97 = getelementptr inbounds [2 x i32], [2 x i32]* %96, i64 0, i64 1
  %98 = load i32, i32* %97, align 4
  %99 = icmp uge i32 %93, %98
  br i1 %99, label %100, label %108

100:                                              ; preds = %92
  %101 = load i32, i32* %9, align 4
  %102 = load %struct.tnode*, %struct.tnode** %5, align 8
  %103 = getelementptr inbounds %struct.tnode, %struct.tnode* %102, i32 0, i32 3
  %104 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %103, i32 0, i32 1
  %105 = getelementptr inbounds [2 x i32], [2 x i32]* %104, i64 0, i64 1
  %106 = load i32, i32* %105, align 4
  %107 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.21, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %101, i32 %106)
  br label %108

108:                                              ; preds = %100, %92
  %109 = load %struct.tnode*, %struct.tnode** %5, align 8
  %110 = getelementptr inbounds %struct.tnode, %struct.tnode* %109, i32 0, i32 2
  %111 = load %struct.tpool*, %struct.tpool** %110, align 8
  %112 = load %struct.tnode*, %struct.tnode** %6, align 8
  %113 = getelementptr inbounds %struct.tnode, %struct.tnode* %112, i32 0, i32 2
  store %struct.tpool* %111, %struct.tpool** %113, align 8
  %114 = load %struct.tnode*, %struct.tnode** %6, align 8
  %115 = getelementptr inbounds %struct.tnode, %struct.tnode* %114, i32 0, i32 3
  %116 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %115, i32 0, i32 0
  store i32 0, i32* %116, align 8
  %117 = load %struct.tnode*, %struct.tnode** %6, align 8
  %118 = getelementptr inbounds %struct.tnode, %struct.tnode* %117, i32 0, i32 1
  store i32 1, i32* %118, align 4
  %119 = load %struct.tnode*, %struct.tnode** %5, align 8
  %120 = getelementptr inbounds %struct.tnode, %struct.tnode* %119, i32 0, i32 0
  %121 = load i32, i32* %120, align 8
  %122 = load %struct.tnode*, %struct.tnode** %5, align 8
  %123 = getelementptr inbounds %struct.tnode, %struct.tnode* %122, i32 0, i32 3
  %124 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %123, i32 0, i32 1
  %125 = getelementptr inbounds [2 x i32], [2 x i32]* %124, i64 0, i64 0
  %126 = load i32, i32* %125, align 4
  %127 = load i32, i32* %9, align 4
  %128 = mul i32 %126, %127
  %129 = add i32 %121, %128
  %130 = load i32, i32* %10, align 4
  %131 = add i32 %129, %130
  %132 = urem i32 %131, 6000
  %133 = load %struct.tnode*, %struct.tnode** %6, align 8
  %134 = getelementptr inbounds %struct.tnode, %struct.tnode* %133, i32 0, i32 0
  store i32 %132, i32* %134, align 8
  %135 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_debug_register_node(%struct.tnode* %135)
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
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 0
  %11 = load i8, i8* %10, align 8
  %12 = zext i8 %11 to i32
  %13 = icmp ne i32 %12, 1
  br i1 %13, label %14, label %21

14:                                               ; preds = %3
  %15 = load %struct.tnode*, %struct.tnode** %6, align 8
  %16 = call %struct.tdata* @get_node(%struct.tnode* %15, i32 0)
  %17 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 0
  %18 = load i8, i8* %17, align 8
  %19 = zext i8 %18 to i32
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_1d_var, i64 0, i64 0), i32 %19)
  br label %21

21:                                               ; preds = %14, %3
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0)
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 1
  %25 = bitcast %union.data_type* %24 to i32*
  %26 = load i32, i32* %25, align 8
  store i32 %26, i32* %7, align 4
  %27 = load i32, i32* %7, align 4
  %28 = icmp slt i32 %27, 0
  br i1 %28, label %29, label %37

29:                                               ; preds = %21
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 3
  %32 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %31, i32 0, i32 1
  %33 = getelementptr inbounds [2 x i32], [2 x i32]* %32, i64 0, i64 0
  %34 = load i32, i32* %33, align 4
  %35 = load i32, i32* %7, align 4
  %36 = sub i32 %34, %35
  br label %39

37:                                               ; preds = %21
  %38 = load i32, i32* %7, align 4
  br label %39

39:                                               ; preds = %37, %29
  %40 = phi i32 [ %36, %29 ], [ %38, %37 ]
  store i32 %40, i32* %7, align 4
  %41 = load i32, i32* %7, align 4
  %42 = load %struct.tnode*, %struct.tnode** %4, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 3
  %44 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %43, i32 0, i32 1
  %45 = getelementptr inbounds [2 x i32], [2 x i32]* %44, i64 0, i64 0
  %46 = load i32, i32* %45, align 4
  %47 = icmp uge i32 %41, %46
  br i1 %47, label %48, label %56

48:                                               ; preds = %39
  %49 = load i32, i32* %7, align 4
  %50 = load %struct.tnode*, %struct.tnode** %4, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 3
  %52 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %51, i32 0, i32 1
  %53 = getelementptr inbounds [2 x i32], [2 x i32]* %52, i64 0, i64 0
  %54 = load i32, i32* %53, align 4
  %55 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.21, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_1d_var, i64 0, i64 0), i32 %49, i32 %54)
  br label %56

56:                                               ; preds = %48, %39
  %57 = load %struct.tnode*, %struct.tnode** %4, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 2
  %59 = load %struct.tpool*, %struct.tpool** %58, align 8
  %60 = load %struct.tnode*, %struct.tnode** %5, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 2
  store %struct.tpool* %59, %struct.tpool** %61, align 8
  %62 = load %struct.tnode*, %struct.tnode** %5, align 8
  %63 = getelementptr inbounds %struct.tnode, %struct.tnode* %62, i32 0, i32 3
  %64 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %63, i32 0, i32 0
  store i32 0, i32* %64, align 8
  %65 = load %struct.tnode*, %struct.tnode** %5, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 1
  store i32 1, i32* %66, align 4
  %67 = load %struct.tnode*, %struct.tnode** %4, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 0
  %69 = load i32, i32* %68, align 8
  %70 = load i32, i32* %7, align 4
  %71 = add i32 %69, %70
  %72 = urem i32 %71, 6000
  %73 = load %struct.tnode*, %struct.tnode** %5, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 0
  store i32 %72, i32* %74, align 8
  %75 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_debug_register_node(%struct.tnode* %75)
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
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([76 x i8], [76 x i8]* @.str.22, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i64 0, i64 0), i32 %17, i32 %21)
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
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i64 0, i64 0), i32 %47, i32 %54, i32 %55)
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
  br i1 %73, label %74, label %85

74:                                               ; preds = %61
  %75 = load %struct.tnode*, %struct.tnode** %5, align 8
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %75, i32 0, i32 0
  %77 = load i32, i32* %76, align 8
  %78 = load i32*, i32** %7, align 8
  %79 = getelementptr inbounds i32, i32* %78, i64 0
  %80 = load i32, i32* %79, align 4
  %81 = add i32 %77, %80
  %82 = urem i32 %81, 6000
  %83 = load %struct.tnode*, %struct.tnode** %6, align 8
  %84 = getelementptr inbounds %struct.tnode, %struct.tnode* %83, i32 0, i32 0
  store i32 %82, i32* %84, align 8
  br label %113

85:                                               ; preds = %61
  %86 = load i32, i32* %8, align 4
  %87 = icmp eq i32 %86, 2
  br i1 %87, label %88, label %109

88:                                               ; preds = %85
  %89 = load %struct.tnode*, %struct.tnode** %5, align 8
  %90 = getelementptr inbounds %struct.tnode, %struct.tnode* %89, i32 0, i32 0
  %91 = load i32, i32* %90, align 8
  %92 = load %struct.tnode*, %struct.tnode** %6, align 8
  %93 = getelementptr inbounds %struct.tnode, %struct.tnode* %92, i32 0, i32 3
  %94 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %93, i32 0, i32 1
  %95 = getelementptr inbounds [2 x i32], [2 x i32]* %94, i64 0, i64 0
  %96 = load i32, i32* %95, align 4
  %97 = load i32*, i32** %7, align 8
  %98 = getelementptr inbounds i32, i32* %97, i64 0
  %99 = load i32, i32* %98, align 4
  %100 = mul i32 %96, %99
  %101 = add i32 %91, %100
  %102 = load i32*, i32** %7, align 8
  %103 = getelementptr inbounds i32, i32* %102, i64 1
  %104 = load i32, i32* %103, align 4
  %105 = add i32 %101, %104
  %106 = urem i32 %105, 6000
  %107 = load %struct.tnode*, %struct.tnode** %6, align 8
  %108 = getelementptr inbounds %struct.tnode, %struct.tnode* %107, i32 0, i32 0
  store i32 %106, i32* %108, align 8
  br label %112

109:                                              ; preds = %85
  %110 = load i32, i32* %8, align 4
  %111 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.24, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i64 0, i64 0), i32 %110)
  br label %112

112:                                              ; preds = %109, %88
  br label %113

113:                                              ; preds = %112, %74
  %114 = load %struct.tnode*, %struct.tnode** %6, align 8
  %115 = getelementptr inbounds %struct.tnode, %struct.tnode* %114, i32 0, i32 0
  %116 = load i32, i32* %115, align 8
  %117 = load %struct.tnode*, %struct.tnode** %5, align 8
  %118 = getelementptr inbounds %struct.tnode, %struct.tnode* %117, i32 0, i32 1
  %119 = load i32, i32* %118, align 4
  %120 = icmp uge i32 %116, %119
  br i1 %120, label %121, label %129

121:                                              ; preds = %113
  %122 = load %struct.tnode*, %struct.tnode** %6, align 8
  %123 = getelementptr inbounds %struct.tnode, %struct.tnode* %122, i32 0, i32 0
  %124 = load i32, i32* %123, align 8
  %125 = load %struct.tnode*, %struct.tnode** %5, align 8
  %126 = getelementptr inbounds %struct.tnode, %struct.tnode* %125, i32 0, i32 1
  %127 = load i32, i32* %126, align 4
  %128 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.25, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i64 0, i64 0), i32 %124, i32 %127)
  br label %129

129:                                              ; preds = %121, %113
  %130 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_debug_register_node(%struct.tnode* %130)
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
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_list, i64 0, i64 0))
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
  br label %77

35:                                               ; preds = %14
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([63 x i8], [63 x i8]* @.str.26, i64 0, i64 0))
  %37 = load %struct.tpool*, %struct.tpool** %5, align 8
  %38 = getelementptr inbounds %struct.tpool, %struct.tpool* %37, i32 0, i32 1
  %39 = load i32, i32* %38, align 8
  %40 = load %struct.tnode*, %struct.tnode** %6, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 0
  store i32 %39, i32* %41, align 8
  %42 = load i32, i32* %8, align 4
  %43 = load %struct.tnode*, %struct.tnode** %6, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 1
  store i32 %42, i32* %44, align 4
  %45 = load %struct.tpool*, %struct.tpool** %5, align 8
  %46 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %45, i32 %46)
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.27, i64 0, i64 0))
  store i32 0, i32* %9, align 4
  br label %48

48:                                               ; preds = %72, %35
  %49 = load i32, i32* %9, align 4
  %50 = load i32, i32* %8, align 4
  %51 = icmp slt i32 %49, %50
  br i1 %51, label %52, label %75

52:                                               ; preds = %48
  %53 = load %struct.tnode*, %struct.tnode** %7, align 8
  %54 = load i32, i32* %9, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i64 %55
  %57 = call %struct.tdata* @get_node(%struct.tnode* %56, i32 0)
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 1
  %59 = bitcast %union.data_type* %58 to i32*
  %60 = load i32, i32* %59, align 8
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.28, i64 0, i64 0), i32 %60)
  %62 = load %struct.tnode*, %struct.tnode** %6, align 8
  %63 = load i32, i32* %9, align 4
  %64 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 %63)
  %65 = load %struct.tnode*, %struct.tnode** %7, align 8
  %66 = load i32, i32* %9, align 4
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i64 %67
  %69 = call %struct.tdata* @get_node(%struct.tnode* %68, i32 0)
  %70 = bitcast %struct.tdata* %64 to i8*
  %71 = bitcast %struct.tdata* %69 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %70, i8* align 8 %71, i64 16, i1 false)
  br label %72

72:                                               ; preds = %52
  %73 = load i32, i32* %9, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, i32* %9, align 4
  br label %48

75:                                               ; preds = %48
  %76 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.27, i64 0, i64 0))
  br label %77

77:                                               ; preds = %75, %25
  %78 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_debug_register_node(%struct.tnode* %78)
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
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_2d_matrix, i64 0, i64 0))
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
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.29, i64 0, i64 0), i32 %37, i32 %40, i32 %43)
  %45 = load %struct.tnode*, %struct.tnode** %7, align 8
  call void @funk_debug_register_node(%struct.tnode* %45)
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
  call void @funk_increment_pool_tail(%struct.tpool* %22, i32 1)
  %23 = load i32, i32* %8, align 4
  %24 = trunc i32 %23 to i8
  %25 = load %struct.tnode*, %struct.tnode** %6, align 8
  %26 = call %struct.tdata* @get_node(%struct.tnode* %25, i32 0)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  store i8 %24, i8* %27, align 8
  %28 = load i32, i32* %8, align 4
  switch i32 %28, label %45 [
    i32 1, label %29
    i32 2, label %37
  ]

29:                                               ; preds = %4
  %30 = load i8*, i8** %7, align 8
  %31 = bitcast i8* %30 to i32*
  %32 = load i32, i32* %31, align 4
  %33 = load %struct.tnode*, %struct.tnode** %6, align 8
  %34 = call %struct.tdata* @get_node(%struct.tnode* %33, i32 0)
  %35 = getelementptr inbounds %struct.tdata, %struct.tdata* %34, i32 0, i32 1
  %36 = bitcast %union.data_type* %35 to i32*
  store i32 %32, i32* %36, align 8
  br label %45

37:                                               ; preds = %4
  %38 = load i8*, i8** %7, align 8
  %39 = bitcast i8* %38 to double*
  %40 = load double, double* %39, align 8
  %41 = load %struct.tnode*, %struct.tnode** %6, align 8
  %42 = call %struct.tdata* @get_node(%struct.tnode* %41, i32 0)
  %43 = getelementptr inbounds %struct.tdata, %struct.tdata* %42, i32 0, i32 1
  %44 = bitcast %union.data_type* %43 to double*
  store double %40, double* %44, align 8
  br label %45

45:                                               ; preds = %4, %37, %29
  %46 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_debug_register_node(%struct.tnode* %46)
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
  %13 = select i1 %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0)
  %14 = load %struct.tpool*, %struct.tpool** %4, align 8
  %15 = getelementptr inbounds %struct.tpool, %struct.tpool* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 8
  %17 = load i32, i32* %6, align 4
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_int_scalar, i64 0, i64 0), i8* %13, i32 %16, i32 %17)
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
  %13 = select i1 %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0)
  %14 = load %struct.tpool*, %struct.tpool** %4, align 8
  %15 = getelementptr inbounds %struct.tpool, %struct.tpool* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 8
  %17 = load double, double* %6, align 8
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.31, i64 0, i64 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_create_float_scalar, i64 0, i64 0), i8* %13, i32 %16, double %17)
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
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_create_list_int_literal, i64 0, i64 0))
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
  %30 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %29, i32 %30)
  store i32 0, i32* %9, align 4
  br label %31

31:                                               ; preds = %50, %14
  %32 = load i32, i32* %9, align 4
  %33 = load i32, i32* %8, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %53

35:                                               ; preds = %31
  %36 = load %struct.tnode*, %struct.tnode** %6, align 8
  %37 = load i32, i32* %9, align 4
  %38 = call %struct.tdata* @get_node(%struct.tnode* %36, i32 %37)
  %39 = getelementptr inbounds %struct.tdata, %struct.tdata* %38, i32 0, i32 0
  store i8 1, i8* %39, align 8
  %40 = load i32*, i32** %7, align 8
  %41 = load i32, i32* %9, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds i32, i32* %40, i64 %42
  %44 = load i32, i32* %43, align 4
  %45 = load %struct.tnode*, %struct.tnode** %6, align 8
  %46 = load i32, i32* %9, align 4
  %47 = call %struct.tdata* @get_node(%struct.tnode* %45, i32 %46)
  %48 = getelementptr inbounds %struct.tdata, %struct.tdata* %47, i32 0, i32 1
  %49 = bitcast %union.data_type* %48 to i32*
  store i32 %44, i32* %49, align 8
  br label %50

50:                                               ; preds = %35
  %51 = load i32, i32* %9, align 4
  %52 = add nsw i32 %51, 1
  store i32 %52, i32* %9, align 4
  br label %31

53:                                               ; preds = %31
  %54 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_debug_register_node(%struct.tnode* %54)
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
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_2d_matrix_int_literal, i64 0, i64 0))
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
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.29, i64 0, i64 0), i32 %37, i32 %40, i32 %43)
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
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_copy_element_from_pool, i64 0, i64 0))
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
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.32, i64 0, i64 0), i32 %32, i32 %33)
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
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.33, i64 0, i64 0), i32 %13)
  br label %24

15:                                               ; preds = %2
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.34, i64 0, i64 0), double %18)
  br label %24

20:                                               ; preds = %2
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.35, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.36, i64 0, i64 0))
  br label %24

22:                                               ; preds = %2
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.35, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.37, i64 0, i64 0))
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
  %15 = select i1 %13, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0)
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = load i32, i32* %5, align 4
  %20 = add i32 %18, %19
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.38, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i8* %15, i32 %20)
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
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.39, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 %34, i32 %37)
  br label %39

39:                                               ; preds = %33, %27, %22
  %40 = load %struct.tnode*, %struct.tnode** %4, align 8
  %41 = load i32, i32* %5, align 4
  %42 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 %41)
  %43 = getelementptr inbounds %struct.tdata, %struct.tdata* %42, i32 0, i32 0
  %44 = load i8, i8* %43, align 8
  %45 = load i8*, i8** %6, align 8
  store i8 %44, i8* %45, align 1
  %46 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %48, label %52

48:                                               ; preds = %39
  %49 = load i8*, i8** %6, align 8
  %50 = load i8, i8* %49, align 1
  call void @funk_print_type(i8 zeroext %50)
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.40, i64 0, i64 0))
  br label %52

52:                                               ; preds = %48, %39
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
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0))
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
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.39, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 %18, i32 %21)
  br label %23

23:                                               ; preds = %17, %11
  %24 = load i8, i8* %6, align 1
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = load i32, i32* %5, align 4
  %27 = call %struct.tdata* @get_node(%struct.tnode* %25, i32 %26)
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 0
  store i8 %24, i8* %28, align 8
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
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0))
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
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.39, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 %18, i32 %21)
  br label %23

23:                                               ; preds = %17, %11
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  store i8 1, i8* %27, align 8
  %28 = load i32, i32* %6, align 4
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = load i32, i32* %5, align 4
  %31 = call %struct.tdata* @get_node(%struct.tnode* %29, i32 %30)
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 1
  %33 = bitcast %union.data_type* %32 to i32*
  store i32 %28, i32* %33, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @funk_get_node_value_int(%struct.tnode*, i32) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = load %struct.tnode*, %struct.tnode** %3, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp ugt i32 %5, %8
  br i1 %9, label %10, label %16

10:                                               ; preds = %2
  %11 = load i32, i32* %4, align 4
  %12 = load %struct.tnode*, %struct.tnode** %3, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 1
  %14 = load i32, i32* %13, align 4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.39, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 %11, i32 %14)
  br label %16

16:                                               ; preds = %10, %2
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = load i32, i32* %4, align 4
  %19 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 %18)
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 1
  %21 = bitcast %union.data_type* %20 to i32*
  %22 = load i32, i32* %21, align 8
  ret i32 %22
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_pool(%struct.tpool*, i32, i32) #0 {
  %4 = alloca %struct.tpool*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %8 = load %struct.tpool*, %struct.tpool** %4, align 8
  %9 = getelementptr inbounds %struct.tpool, %struct.tpool* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 8
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.41, i64 0, i64 0), i32 %10)
  %12 = load i32, i32* %5, align 4
  store i32 %12, i32* %7, align 4
  br label %13

13:                                               ; preds = %40, %3
  %14 = load i32, i32* %7, align 4
  %15 = load i32, i32* %5, align 4
  %16 = load i32, i32* %6, align 4
  %17 = add nsw i32 %15, %16
  %18 = icmp slt i32 %14, %17
  br i1 %18, label %19, label %43

19:                                               ; preds = %13
  %20 = load %struct.tpool*, %struct.tpool** %4, align 8
  %21 = getelementptr inbounds %struct.tpool, %struct.tpool* %20, i32 0, i32 0
  %22 = load i32, i32* %7, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [6000 x %struct.tdata], [6000 x %struct.tdata]* %21, i64 0, i64 %23
  %25 = bitcast %struct.tdata* %24 to { i8, i64 }*
  %26 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %25, i32 0, i32 0
  %27 = load i8, i8* %26, align 8
  %28 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %25, i32 0, i32 1
  %29 = load i64, i64* %28, align 8
  call void @funk_print_scalar_element(i8 %27, i64 %29)
  %30 = load i32, i32* %7, align 4
  %31 = icmp sgt i32 %30, 0
  br i1 %31, label %32, label %39

32:                                               ; preds = %19
  %33 = load i32, i32* %7, align 4
  %34 = add nsw i32 %33, 1
  %35 = srem i32 %34, 7
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %37, label %39

37:                                               ; preds = %32
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
  br label %39

39:                                               ; preds = %37, %32, %19
  br label %40

40:                                               ; preds = %39
  %41 = load i32, i32* %7, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %7, align 4
  br label %13

43:                                               ; preds = %13
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
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
  %14 = select i1 %12, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0)
  %15 = load %struct.tnode*, %struct.tnode** %4, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  %18 = load %struct.tnode*, %struct.tnode** %4, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 1
  %20 = load i32, i32* %19, align 4
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.42, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_next_node, i64 0, i64 0), i8* %14, i32 %17, i32 %20)
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
  br i1 %59, label %60, label %75

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
  %69 = call %struct.tdata* @get_node(%struct.tnode* %68, i32 0)
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 0
  store i8 4, i8* %70, align 8
  %71 = load %struct.tnode*, %struct.tnode** %3, align 8
  %72 = call %struct.tdata* @get_node(%struct.tnode* %71, i32 0)
  %73 = getelementptr inbounds %struct.tdata, %struct.tdata* %72, i32 0, i32 1
  %74 = bitcast %union.data_type* %73 to i32*
  store i32 0, i32* %74, align 8
  br label %88

75:                                               ; preds = %55
  %76 = load %struct.tnode*, %struct.tnode** %4, align 8
  %77 = getelementptr inbounds %struct.tnode, %struct.tnode* %76, i32 0, i32 1
  %78 = load i32, i32* %77, align 4
  %79 = sub i32 %78, 1
  %80 = load %struct.tnode*, %struct.tnode** %3, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 1
  store i32 %79, i32* %81, align 4
  %82 = load %struct.tnode*, %struct.tnode** %4, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 0
  %84 = load i32, i32* %83, align 8
  %85 = add i32 %84, 1
  %86 = load %struct.tnode*, %struct.tnode** %3, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 0
  store i32 %85, i32* %87, align 8
  br label %88

88:                                               ; preds = %75, %60
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_function_entry_hook(i8*) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca [8 x i8], align 1
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  %6 = load i32, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 1), align 8
  %7 = add i32 %6, 1
  %8 = icmp eq i32 %7, 6000
  br i1 %8, label %9, label %12

9:                                                ; preds = %1
  %10 = load i32, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 1), align 8
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([67 x i8], [67 x i8]* @.str.43, i64 0, i64 0), i32 %10, i32 6000)
  br label %17

12:                                               ; preds = %1
  %13 = load i32, i32* @g_debug_continue, align 4
  %14 = icmp eq i32 %13, 1
  br i1 %14, label %15, label %16

15:                                               ; preds = %12
  br label %81

16:                                               ; preds = %12
  br label %17

17:                                               ; preds = %16, %9
  %18 = load i8*, i8** %2, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.44, i64 0, i64 0), i8* %18)
  br label %20

20:                                               ; preds = %79, %17
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.45, i64 0, i64 0))
  %22 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %23 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8
  %24 = call i8* @fgets(i8* %22, i32 8, %struct.__sFILE* %23)
  %25 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %26 = call i32 @strncmp(i8* %25, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i64 5)
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %33, label %28

28:                                               ; preds = %20
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.46, i64 0, i64 0))
  %30 = call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.47, i64 0, i64 0), i32* %4, i32* %5)
  %31 = load i32, i32* %4, align 4
  %32 = load i32, i32* %5, align 4
  call void @funk_print_pool(%struct.tpool* @funk_global_memory_pool, i32 %31, i32 %32)
  br label %70

33:                                               ; preds = %20
  %34 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %35 = call i32 @strncmp(i8* %34, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0), i64 5)
  %36 = icmp ne i32 %35, 0
  br i1 %36, label %38, label %37

37:                                               ; preds = %33
  call void @funk_print_pool(%struct.tpool* @funk_functions_memory_pool, i32 0, i32 256)
  br label %69

38:                                               ; preds = %33
  %39 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %40 = call i32 @strncmp(i8* %39, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.48, i64 0, i64 0), i64 1)
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %43, label %42

42:                                               ; preds = %38
  store i32 1, i32* @g_debug_continue, align 4
  br label %68

43:                                               ; preds = %38
  %44 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %45 = call i32 @strncmp(i8* %44, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.49, i64 0, i64 0), i64 1)
  %46 = icmp ne i32 %45, 0
  br i1 %46, label %48, label %47

47:                                               ; preds = %43
  call void @exit(i32 0) #4
  unreachable

48:                                               ; preds = %43
  %49 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %50 = call i32 @strncmp(i8* %49, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.50, i64 0, i64 0), i64 4)
  %51 = icmp ne i32 %50, 0
  br i1 %51, label %53, label %52

52:                                               ; preds = %48
  call void @funk_print_nodes(%struct.tpool* @funk_functions_memory_pool)
  br label %66

53:                                               ; preds = %48
  %54 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %55 = call i32 @strncmp(i8* %54, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.51, i64 0, i64 0), i64 4)
  %56 = icmp ne i32 %55, 0
  br i1 %56, label %58, label %57

57:                                               ; preds = %53
  call void @funk_print_nodes(%struct.tpool* @funk_global_memory_pool)
  br label %65

58:                                               ; preds = %53
  %59 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %60 = call i32 @strncmp(i8* %59, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.52, i64 0, i64 0), i64 2)
  %61 = icmp ne i32 %60, 0
  br i1 %61, label %64, label %62

62:                                               ; preds = %58
  call void @funk_print_node_info(%struct.tnode* @gRenderLoopState)
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
  call void @print_scalar(%struct.tnode* @gRenderLoopState)
  br label %64

64:                                               ; preds = %62, %58
  br label %65

65:                                               ; preds = %64, %57
  br label %66

66:                                               ; preds = %65, %52
  br label %67

67:                                               ; preds = %66
  br label %68

68:                                               ; preds = %67, %42
  br label %69

69:                                               ; preds = %68, %37
  br label %70

70:                                               ; preds = %69, %28
  br label %71

71:                                               ; preds = %70
  %72 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %73 = call i32 @strncmp(i8* %72, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.53, i64 0, i64 0), i64 1)
  %74 = icmp ne i32 %73, 0
  br i1 %74, label %75, label %79

75:                                               ; preds = %71
  %76 = getelementptr inbounds [8 x i8], [8 x i8]* %3, i64 0, i64 0
  %77 = call i32 @strncmp(i8* %76, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.48, i64 0, i64 0), i64 1)
  %78 = icmp ne i32 %77, 0
  br label %79

79:                                               ; preds = %75, %71
  %80 = phi i1 [ false, %71 ], [ %78, %75 ]
  br i1 %80, label %20, label %81

81:                                               ; preds = %15, %79
  ret void
}

declare i8* @fgets(i8*, i32, %struct.__sFILE*) #1

declare i32 @strncmp(i8*, i8*, i64) #1

declare i32 @scanf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_scalar(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %6 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %11

8:                                                ; preds = %1
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.63, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.print_scalar, i64 0, i64 0))
  %10 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_print_node_info(%struct.tnode* %10)
  br label %11

11:                                               ; preds = %8, %1
  %12 = load %struct.tnode*, %struct.tnode** %2, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 3
  %14 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %13, i32 0, i32 0
  %15 = load i32, i32* %14, align 8
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %25

17:                                               ; preds = %11
  %18 = load %struct.tnode*, %struct.tnode** %2, align 8
  %19 = call %struct.tdata* @get_node(%struct.tnode* %18, i32 0)
  %20 = bitcast %struct.tdata* %19 to { i8, i64 }*
  %21 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %20, i32 0, i32 0
  %22 = load i8, i8* %21, align 8
  %23 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %20, i32 0, i32 1
  %24 = load i64, i64* %23, align 8
  call void @funk_print_scalar_element(i8 %22, i64 %24)
  br label %125

25:                                               ; preds = %11
  %26 = load %struct.tnode*, %struct.tnode** %2, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 3
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 0
  %29 = load i32, i32* %28, align 8
  %30 = icmp eq i32 %29, 1
  br i1 %30, label %31, label %51

31:                                               ; preds = %25
  store i32 0, i32* %3, align 4
  br label %32

32:                                               ; preds = %47, %31
  %33 = load i32, i32* %3, align 4
  %34 = load %struct.tnode*, %struct.tnode** %2, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 1
  %36 = load i32, i32* %35, align 4
  %37 = icmp ult i32 %33, %36
  br i1 %37, label %38, label %50

38:                                               ; preds = %32
  %39 = load %struct.tnode*, %struct.tnode** %2, align 8
  %40 = load i32, i32* %3, align 4
  %41 = call %struct.tdata* @get_node(%struct.tnode* %39, i32 %40)
  %42 = bitcast %struct.tdata* %41 to { i8, i64 }*
  %43 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %42, i32 0, i32 0
  %44 = load i8, i8* %43, align 8
  %45 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %42, i32 0, i32 1
  %46 = load i64, i64* %45, align 8
  call void @funk_print_scalar_element(i8 %44, i64 %46)
  br label %47

47:                                               ; preds = %38
  %48 = load i32, i32* %3, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, i32* %3, align 4
  br label %32

50:                                               ; preds = %32
  br label %124

51:                                               ; preds = %25
  %52 = load %struct.tnode*, %struct.tnode** %2, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 3
  %54 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %53, i32 0, i32 0
  %55 = load i32, i32* %54, align 8
  %56 = icmp eq i32 %55, 2
  br i1 %56, label %57, label %114

57:                                               ; preds = %51
  %58 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.64, i64 0, i64 0))
  %59 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_print_node_info(%struct.tnode* %59)
  %60 = load %struct.tnode*, %struct.tnode** %2, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 3
  %62 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %61, i32 0, i32 1
  %63 = getelementptr inbounds [2 x i32], [2 x i32]* %62, i64 0, i64 0
  %64 = load i32, i32* %63, align 4
  %65 = load %struct.tnode*, %struct.tnode** %2, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 3
  %67 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %66, i32 0, i32 1
  %68 = getelementptr inbounds [2 x i32], [2 x i32]* %67, i64 0, i64 1
  %69 = load i32, i32* %68, align 4
  %70 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.65, i64 0, i64 0), i32 %64, i32 %69)
  store i32 0, i32* %4, align 4
  br label %71

71:                                               ; preds = %110, %57
  %72 = load i32, i32* %4, align 4
  %73 = load %struct.tnode*, %struct.tnode** %2, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 3
  %75 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %74, i32 0, i32 1
  %76 = getelementptr inbounds [2 x i32], [2 x i32]* %75, i64 0, i64 1
  %77 = load i32, i32* %76, align 4
  %78 = icmp ult i32 %72, %77
  br i1 %78, label %79, label %113

79:                                               ; preds = %71
  store i32 0, i32* %5, align 4
  br label %80

80:                                               ; preds = %105, %79
  %81 = load i32, i32* %5, align 4
  %82 = load %struct.tnode*, %struct.tnode** %2, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 3
  %84 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %83, i32 0, i32 1
  %85 = getelementptr inbounds [2 x i32], [2 x i32]* %84, i64 0, i64 0
  %86 = load i32, i32* %85, align 4
  %87 = icmp ult i32 %81, %86
  br i1 %87, label %88, label %108

88:                                               ; preds = %80
  %89 = load %struct.tnode*, %struct.tnode** %2, align 8
  %90 = load i32, i32* %4, align 4
  %91 = load %struct.tnode*, %struct.tnode** %2, align 8
  %92 = getelementptr inbounds %struct.tnode, %struct.tnode* %91, i32 0, i32 3
  %93 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %92, i32 0, i32 1
  %94 = getelementptr inbounds [2 x i32], [2 x i32]* %93, i64 0, i64 0
  %95 = load i32, i32* %94, align 4
  %96 = mul i32 %90, %95
  %97 = load i32, i32* %5, align 4
  %98 = add i32 %96, %97
  %99 = call %struct.tdata* @get_node(%struct.tnode* %89, i32 %98)
  %100 = bitcast %struct.tdata* %99 to { i8, i64 }*
  %101 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %100, i32 0, i32 0
  %102 = load i8, i8* %101, align 8
  %103 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %100, i32 0, i32 1
  %104 = load i64, i64* %103, align 8
  call void @funk_print_scalar_element(i8 %102, i64 %104)
  br label %105

105:                                              ; preds = %88
  %106 = load i32, i32* %5, align 4
  %107 = add nsw i32 %106, 1
  store i32 %107, i32* %5, align 4
  br label %80

108:                                              ; preds = %80
  %109 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
  br label %110

110:                                              ; preds = %108
  %111 = load i32, i32* %4, align 4
  %112 = add nsw i32 %111, 1
  store i32 %112, i32* %4, align 4
  br label %71

113:                                              ; preds = %71
  br label %123

114:                                              ; preds = %51
  %115 = load %struct.tnode*, %struct.tnode** %2, align 8
  %116 = getelementptr inbounds %struct.tnode, %struct.tnode* %115, i32 0, i32 3
  %117 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %116, i32 0, i32 0
  %118 = load i32, i32* %117, align 8
  %119 = load %struct.tnode*, %struct.tnode** %2, align 8
  %120 = getelementptr inbounds %struct.tnode, %struct.tnode* %119, i32 0, i32 1
  %121 = load i32, i32* %120, align 4
  %122 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.66, i64 0, i64 0), i32 %118, i32 %121)
  br label %123

123:                                              ; preds = %114, %113
  br label %124

124:                                              ; preds = %123, %50
  br label %125

125:                                              ; preds = %124, %17
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @foo() #0 {
  %1 = alloca %struct.tnode, align 8
  %2 = alloca i8, align 1
  %3 = alloca i32, align 4
  call void @funk_get_node_type(%struct.tnode* %1, i32 0, i8* %2)
  %4 = load i8, i8* %2, align 1
  %5 = zext i8 %4 to i32
  store i32 %5, i32* %3, align 4
  ret void
}

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
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__.funk_memcp_arr, i64 0, i64 0))
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
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @__FUNCTION__.funk_memcp_arr, i64 0, i64 0))
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
  %18 = select i1 %16, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0)
  %19 = load %struct.tnode*, %struct.tnode** %9, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = load i32, i32* %10, align 4
  %23 = add i32 %21, %22
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.54, i64 0, i64 0), i8* %18, i32 %23)
  %25 = load %struct.tnode*, %struct.tnode** %9, align 8
  %26 = load i32, i32* %10, align 4
  %27 = call %struct.tdata* @get_node(%struct.tnode* %25, i32 %26)
  %28 = bitcast %struct.tdata* %27 to { i8, i64 }*
  %29 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %28, i32 0, i32 0
  %30 = load i8, i8* %29, align 8
  %31 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %28, i32 0, i32 1
  %32 = load i64, i64* %31, align 8
  call void @funk_print_scalar_element(i8 %30, i64 %32)
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.55, i64 0, i64 0))
  %34 = load %struct.tnode*, %struct.tnode** %11, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 2
  %36 = load %struct.tpool*, %struct.tpool** %35, align 8
  %37 = icmp eq %struct.tpool* %36, @funk_global_memory_pool
  %38 = zext i1 %37 to i64
  %39 = select i1 %37, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0)
  %40 = load %struct.tnode*, %struct.tnode** %11, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 0
  %42 = load i32, i32* %41, align 8
  %43 = load i32, i32* %12, align 4
  %44 = add i32 %42, %43
  %45 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.54, i64 0, i64 0), i8* %39, i32 %44)
  %46 = load %struct.tnode*, %struct.tnode** %11, align 8
  %47 = load i32, i32* %12, align 4
  %48 = call %struct.tdata* @get_node(%struct.tnode* %46, i32 %47)
  %49 = bitcast %struct.tdata* %48 to { i8, i64 }*
  %50 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %49, i32 0, i32 0
  %51 = load i8, i8* %50, align 8
  %52 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %49, i32 0, i32 1
  %53 = load i64, i64* %52, align 8
  call void @funk_print_scalar_element(i8 %51, i64 %53)
  %54 = load %struct.tnode*, %struct.tnode** %7, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 2
  %56 = load %struct.tpool*, %struct.tpool** %55, align 8
  %57 = icmp eq %struct.tpool* %56, @funk_global_memory_pool
  %58 = zext i1 %57 to i64
  %59 = select i1 %57, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0)
  %60 = load %struct.tnode*, %struct.tnode** %7, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 0
  %62 = load i32, i32* %61, align 8
  %63 = load i32, i32* %8, align 4
  %64 = add i32 %62, %63
  %65 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.56, i64 0, i64 0), i8* %59, i32 %64)
  %66 = load %struct.tnode*, %struct.tnode** %7, align 8
  %67 = load i32, i32* %8, align 4
  %68 = call %struct.tdata* @get_node(%struct.tnode* %66, i32 %67)
  %69 = bitcast %struct.tdata* %68 to { i8, i64 }*
  %70 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %69, i32 0, i32 0
  %71 = load i8, i8* %70, align 8
  %72 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %69, i32 0, i32 1
  %73 = load i64, i64* %72, align 8
  call void @funk_print_scalar_element(i8 %71, i64 %73)
  %74 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.57, i64 0, i64 0))
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
define void @funk_slt(i8*, i8*, i8*, i32) #0 {
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
  br i1 %10, label %11, label %24

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp olt double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = sitofp i32 %20 to double
  %22 = load i8*, i8** %5, align 8
  %23 = bitcast i8* %22 to double*
  store double %21, double* %23, align 8
  br label %36

24:                                               ; preds = %4
  %25 = load i8*, i8** %6, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = load i8*, i8** %7, align 8
  %29 = bitcast i8* %28 to i32*
  %30 = load i32, i32* %29, align 4
  %31 = icmp slt i32 %27, %30
  %32 = zext i1 %31 to i64
  %33 = select i1 %31, i32 1, i32 0
  %34 = load i8*, i8** %5, align 8
  %35 = bitcast i8* %34 to i32*
  store i32 %33, i32* %35, align 4
  br label %36

36:                                               ; preds = %24, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sgt(i8*, i8*, i8*, i32) #0 {
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
  br i1 %10, label %11, label %24

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp ogt double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = sitofp i32 %20 to double
  %22 = load i8*, i8** %5, align 8
  %23 = bitcast i8* %22 to double*
  store double %21, double* %23, align 8
  br label %36

24:                                               ; preds = %4
  %25 = load i8*, i8** %6, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = load i8*, i8** %7, align 8
  %29 = bitcast i8* %28 to i32*
  %30 = load i32, i32* %29, align 4
  %31 = icmp sgt i32 %27, %30
  %32 = zext i1 %31 to i64
  %33 = select i1 %31, i32 1, i32 0
  %34 = load i8*, i8** %5, align 8
  %35 = bitcast i8* %34 to i32*
  store i32 %33, i32* %35, align 4
  br label %36

36:                                               ; preds = %24, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sge(i8*, i8*, i8*, i32) #0 {
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
  br i1 %10, label %11, label %24

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp oge double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = sitofp i32 %20 to double
  %22 = load i8*, i8** %5, align 8
  %23 = bitcast i8* %22 to double*
  store double %21, double* %23, align 8
  br label %36

24:                                               ; preds = %4
  %25 = load i8*, i8** %6, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = load i8*, i8** %7, align 8
  %29 = bitcast i8* %28 to i32*
  %30 = load i32, i32* %29, align 4
  %31 = icmp sge i32 %27, %30
  %32 = zext i1 %31 to i64
  %33 = select i1 %31, i32 1, i32 0
  %34 = load i8*, i8** %5, align 8
  %35 = bitcast i8* %34 to i32*
  store i32 %33, i32* %35, align 4
  br label %36

36:                                               ; preds = %24, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_eq(i8*, i8*, i8*, i32) #0 {
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
  br i1 %10, label %11, label %24

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp oeq double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = sitofp i32 %20 to double
  %22 = load i8*, i8** %5, align 8
  %23 = bitcast i8* %22 to double*
  store double %21, double* %23, align 8
  br label %36

24:                                               ; preds = %4
  %25 = load i8*, i8** %6, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = load i8*, i8** %7, align 8
  %29 = bitcast i8* %28 to i32*
  %30 = load i32, i32* %29, align 4
  %31 = icmp eq i32 %27, %30
  %32 = zext i1 %31 to i64
  %33 = select i1 %31, i32 1, i32 0
  %34 = load i8*, i8** %5, align 8
  %35 = bitcast i8* %34 to i32*
  store i32 %33, i32* %35, align 4
  br label %36

36:                                               ; preds = %24, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_ne(i8*, i8*, i8*, i32) #0 {
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
  br i1 %10, label %11, label %24

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast i8* %15 to double*
  %17 = load double, double* %16, align 8
  %18 = fcmp une double %14, %17
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = sitofp i32 %20 to double
  %22 = load i8*, i8** %5, align 8
  %23 = bitcast i8* %22 to double*
  store double %21, double* %23, align 8
  br label %36

24:                                               ; preds = %4
  %25 = load i8*, i8** %6, align 8
  %26 = bitcast i8* %25 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = load i8*, i8** %7, align 8
  %29 = bitcast i8* %28 to i32*
  %30 = load i32, i32* %29, align 4
  %31 = icmp ne i32 %27, %30
  %32 = zext i1 %31 to i64
  %33 = select i1 %31, i32 1, i32 0
  %34 = load i8*, i8** %5, align 8
  %35 = bitcast i8* %34 to i32*
  store i32 %33, i32* %35, align 4
  br label %36

36:                                               ; preds = %24, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_or(i8*, i8*, i8*, i32) #0 {
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
  br i1 %10, label %11, label %28

11:                                               ; preds = %4
  %12 = load i8*, i8** %6, align 8
  %13 = bitcast i8* %12 to double*
  %14 = load double, double* %13, align 8
  %15 = fcmp une double %14, 0.000000e+00
  br i1 %15, label %21, label %16

16:                                               ; preds = %11
  %17 = load i8*, i8** %7, align 8
  %18 = bitcast i8* %17 to double*
  %19 = load double, double* %18, align 8
  %20 = fcmp une double %19, 0.000000e+00
  br label %21

21:                                               ; preds = %16, %11
  %22 = phi i1 [ true, %11 ], [ %20, %16 ]
  %23 = zext i1 %22 to i64
  %24 = select i1 %22, i32 1, i32 0
  %25 = sitofp i32 %24 to double
  %26 = load i8*, i8** %5, align 8
  %27 = bitcast i8* %26 to double*
  store double %25, double* %27, align 8
  br label %44

28:                                               ; preds = %4
  %29 = load i8*, i8** %6, align 8
  %30 = bitcast i8* %29 to i32*
  %31 = load i32, i32* %30, align 4
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %38, label %33

33:                                               ; preds = %28
  %34 = load i8*, i8** %7, align 8
  %35 = bitcast i8* %34 to i32*
  %36 = load i32, i32* %35, align 4
  %37 = icmp ne i32 %36, 0
  br label %38

38:                                               ; preds = %33, %28
  %39 = phi i1 [ true, %28 ], [ %37, %33 ]
  %40 = zext i1 %39 to i64
  %41 = select i1 %39, i32 1, i32 0
  %42 = load i8*, i8** %5, align 8
  %43 = bitcast i8* %42 to i32*
  store i32 %41, i32* %43, align 4
  br label %44

44:                                               ; preds = %38, %21
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
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.58, i64 0, i64 0), i32 %26, i32 %29)
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
  %42 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.58, i64 0, i64 0), i32 %38, i32 %41)
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
  %54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.58, i64 0, i64 0), i32 %50, i32 %53)
  br label %55

55:                                               ; preds = %49, %43
  %56 = load %struct.tnode*, %struct.tnode** %10, align 8
  %57 = load i32, i32* %11, align 4
  %58 = call %struct.tdata* @get_node(%struct.tnode* %56, i32 %57)
  %59 = bitcast %struct.tdata* %15 to i8*
  %60 = bitcast %struct.tdata* %58 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %59, i8* align 8 %60, i64 16, i1 false)
  %61 = load %struct.tnode*, %struct.tnode** %12, align 8
  %62 = load i32, i32* %13, align 4
  %63 = call %struct.tdata* @get_node(%struct.tnode* %61, i32 %62)
  %64 = bitcast %struct.tdata* %16 to i8*
  %65 = bitcast %struct.tdata* %63 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %64, i8* align 8 %65, i64 16, i1 false)
  %66 = load %struct.tnode*, %struct.tnode** %8, align 8
  %67 = load i32, i32* %9, align 4
  %68 = call %struct.tdata* @get_node(%struct.tnode* %66, i32 %67)
  store %struct.tdata* %68, %struct.tdata** %17, align 8
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %70 = load i8, i8* %69, align 8
  store i8 %70, i8* %18, align 1
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 0
  %72 = load i8, i8* %71, align 8
  store i8 %72, i8* %19, align 1
  %73 = load i8, i8* %19, align 1
  %74 = zext i8 %73 to i32
  %75 = icmp eq i32 %74, 4
  br i1 %75, label %76, label %77

76:                                               ; preds = %55
  store i8 1, i8* %19, align 1
  br label %77

77:                                               ; preds = %76, %55
  %78 = load i8, i8* %18, align 1
  %79 = zext i8 %78 to i32
  %80 = icmp eq i32 %79, 4
  br i1 %80, label %81, label %82

81:                                               ; preds = %77
  store i8 1, i8* %18, align 1
  br label %82

82:                                               ; preds = %81, %77
  %83 = load i8, i8* %18, align 1
  %84 = zext i8 %83 to i32
  %85 = icmp eq i32 %84, 1
  br i1 %85, label %86, label %104

86:                                               ; preds = %82
  %87 = load i8, i8* %19, align 1
  %88 = zext i8 %87 to i32
  %89 = icmp eq i32 %88, 1
  br i1 %89, label %90, label %104

90:                                               ; preds = %86
  %91 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %92 = load %struct.tdata*, %struct.tdata** %17, align 8
  %93 = getelementptr inbounds %struct.tdata, %struct.tdata* %92, i32 0, i32 1
  %94 = bitcast %union.data_type* %93 to i32*
  %95 = bitcast i32* %94 to i8*
  %96 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %97 = bitcast %union.data_type* %96 to i32*
  %98 = bitcast i32* %97 to i8*
  %99 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
  %100 = bitcast %union.data_type* %99 to i32*
  %101 = bitcast i32* %100 to i8*
  call void %91(i8* %95, i8* %98, i8* %101, i32 0)
  %102 = load %struct.tdata*, %struct.tdata** %17, align 8
  %103 = getelementptr inbounds %struct.tdata, %struct.tdata* %102, i32 0, i32 0
  store i8 1, i8* %103, align 8
  br label %181

104:                                              ; preds = %86, %82
  %105 = load i8, i8* %18, align 1
  %106 = zext i8 %105 to i32
  %107 = icmp eq i32 %106, 2
  br i1 %107, label %108, label %126

108:                                              ; preds = %104
  %109 = load i8, i8* %19, align 1
  %110 = zext i8 %109 to i32
  %111 = icmp eq i32 %110, 2
  br i1 %111, label %112, label %126

112:                                              ; preds = %108
  %113 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %114 = load %struct.tdata*, %struct.tdata** %17, align 8
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 1
  %116 = bitcast %union.data_type* %115 to double*
  %117 = bitcast double* %116 to i8*
  %118 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %119 = bitcast %union.data_type* %118 to double*
  %120 = bitcast double* %119 to i8*
  %121 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
  %122 = bitcast %union.data_type* %121 to double*
  %123 = bitcast double* %122 to i8*
  call void %113(i8* %117, i8* %120, i8* %123, i32 1)
  %124 = load %struct.tdata*, %struct.tdata** %17, align 8
  %125 = getelementptr inbounds %struct.tdata, %struct.tdata* %124, i32 0, i32 0
  store i8 2, i8* %125, align 8
  br label %180

126:                                              ; preds = %108, %104
  %127 = load i8, i8* %18, align 1
  %128 = zext i8 %127 to i32
  %129 = icmp eq i32 %128, 2
  br i1 %129, label %130, label %148

130:                                              ; preds = %126
  %131 = load i8, i8* %19, align 1
  %132 = zext i8 %131 to i32
  %133 = icmp eq i32 %132, 1
  br i1 %133, label %134, label %148

134:                                              ; preds = %130
  %135 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %136 = load %struct.tdata*, %struct.tdata** %17, align 8
  %137 = getelementptr inbounds %struct.tdata, %struct.tdata* %136, i32 0, i32 1
  %138 = bitcast %union.data_type* %137 to double*
  %139 = bitcast double* %138 to i8*
  %140 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %141 = bitcast %union.data_type* %140 to double*
  %142 = bitcast double* %141 to i8*
  %143 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
  %144 = bitcast %union.data_type* %143 to i32*
  %145 = bitcast i32* %144 to i8*
  call void %135(i8* %139, i8* %142, i8* %145, i32 1)
  %146 = load %struct.tdata*, %struct.tdata** %17, align 8
  %147 = getelementptr inbounds %struct.tdata, %struct.tdata* %146, i32 0, i32 0
  store i8 2, i8* %147, align 8
  br label %179

148:                                              ; preds = %130, %126
  %149 = load i8, i8* %18, align 1
  %150 = zext i8 %149 to i32
  %151 = icmp eq i32 %150, 1
  br i1 %151, label %152, label %170

152:                                              ; preds = %148
  %153 = load i8, i8* %19, align 1
  %154 = zext i8 %153 to i32
  %155 = icmp eq i32 %154, 2
  br i1 %155, label %156, label %170

156:                                              ; preds = %152
  %157 = load void (i8*, i8*, i8*, i32)*, void (i8*, i8*, i8*, i32)** %14, align 8
  %158 = load %struct.tdata*, %struct.tdata** %17, align 8
  %159 = getelementptr inbounds %struct.tdata, %struct.tdata* %158, i32 0, i32 1
  %160 = bitcast %union.data_type* %159 to double*
  %161 = bitcast double* %160 to i8*
  %162 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %163 = bitcast %union.data_type* %162 to i32*
  %164 = bitcast i32* %163 to i8*
  %165 = getelementptr inbounds %struct.tdata, %struct.tdata* %16, i32 0, i32 1
  %166 = bitcast %union.data_type* %165 to double*
  %167 = bitcast double* %166 to i8*
  call void %157(i8* %161, i8* %164, i8* %167, i32 1)
  %168 = load %struct.tdata*, %struct.tdata** %17, align 8
  %169 = getelementptr inbounds %struct.tdata, %struct.tdata* %168, i32 0, i32 0
  store i8 2, i8* %169, align 8
  br label %178

170:                                              ; preds = %152, %148
  %171 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.59, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0))
  %172 = load i8, i8* %18, align 1
  call void @funk_print_type(i8 zeroext %172)
  %173 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.55, i64 0, i64 0))
  %174 = load i8, i8* %19, align 1
  call void @funk_print_type(i8 zeroext %174)
  %175 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
  %176 = load %struct.tdata*, %struct.tdata** %17, align 8
  %177 = getelementptr inbounds %struct.tdata, %struct.tdata* %176, i32 0, i32 0
  store i8 0, i8* %177, align 8
  br label %178

178:                                              ; preds = %170, %156
  br label %179

179:                                              ; preds = %178, %134
  br label %180

180:                                              ; preds = %179, %112
  br label %181

181:                                              ; preds = %180, %90
  %182 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %183 = icmp ne i32 %182, 0
  br i1 %183, label %184, label %191

184:                                              ; preds = %181
  %185 = load %struct.tnode*, %struct.tnode** %8, align 8
  %186 = load i32, i32* %9, align 4
  %187 = load %struct.tnode*, %struct.tnode** %10, align 8
  %188 = load i32, i32* %11, align 4
  %189 = load %struct.tnode*, %struct.tnode** %12, align 8
  %190 = load i32, i32* %13, align 4
  call void @debug_print_arith_operation(%struct.tnode* %185, i32 %186, %struct.tnode* %187, i32 %188, %struct.tnode* %189, i32 %190)
  br label %191

191:                                              ; preds = %184, %181
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
define void @funk_or_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
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
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_or)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_ne_rr(%struct.tnode*, i32, %struct.tnode*, i32, %struct.tnode*, i32) #0 {
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
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %17, i32 %18, void (i8*, i8*, i8*, i32)* @funk_ne)
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
define void @funk_sub_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_sub)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_add)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_div)
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
define void @funk_slt_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_slt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sgt_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_sgt)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sge_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_sge)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_eq_ri(%struct.tnode*, i32, %struct.tnode*, i32, i32) #0 {
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode, align 8
  store %struct.tnode* %0, %struct.tnode** %6, align 8
  store i32 %1, i32* %7, align 4
  store %struct.tnode* %2, %struct.tnode** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load i32, i32* %10, align 4
  call void @funk_create_int_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %11, i32 %12)
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = load i32, i32* %9, align 4
  call void @funk_arith_op_rr(%struct.tnode* %13, i32 %14, %struct.tnode* %15, i32 %16, %struct.tnode* %11, i32 0, void (i8*, i8*, i8*, i32)* @funk_eq)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_dimension(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.60, i64 0, i64 0))
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
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.61, i64 0, i64 0), i32 %19)
  br label %21

21:                                               ; preds = %12
  %22 = load i32, i32* %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %3, align 4
  br label %5

24:                                               ; preds = %5
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.62, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_2d_array_element_reg_reg(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_print_node_info(%struct.tnode* %9)
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 3
  %12 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %11, i32 0, i32 0
  %13 = load i32, i32* %12, align 8
  %14 = icmp ne i32 %13, 2
  br i1 %14, label %15, label %21

15:                                               ; preds = %3
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 3
  %18 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %17, i32 0, i32 0
  %19 = load i32, i32* %18, align 8
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([65 x i8], [65 x i8]* @.str.67, i64 0, i64 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 %19)
  br label %21

21:                                               ; preds = %15, %3
  %22 = load %struct.tnode*, %struct.tnode** %5, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0)
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 1
  %25 = bitcast %union.data_type* %24 to i32*
  %26 = load i32, i32* %25, align 8
  store i32 %26, i32* %7, align 4
  %27 = load %struct.tnode*, %struct.tnode** %6, align 8
  %28 = call %struct.tdata* @get_node(%struct.tnode* %27, i32 0)
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 1
  %30 = bitcast %union.data_type* %29 to i32*
  %31 = load i32, i32* %30, align 8
  store i32 %31, i32* %8, align 4
  %32 = load i32, i32* %7, align 4
  %33 = load i32, i32* %8, align 4
  %34 = load %struct.tnode*, %struct.tnode** %4, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 3
  %36 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %35, i32 0, i32 1
  %37 = getelementptr inbounds [2 x i32], [2 x i32]* %36, i64 0, i64 1
  %38 = load i32, i32* %37, align 4
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.68, i64 0, i64 0), i32 %32, i32 %33, i32 %38)
  %40 = load %struct.tnode*, %struct.tnode** %4, align 8
  %41 = load %struct.tnode*, %struct.tnode** %4, align 8
  %42 = getelementptr inbounds %struct.tnode, %struct.tnode* %41, i32 0, i32 3
  %43 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %42, i32 0, i32 1
  %44 = getelementptr inbounds [2 x i32], [2 x i32]* %43, i64 0, i64 0
  %45 = load i32, i32* %44, align 4
  %46 = load i32, i32* %7, align 4
  %47 = mul i32 %45, %46
  %48 = load i32, i32* %8, align 4
  %49 = add i32 %47, %48
  %50 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 %49)
  %51 = bitcast %struct.tdata* %50 to { i8, i64 }*
  %52 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %51, i32 0, i32 0
  %53 = load i8, i8* %52, align 8
  %54 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %51, i32 0, i32 1
  %55 = load i64, i64* %54, align 8
  call void @funk_print_scalar_element(i8 %53, i64 %55)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_2d_array_element_int_int(%struct.tnode*, i32, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 3
  %10 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %9, i32 0, i32 1
  %11 = getelementptr inbounds [2 x i32], [2 x i32]* %10, i64 0, i64 0
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* %5, align 4
  %14 = mul i32 %12, %13
  %15 = load i32, i32* %6, align 4
  %16 = add i32 %14, %15
  %17 = call %struct.tdata* @get_node(%struct.tnode* %7, i32 %16)
  %18 = bitcast %struct.tdata* %17 to { i8, i64 }*
  %19 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %18, i32 0, i32 0
  %20 = load i8, i8* %19, align 8
  %21 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %18, i32 0, i32 1
  %22 = load i64, i64* %21, align 8
  call void @funk_print_scalar_element(i8 %20, i64 %22)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define float @funk_ToFloat(%struct.tnode*) #0 {
  %2 = alloca float, align 4
  %3 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  %4 = load %struct.tnode*, %struct.tnode** %3, align 8
  %5 = call %struct.tdata* @get_node(%struct.tnode* %4, i32 0)
  %6 = getelementptr inbounds %struct.tdata, %struct.tdata* %5, i32 0, i32 0
  %7 = load i8, i8* %6, align 8
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %17

10:                                               ; preds = %1
  %11 = load %struct.tnode*, %struct.tnode** %3, align 8
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0)
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 1
  %14 = bitcast %union.data_type* %13 to i32*
  %15 = load i32, i32* %14, align 8
  %16 = sitofp i32 %15 to float
  store float %16, float* %2, align 4
  br label %36

17:                                               ; preds = %1
  %18 = load %struct.tnode*, %struct.tnode** %3, align 8
  %19 = call %struct.tdata* @get_node(%struct.tnode* %18, i32 0)
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = zext i8 %21 to i32
  %23 = icmp eq i32 %22, 2
  br i1 %23, label %24, label %31

24:                                               ; preds = %17
  %25 = load %struct.tnode*, %struct.tnode** %3, align 8
  %26 = call %struct.tdata* @get_node(%struct.tnode* %25, i32 0)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
  %28 = bitcast %union.data_type* %27 to double*
  %29 = load double, double* %28, align 8
  %30 = fptrunc double %29 to float
  store float %30, float* %2, align 4
  br label %36

31:                                               ; preds = %17
  %32 = load %struct.tnode*, %struct.tnode** %3, align 8
  %33 = call %struct.tdata* @get_node(%struct.tnode* %32, i32 0)
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 0
  store i8 0, i8* %34, align 8
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.69, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0))
  call void @exit(i32 1) #4
  unreachable

36:                                               ; preds = %24, %10
  %37 = load float, float* %2, align 4
  ret float %37
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
  %11 = call %struct.__sFILE* @"\01_fopen"(i8* %10, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.70, i64 0, i64 0))
  store %struct.__sFILE* %11, %struct.__sFILE** %7, align 8
  %12 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %13 = icmp eq %struct.__sFILE* %12, null
  br i1 %13, label %14, label %17

14:                                               ; preds = %3
  %15 = load i8*, i8** %6, align 8
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.71, i64 0, i64 0), i8* %15)
  call void @exit(i32 1) #4
  unreachable

17:                                               ; preds = %3
  %18 = load i32, i32* @g_funk_verbosity, align 4
  %19 = icmp ugt i32 %18, 0
  br i1 %19, label %20, label %23

20:                                               ; preds = %17
  %21 = load i8*, i8** %6, align 8
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.72, i64 0, i64 0), i8* %21)
  br label %23

23:                                               ; preds = %20, %17
  store i32 0, i32* %8, align 4
  store i32 0, i32* %9, align 4
  %24 = load %struct.tpool*, %struct.tpool** %4, align 8
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 8
  %27 = load %struct.tnode*, %struct.tnode** %5, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 0
  store i32 %26, i32* %28, align 8
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 3
  %31 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %30, i32 0, i32 0
  store i32 1, i32* %31, align 8
  %32 = load %struct.tpool*, %struct.tpool** %4, align 8
  %33 = load %struct.tnode*, %struct.tnode** %5, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 2
  store %struct.tpool* %32, %struct.tpool** %34, align 8
  br label %35

35:                                               ; preds = %39, %23
  %36 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %37 = call i32 (%struct.__sFILE*, i8*, ...) @fscanf(%struct.__sFILE* %36, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.73, i64 0, i64 0), i32* %8)
  %38 = icmp eq i32 %37, 1
  br i1 %38, label %39, label %57

39:                                               ; preds = %35
  %40 = load i32, i32* %8, align 4
  %41 = load %struct.tnode*, %struct.tnode** %5, align 8
  %42 = load %struct.tpool*, %struct.tpool** %4, align 8
  %43 = getelementptr inbounds %struct.tpool, %struct.tpool* %42, i32 0, i32 1
  %44 = load i32, i32* %43, align 8
  %45 = call %struct.tdata* @get_node(%struct.tnode* %41, i32 %44)
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to i32*
  store i32 %40, i32* %47, align 8
  %48 = load %struct.tnode*, %struct.tnode** %5, align 8
  %49 = load %struct.tpool*, %struct.tpool** %4, align 8
  %50 = getelementptr inbounds %struct.tpool, %struct.tpool* %49, i32 0, i32 1
  %51 = load i32, i32* %50, align 8
  %52 = call %struct.tdata* @get_node(%struct.tnode* %48, i32 %51)
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 0
  store i8 1, i8* %53, align 8
  %54 = load %struct.tpool*, %struct.tpool** %4, align 8
  call void @funk_increment_pool_tail(%struct.tpool* %54, i32 1)
  %55 = load i32, i32* %9, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, i32* %9, align 4
  br label %35

57:                                               ; preds = %35
  %58 = load i32, i32* %9, align 4
  %59 = load %struct.tnode*, %struct.tnode** %5, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 1
  store i32 %58, i32* %60, align 4
  %61 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_debug_register_node(%struct.tnode* %61)
  %62 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %63 = call i32 @fclose(%struct.__sFILE* %62)
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
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0)
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 0
  %12 = load i8, i8* %11, align 8
  %13 = zext i8 %12 to i32
  %14 = icmp eq i32 %13, 4
  br i1 %14, label %15, label %16

15:                                               ; preds = %3
  br label %65

16:                                               ; preds = %3
  %17 = load i32, i32* %6, align 4
  %18 = load %struct.tnode*, %struct.tnode** %4, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 3
  %20 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %19, i32 0, i32 0
  store i32 %17, i32* %20, align 8
  store i32 1, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %21

21:                                               ; preds = %51, %16
  %22 = load i32, i32* %8, align 4
  %23 = load i32, i32* %6, align 4
  %24 = icmp slt i32 %22, %23
  br i1 %24, label %25, label %28

25:                                               ; preds = %21
  %26 = load i32, i32* %8, align 4
  %27 = icmp slt i32 %26, 2
  br label %28

28:                                               ; preds = %25, %21
  %29 = phi i1 [ false, %21 ], [ %27, %25 ]
  br i1 %29, label %30, label %54

30:                                               ; preds = %28
  %31 = load i32*, i32** %5, align 8
  %32 = load i32, i32* %8, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds i32, i32* %31, i64 %33
  %35 = load i32, i32* %34, align 4
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 3
  %38 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %37, i32 0, i32 1
  %39 = load i32, i32* %8, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [2 x i32], [2 x i32]* %38, i64 0, i64 %40
  store i32 %35, i32* %41, align 4
  %42 = load %struct.tnode*, %struct.tnode** %4, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 3
  %44 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %43, i32 0, i32 1
  %45 = load i32, i32* %8, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [2 x i32], [2 x i32]* %44, i64 0, i64 %46
  %48 = load i32, i32* %47, align 4
  %49 = load i32, i32* %7, align 4
  %50 = mul i32 %49, %48
  store i32 %50, i32* %7, align 4
  br label %51

51:                                               ; preds = %30
  %52 = load i32, i32* %8, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, i32* %8, align 4
  br label %21

54:                                               ; preds = %28
  %55 = load i32, i32* %7, align 4
  %56 = load %struct.tnode*, %struct.tnode** %4, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = load i32, i32* %57, align 4
  %59 = icmp ugt i32 %55, %58
  br i1 %59, label %60, label %65

60:                                               ; preds = %54
  %61 = load %struct.tnode*, %struct.tnode** %4, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 1
  %63 = load i32, i32* %62, align 4
  %64 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([66 x i8], [66 x i8]* @.str.74, i64 0, i64 0), i32 %63)
  br label %65

65:                                               ; preds = %15, %60, %54
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
