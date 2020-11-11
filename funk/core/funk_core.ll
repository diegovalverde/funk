; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.tnode = type { i32, i32, %struct.tpool*, %struct.tdimensions }
%struct.tpool = type { [1024 x %struct.tdata], i32 }
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
@g_funk_verbosity = global i32 0, align 4
@funk_sleep.first = internal global i32 1, align 4
@gRenderLoopState = common global %struct.tnode zeroinitializer, align 8
@.str = private unnamed_addr constant [43 x i8] c"-I- Setting conf parameter %d to value %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.2 = private unnamed_addr constant [24 x i8] c"-E- %s Invalid type %d\0A\00", align 1
@__FUNCTION__.funk_print_type = private unnamed_addr constant [16 x i8] c"funk_print_type\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"%s \00", align 1
@__FUNCTION__.funk_init = private unnamed_addr constant [10 x i8] c"funk_init\00", align 1
@funk_global_memory_pool = common global %struct.tpool zeroinitializer, align 8
@funk_functions_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str.4 = private unnamed_addr constant [39 x i8] c"===== FUNK Interactive debugger =====\0A\00", align 1
@.str.5 = private unnamed_addr constant [25 x i8] c"-I- Global pool size %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [26 x i8] c"-I- init_random_seed: %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [24 x i8] c"Press any key to start\0A\00", align 1
@__FUNCTION__.is_list_consecutive_in_memory = private unnamed_addr constant [30 x i8] c"is_list_consecutive_in_memory\00", align 1
@.str.8 = private unnamed_addr constant [50 x i8] c"-E- %s node lhs data type is %d but shall be int\0A\00", align 1
@__FUNCTION__.funk_create_list_slide_2d_var = private unnamed_addr constant [30 x i8] c"funk_create_list_slide_2d_var\00", align 1
@.str.9 = private unnamed_addr constant [14 x i8] c"%s i=%d j=%d\0A\00", align 1
@.str.10 = private unnamed_addr constant [42 x i8] c"-E- %s index %d out of array boundary %d\0A\00", align 1
@__FUNCTION__.funk_create_list_slide_1d_var = private unnamed_addr constant [30 x i8] c"funk_create_list_slide_1d_var\00", align 1
@.str.11 = private unnamed_addr constant [76 x i8] c"-E- %s the number of indexes provided %d does not match dimension count %d\0A\00", align 1
@__FUNCTION__.funk_create_list_slide = private unnamed_addr constant [23 x i8] c"funk_create_list_slide\00", align 1
@.str.12 = private unnamed_addr constant [56 x i8] c"-E- %s the index %d >  upper bound %d for dimension %d\0A\00", align 1
@.str.13 = private unnamed_addr constant [44 x i8] c"-E- %s %d dimensions are not yet supported\0A\00", align 1
@.str.14 = private unnamed_addr constant [41 x i8] c"-E- %s index %d out of range for len %d\0A\00", align 1
@__FUNCTION__.funk_create_list = private unnamed_addr constant [17 x i8] c"funk_create_list\00", align 1
@__FUNCTION__.funk_create_2d_matrix = private unnamed_addr constant [22 x i8] c"funk_create_2d_matrix\00", align 1
@.str.15 = private unnamed_addr constant [27 x i8] c">>>>> %d %d pool_tail: %d\0A\00", align 1
@.str.16 = private unnamed_addr constant [16 x i8] c"%s %s[%d] = %d\0A\00", align 1
@__FUNCTION__.funk_create_int_scalar = private unnamed_addr constant [23 x i8] c"funk_create_int_scalar\00", align 1
@.str.17 = private unnamed_addr constant [6 x i8] c"gpool\00", align 1
@.str.18 = private unnamed_addr constant [6 x i8] c"fpool\00", align 1
@__FUNCTION__.funk_create_list_int_literal = private unnamed_addr constant [29 x i8] c"funk_create_list_int_literal\00", align 1
@__FUNCTION__.funk_create_2d_matrix_int_literal = private unnamed_addr constant [34 x i8] c"funk_create_2d_matrix_int_literal\00", align 1
@__FUNCTION__.funk_copy_element_from_pool = private unnamed_addr constant [28 x i8] c"funk_copy_element_from_pool\00", align 1
@.str.19 = private unnamed_addr constant [38 x i8] c"-E- Indexes %d, %d are out of bounds\0A\00", align 1
@.str.20 = private unnamed_addr constant [6 x i8] c" %5d \00", align 1
@.str.21 = private unnamed_addr constant [8 x i8] c" %5.5f \00", align 1
@.str.22 = private unnamed_addr constant [6 x i8] c" %5s \00", align 1
@.str.23 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str.24 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.25 = private unnamed_addr constant [10 x i8] c"%s %s[%d]\00", align 1
@__FUNCTION__.funk_get_node_type = private unnamed_addr constant [19 x i8] c"funk_get_node_type\00", align 1
@.str.26 = private unnamed_addr constant [43 x i8] c"-E- %s: offset %d out of bounds for len %d\00", align 1
@.str.27 = private unnamed_addr constant [3 x i8] c"\0A \00", align 1
@__FUNCTION__.funk_set_node_type = private unnamed_addr constant [19 x i8] c"funk_set_node_type\00", align 1
@__FUNCTION__.funk_set_node_value_int = private unnamed_addr constant [24 x i8] c"funk_set_node_value_int\00", align 1
@.str.28 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.29 = private unnamed_addr constant [25 x i8] c"%s %s start: %d len: %d\0A\00", align 1
@__FUNCTION__.funk_get_next_node = private unnamed_addr constant [19 x i8] c"funk_get_next_node\00", align 1
@funk_debug_function_entry_hook.run_until_the_end = internal global i32 0, align 4
@.str.30 = private unnamed_addr constant [38 x i8] c"Stopped at the beginning of function\0A\00", align 1
@.str.31 = private unnamed_addr constant [2 x i8] c">\00", align 1
@__stdinp = external global %struct.__sFILE*, align 8
@.str.32 = private unnamed_addr constant [7 x i8] c"nostop\00", align 1
@.str.33 = private unnamed_addr constant [2 x i8] c"q\00", align 1
@.str.34 = private unnamed_addr constant [2 x i8] c"c\00", align 1
@.str.35 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.36 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.37 = private unnamed_addr constant [10 x i8] c" = %s[%d]\00", align 1
@.str.38 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
@__FUNCTION__.funk_add_ri = private unnamed_addr constant [12 x i8] c"funk_add_ri\00", align 1
@.str.39 = private unnamed_addr constant [54 x i8] c"-E- Invalid index %d is greater than array size of %d\00", align 1
@.str.40 = private unnamed_addr constant [34 x i8] c"-E- funk_mul_rr: invalid types:\0A \00", align 1
@.str.41 = private unnamed_addr constant [8 x i8] c"lit(%d)\00", align 1
@__FUNCTION__.funk_add_rr = private unnamed_addr constant [12 x i8] c"funk_add_rr\00", align 1
@.str.42 = private unnamed_addr constant [24 x i8] c"-E- %s: invalid types: \00", align 1
@.str.43 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.44 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.45 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.46 = private unnamed_addr constant [9 x i8] c" [...] \0A\00", align 1
@.str.47 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.48 = private unnamed_addr constant [30 x i8] c"-E- File '%s' cannot be read\0A\00", align 1
@.str.49 = private unnamed_addr constant [21 x i8] c"-D- Opened file '%s'\00", align 1
@.str.50 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.51 = private unnamed_addr constant [15 x i8] c"pool[%d] = %d\0A\00", align 1
@.str.52 = private unnamed_addr constant [13 x i8] c"node: %d %d\0A\00", align 1
@.str.53 = private unnamed_addr constant [14 x i8] c"%d:[%d x %d]\0A\00", align 1
@.str.54 = private unnamed_addr constant [66 x i8] c"-E- reshape operation not possible for variable with %d elements\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sleep(i32) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* @funk_sleep.first, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %1
  store i32 0, i32* @funk_sleep.first, align 4
  br label %9

; <label>:6:                                      ; preds = %1
  %7 = load i32, i32* %2, align 4
  %8 = call i32 @"\01_sleep"(i32 %7)
  br label %9

; <label>:9:                                      ; preds = %6, %5
  ret void
}

declare i32 @"\01_sleep"(i32) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @set_s2d_user_global_state(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = bitcast %struct.tnode* %3 to i8*
  call void @memcpy(i8* bitcast (%struct.tnode* @gRenderLoopState to i8*), i8* %4, i64 32, i32 8, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @memcpy(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @get_s2d_user_global_state(%struct.tnode* noalias sret) #0 {
  %2 = bitcast %struct.tnode* %0 to i8*
  call void @memcpy(i8* %2, i8* bitcast (%struct.tnode* @gRenderLoopState to i8*), i64 32, i32 8, i1 false)
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
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str, i32 0, i32 0), i32 %5, i32 %6)
  %8 = load i32, i32* %3, align 4
  switch i32 %8, label %14 [
    i32 0, label %9
    i32 1, label %11
  ]

; <label>:9:                                      ; preds = %2
  %10 = load i32, i32* %4, align 4
  store i32 %10, i32* @g_funk_verbosity, align 4
  br label %14

; <label>:11:                                     ; preds = %2
  %12 = load i32, i32* %4, align 4
  store i32 %12, i32* @g_funk_print_array_max_elements, align 4
  br label %14
                                                  ; No predecessors!
  br label %14

; <label>:14:                                     ; preds = %2, %13, %11, %9
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_type(i8 zeroext) #0 {
  %2 = alloca i8, align 1
  store i8 %0, i8* %2, align 1
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i32
  %5 = icmp sge i32 %4, 0
  br i1 %5, label %6, label %16

; <label>:6:                                      ; preds = %1
  %7 = load i8, i8* %2, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp slt i32 %8, 7
  br i1 %9, label %10, label %16

; <label>:10:                                     ; preds = %6
  %11 = load i8, i8* %2, align 1
  %12 = zext i8 %11 to i64
  %13 = getelementptr inbounds [7 x [100 x i8]], [7 x [100 x i8]]* @funk_types_str, i64 0, i64 %12
  %14 = getelementptr inbounds [100 x i8], [100 x i8]* %13, i32 0, i32 0
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i32 0, i32 0), i8* %14)
  br label %20

; <label>:16:                                     ; preds = %6, %1
  %17 = load i8, i8* %2, align 1
  %18 = zext i8 %17 to i32
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_type, i32 0, i32 0), i32 %18)
  br label %20

; <label>:20:                                     ; preds = %16, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_init() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.funk_init, i32 0, i32 0))
  %4 = call i64 @time(i64* null)
  %5 = trunc i64 %4 to i32
  store i32 %5, i32* %1, align 4
  %6 = load i32, i32* %1, align 4
  call void @srand(i32 %6)
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 1), align 8
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 1), align 8
  store i32 0, i32* %2, align 4
  br label %7

; <label>:7:                                      ; preds = %16, %0
  %8 = load i32, i32* %2, align 4
  %9 = icmp slt i32 %8, 1024
  br i1 %9, label %10, label %19

; <label>:10:                                     ; preds = %7
  %11 = load i32, i32* %2, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 0), i64 0, i64 %12
  %14 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %15 = bitcast %union.data_type* %14 to i32*
  store i32 0, i32* %15, align 8
  br label %16

; <label>:16:                                     ; preds = %10
  %17 = load i32, i32* %2, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, i32* %2, align 4
  br label %7

; <label>:19:                                     ; preds = %7
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.4, i32 0, i32 0))
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.5, i32 0, i32 0), i32 1024)
  %22 = load i32, i32* %1, align 4
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.6, i32 0, i32 0), i32 %22)
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.7, i32 0, i32 0))
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

; <label>:11:                                     ; preds = %2
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.is_list_consecutive_in_memory, i32 0, i32 0))
  br label %13

; <label>:13:                                     ; preds = %11, %2
  %14 = load i32, i32* %5, align 4
  %15 = icmp sle i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16:                                     ; preds = %13
  store i32 1, i32* %3, align 4
  br label %43

; <label>:17:                                     ; preds = %13
  %18 = load %struct.tnode*, %struct.tnode** %4, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i64 0
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  store i32 %21, i32* %6, align 4
  store i32 1, i32* %7, align 4
  br label %22

; <label>:22:                                     ; preds = %39, %17
  %23 = load i32, i32* %7, align 4
  %24 = load i32, i32* %5, align 4
  %25 = icmp slt i32 %23, %24
  br i1 %25, label %26, label %42

; <label>:26:                                     ; preds = %22
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

; <label>:37:                                     ; preds = %26
  store i32 0, i32* %3, align 4
  br label %43

; <label>:38:                                     ; preds = %26
  br label %39

; <label>:39:                                     ; preds = %38
  %40 = load i32, i32* %7, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %7, align 4
  br label %22

; <label>:42:                                     ; preds = %22
  store i32 0, i32* %3, align 4
  br label %43

; <label>:43:                                     ; preds = %42, %37, %16
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

; <label>:24:                                     ; preds = %4
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
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.8, i32 0, i32 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i32 0, i32 0), i32 %36)
  br label %38

; <label>:38:                                     ; preds = %24, %4
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

; <label>:52:                                     ; preds = %38
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
  %65 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.8, i32 0, i32 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i32 0, i32 0), i32 %64)
  br label %66

; <label>:66:                                     ; preds = %52, %38
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
  %92 = load i32, i32* %10, align 4
  %93 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.9, i32 0, i32 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i32 0, i32 0), i32 %91, i32 %92)
  %94 = load i32, i32* %9, align 4
  %95 = icmp slt i32 %94, 0
  br i1 %95, label %96, label %104

; <label>:96:                                     ; preds = %66
  %97 = load %struct.tnode*, %struct.tnode** %5, align 8
  %98 = getelementptr inbounds %struct.tnode, %struct.tnode* %97, i32 0, i32 3
  %99 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %98, i32 0, i32 1
  %100 = getelementptr inbounds [2 x i32], [2 x i32]* %99, i64 0, i64 0
  %101 = load i32, i32* %100, align 4
  %102 = load i32, i32* %9, align 4
  %103 = sub i32 %101, %102
  br label %106

; <label>:104:                                    ; preds = %66
  %105 = load i32, i32* %9, align 4
  br label %106

; <label>:106:                                    ; preds = %104, %96
  %107 = phi i32 [ %103, %96 ], [ %105, %104 ]
  store i32 %107, i32* %9, align 4
  %108 = load i32, i32* %10, align 4
  %109 = icmp slt i32 %108, 0
  br i1 %109, label %110, label %118

; <label>:110:                                    ; preds = %106
  %111 = load %struct.tnode*, %struct.tnode** %5, align 8
  %112 = getelementptr inbounds %struct.tnode, %struct.tnode* %111, i32 0, i32 3
  %113 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %112, i32 0, i32 1
  %114 = getelementptr inbounds [2 x i32], [2 x i32]* %113, i64 0, i64 1
  %115 = load i32, i32* %114, align 4
  %116 = load i32, i32* %10, align 4
  %117 = sub i32 %115, %116
  br label %120

; <label>:118:                                    ; preds = %106
  %119 = load i32, i32* %10, align 4
  br label %120

; <label>:120:                                    ; preds = %118, %110
  %121 = phi i32 [ %117, %110 ], [ %119, %118 ]
  store i32 %121, i32* %10, align 4
  %122 = load i32, i32* %9, align 4
  %123 = load %struct.tnode*, %struct.tnode** %5, align 8
  %124 = getelementptr inbounds %struct.tnode, %struct.tnode* %123, i32 0, i32 3
  %125 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %124, i32 0, i32 1
  %126 = getelementptr inbounds [2 x i32], [2 x i32]* %125, i64 0, i64 0
  %127 = load i32, i32* %126, align 4
  %128 = icmp uge i32 %122, %127
  br i1 %128, label %129, label %137

; <label>:129:                                    ; preds = %120
  %130 = load i32, i32* %9, align 4
  %131 = load %struct.tnode*, %struct.tnode** %5, align 8
  %132 = getelementptr inbounds %struct.tnode, %struct.tnode* %131, i32 0, i32 3
  %133 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %132, i32 0, i32 1
  %134 = getelementptr inbounds [2 x i32], [2 x i32]* %133, i64 0, i64 0
  %135 = load i32, i32* %134, align 4
  %136 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i32 0, i32 0), i32 %130, i32 %135)
  br label %137

; <label>:137:                                    ; preds = %129, %120
  %138 = load i32, i32* %10, align 4
  %139 = load %struct.tnode*, %struct.tnode** %5, align 8
  %140 = getelementptr inbounds %struct.tnode, %struct.tnode* %139, i32 0, i32 3
  %141 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %140, i32 0, i32 1
  %142 = getelementptr inbounds [2 x i32], [2 x i32]* %141, i64 0, i64 1
  %143 = load i32, i32* %142, align 4
  %144 = icmp uge i32 %138, %143
  br i1 %144, label %145, label %153

; <label>:145:                                    ; preds = %137
  %146 = load i32, i32* %10, align 4
  %147 = load %struct.tnode*, %struct.tnode** %5, align 8
  %148 = getelementptr inbounds %struct.tnode, %struct.tnode* %147, i32 0, i32 3
  %149 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %148, i32 0, i32 1
  %150 = getelementptr inbounds [2 x i32], [2 x i32]* %149, i64 0, i64 1
  %151 = load i32, i32* %150, align 4
  %152 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i32 0, i32 0), i32 %146, i32 %151)
  br label %153

; <label>:153:                                    ; preds = %145, %137
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

; <label>:21:                                     ; preds = %3
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
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.8, i32 0, i32 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_1d_var, i32 0, i32 0), i32 %33)
  br label %35

; <label>:35:                                     ; preds = %21, %3
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

; <label>:50:                                     ; preds = %35
  %51 = load %struct.tnode*, %struct.tnode** %5, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 3
  %53 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %52, i32 0, i32 1
  %54 = getelementptr inbounds [2 x i32], [2 x i32]* %53, i64 0, i64 0
  %55 = load i32, i32* %54, align 4
  %56 = load i32, i32* %7, align 4
  %57 = sub i32 %55, %56
  br label %60

; <label>:58:                                     ; preds = %35
  %59 = load i32, i32* %7, align 4
  br label %60

; <label>:60:                                     ; preds = %58, %50
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

; <label>:69:                                     ; preds = %60
  %70 = load i32, i32* %7, align 4
  %71 = load %struct.tnode*, %struct.tnode** %4, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 3
  %73 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %72, i32 0, i32 1
  %74 = getelementptr inbounds [2 x i32], [2 x i32]* %73, i64 0, i64 0
  %75 = load i32, i32* %74, align 4
  %76 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_1d_var, i32 0, i32 0), i32 %70, i32 %75)
  br label %77

; <label>:77:                                     ; preds = %69, %60
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

; <label>:16:                                     ; preds = %4
  %17 = load i32, i32* %8, align 4
  %18 = load %struct.tnode*, %struct.tnode** %6, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 3
  %20 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([76 x i8], [76 x i8]* @.str.11, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i32 0, i32 0), i32 %17, i32 %21)
  br label %23

; <label>:23:                                     ; preds = %16, %4
  store i32 0, i32* %9, align 4
  br label %24

; <label>:24:                                     ; preds = %58, %23
  %25 = load i32, i32* %9, align 4
  %26 = load i32, i32* %8, align 4
  %27 = icmp slt i32 %25, %26
  br i1 %27, label %28, label %61

; <label>:28:                                     ; preds = %24
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

; <label>:42:                                     ; preds = %28
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
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.12, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i32 0, i32 0), i32 %47, i32 %54, i32 %55)
  br label %57

; <label>:57:                                     ; preds = %42, %28
  br label %58

; <label>:58:                                     ; preds = %57
  %59 = load i32, i32* %9, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, i32* %9, align 4
  br label %24

; <label>:61:                                     ; preds = %24
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

; <label>:74:                                     ; preds = %61
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

; <label>:84:                                     ; preds = %61
  %85 = load i32, i32* %8, align 4
  %86 = icmp eq i32 %85, 2
  br i1 %86, label %87, label %107

; <label>:87:                                     ; preds = %84
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

; <label>:107:                                    ; preds = %84
  %108 = load i32, i32* %8, align 4
  %109 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.13, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i32 0, i32 0), i32 %108)
  br label %110

; <label>:110:                                    ; preds = %107, %87
  br label %111

; <label>:111:                                    ; preds = %110, %74
  %112 = load %struct.tnode*, %struct.tnode** %6, align 8
  %113 = getelementptr inbounds %struct.tnode, %struct.tnode* %112, i32 0, i32 0
  %114 = load i32, i32* %113, align 8
  %115 = load %struct.tnode*, %struct.tnode** %5, align 8
  %116 = getelementptr inbounds %struct.tnode, %struct.tnode* %115, i32 0, i32 1
  %117 = load i32, i32* %116, align 4
  %118 = icmp uge i32 %114, %117
  br i1 %118, label %119, label %127

; <label>:119:                                    ; preds = %111
  %120 = load %struct.tnode*, %struct.tnode** %6, align 8
  %121 = getelementptr inbounds %struct.tnode, %struct.tnode* %120, i32 0, i32 0
  %122 = load i32, i32* %121, align 8
  %123 = load %struct.tnode*, %struct.tnode** %5, align 8
  %124 = getelementptr inbounds %struct.tnode, %struct.tnode* %123, i32 0, i32 1
  %125 = load i32, i32* %124, align 4
  %126 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.14, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_list_slide, i32 0, i32 0), i32 %122, i32 %125)
  br label %127

; <label>:127:                                    ; preds = %119, %111
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

; <label>:12:                                     ; preds = %4
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_list, i32 0, i32 0))
  br label %14

; <label>:14:                                     ; preds = %12, %4
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

; <label>:25:                                     ; preds = %14
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

; <label>:35:                                     ; preds = %14
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

; <label>:52:                                     ; preds = %83, %35
  %53 = load i32, i32* %9, align 4
  %54 = load i32, i32* %8, align 4
  %55 = icmp slt i32 %53, %54
  br i1 %55, label %56, label %86

; <label>:56:                                     ; preds = %52
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
  call void @memcpy(i8* %81, i8* %82, i64 16, i32 8, i1 false)
  br label %83

; <label>:83:                                     ; preds = %56
  %84 = load i32, i32* %9, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, i32* %9, align 4
  br label %52

; <label>:86:                                     ; preds = %52
  br label %87

; <label>:87:                                     ; preds = %86, %25
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

; <label>:13:                                     ; preds = %5
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_2d_matrix, i32 0, i32 0))
  br label %15

; <label>:15:                                     ; preds = %13, %5
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
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.15, i32 0, i32 0), i32 %37, i32 %40, i32 %43)
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

; <label>:9:                                      ; preds = %3
  %10 = load %struct.tpool*, %struct.tpool** %4, align 8
  %11 = icmp eq %struct.tpool* %10, @funk_global_memory_pool
  %12 = zext i1 %11 to i64
  %13 = select i1 %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.18, i32 0, i32 0)
  %14 = load %struct.tpool*, %struct.tpool** %4, align 8
  %15 = getelementptr inbounds %struct.tpool, %struct.tpool* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 8
  %17 = load i32, i32* %6, align 4
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.16, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_int_scalar, i32 0, i32 0), i8* %13, i32 %16, i32 %17)
  br label %19

; <label>:19:                                     ; preds = %9, %3
  %20 = load %struct.tpool*, %struct.tpool** %4, align 8
  %21 = getelementptr inbounds %struct.tpool, %struct.tpool* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 8
  %23 = load %struct.tnode*, %struct.tnode** %5, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 0
  store i32 %22, i32* %24, align 8
  %25 = load %struct.tnode*, %struct.tnode** %5, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  store i32 1, i32* %26, align 4
  %27 = load %struct.tpool*, %struct.tpool** %4, align 8
  %28 = load %struct.tnode*, %struct.tnode** %5, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 2
  store %struct.tpool* %27, %struct.tpool** %29, align 8
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 3
  %32 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %31, i32 0, i32 0
  store i32 1, i32* %32, align 8
  %33 = load %struct.tpool*, %struct.tpool** %4, align 8
  %34 = getelementptr inbounds %struct.tpool, %struct.tpool* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 8
  %36 = add i32 %35, 1
  %37 = urem i32 %36, 1024
  %38 = load %struct.tpool*, %struct.tpool** %4, align 8
  %39 = getelementptr inbounds %struct.tpool, %struct.tpool* %38, i32 0, i32 1
  store i32 %37, i32* %39, align 8
  %40 = load %struct.tpool*, %struct.tpool** %4, align 8
  %41 = getelementptr inbounds %struct.tpool, %struct.tpool* %40, i32 0, i32 0
  %42 = load %struct.tnode*, %struct.tnode** %5, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 0
  %44 = load i32, i32* %43, align 8
  %45 = zext i32 %44 to i64
  %46 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %41, i64 0, i64 %45
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 0
  store i8 1, i8* %47, align 8
  %48 = load i32, i32* %6, align 4
  %49 = load %struct.tpool*, %struct.tpool** %4, align 8
  %50 = getelementptr inbounds %struct.tpool, %struct.tpool* %49, i32 0, i32 0
  %51 = load %struct.tnode*, %struct.tnode** %5, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 0
  %53 = load i32, i32* %52, align 8
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %50, i64 0, i64 %54
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 1
  %57 = bitcast %union.data_type* %56 to i32*
  store i32 %48, i32* %57, align 8
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

; <label>:12:                                     ; preds = %4
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_create_list_int_literal, i32 0, i32 0))
  br label %14

; <label>:14:                                     ; preds = %12, %4
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

; <label>:37:                                     ; preds = %68, %14
  %38 = load i32, i32* %9, align 4
  %39 = load i32, i32* %8, align 4
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %41, label %71

; <label>:41:                                     ; preds = %37
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

; <label>:68:                                     ; preds = %41
  %69 = load i32, i32* %9, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, i32* %9, align 4
  br label %37

; <label>:71:                                     ; preds = %37
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

; <label>:13:                                     ; preds = %5
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_2d_matrix_int_literal, i32 0, i32 0))
  br label %15

; <label>:15:                                     ; preds = %13, %5
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
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.15, i32 0, i32 0), i32 %37, i32 %40, i32 %43)
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

; <label>:14:                                     ; preds = %5
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_copy_element_from_pool, i32 0, i32 0))
  br label %16

; <label>:16:                                     ; preds = %14, %5
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

; <label>:31:                                     ; preds = %16
  %32 = load i32, i32* %9, align 4
  %33 = load i32, i32* %10, align 4
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.19, i32 0, i32 0), i32 %32, i32 %33)
  br label %45

; <label>:35:                                     ; preds = %16
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

; <label>:45:                                     ; preds = %35, %31
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

; <label>:10:                                     ; preds = %2
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %12 = bitcast %union.data_type* %11 to i32*
  %13 = load i32, i32* %12, align 8
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.20, i32 0, i32 0), i32 %13)
  br label %24

; <label>:15:                                     ; preds = %2
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.21, i32 0, i32 0), double %18)
  br label %24

; <label>:20:                                     ; preds = %2
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.22, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.23, i32 0, i32 0))
  br label %24

; <label>:22:                                     ; preds = %2
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.22, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.24, i32 0, i32 0))
  br label %24

; <label>:24:                                     ; preds = %22, %20, %15, %10
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

; <label>:9:                                      ; preds = %3
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 2
  %12 = load %struct.tpool*, %struct.tpool** %11, align 8
  %13 = icmp eq %struct.tpool* %12, @funk_global_memory_pool
  %14 = zext i1 %13 to i64
  %15 = select i1 %13, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.18, i32 0, i32 0)
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = load i32, i32* %5, align 4
  %20 = add i32 %18, %19
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.25, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i32 0, i32 0), i8* %15, i32 %20)
  br label %22

; <label>:22:                                     ; preds = %9, %3
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = icmp ugt i32 %25, 0
  br i1 %26, label %27, label %39

; <label>:27:                                     ; preds = %22
  %28 = load i32, i32* %5, align 4
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = load i32, i32* %30, align 4
  %32 = icmp uge i32 %28, %31
  br i1 %32, label %33, label %39

; <label>:33:                                     ; preds = %27
  %34 = load i32, i32* %5, align 4
  %35 = load %struct.tnode*, %struct.tnode** %4, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 1
  %37 = load i32, i32* %36, align 4
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.26, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i32 0, i32 0), i32 %34, i32 %37)
  br label %39

; <label>:39:                                     ; preds = %33, %27, %22
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

; <label>:56:                                     ; preds = %39
  %57 = load i8*, i8** %6, align 8
  %58 = load i8, i8* %57, align 1
  call void @funk_print_type(i8 zeroext %58)
  %59 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.27, i32 0, i32 0))
  br label %60

; <label>:60:                                     ; preds = %56, %39
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

; <label>:9:                                      ; preds = %3
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i32 0, i32 0))
  br label %11

; <label>:11:                                     ; preds = %9, %3
  %12 = load i32, i32* %5, align 4
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 4
  %16 = icmp uge i32 %12, %15
  br i1 %16, label %17, label %23

; <label>:17:                                     ; preds = %11
  %18 = load i32, i32* %5, align 4
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 4
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.26, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i32 0, i32 0), i32 %18, i32 %21)
  br label %23

; <label>:23:                                     ; preds = %17, %11
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

; <label>:9:                                      ; preds = %3
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i32 0, i32 0))
  br label %11

; <label>:11:                                     ; preds = %9, %3
  %12 = load i32, i32* %5, align 4
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 4
  %16 = icmp uge i32 %12, %15
  br i1 %16, label %17, label %23

; <label>:17:                                     ; preds = %11
  %18 = load i32, i32* %5, align 4
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 4
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.26, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i32 0, i32 0), i32 %18, i32 %21)
  br label %23

; <label>:23:                                     ; preds = %17, %11
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

; <label>:4:                                      ; preds = %28, %1
  %5 = load i32, i32* %3, align 4
  %6 = icmp slt i32 %5, 64
  br i1 %6, label %7, label %31

; <label>:7:                                      ; preds = %4
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

; <label>:20:                                     ; preds = %7
  %21 = load i32, i32* %3, align 4
  %22 = add nsw i32 %21, 1
  %23 = srem i32 %22, 7
  %24 = icmp eq i32 %23, 0
  br i1 %24, label %25, label %27

; <label>:25:                                     ; preds = %20
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i32 0, i32 0))
  br label %27

; <label>:27:                                     ; preds = %25, %20, %7
  br label %28

; <label>:28:                                     ; preds = %27
  %29 = load i32, i32* %3, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, i32* %3, align 4
  br label %4

; <label>:31:                                     ; preds = %4
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i32 0, i32 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_next_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %5 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %21

; <label>:7:                                      ; preds = %2
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 2
  %10 = load %struct.tpool*, %struct.tpool** %9, align 8
  %11 = icmp eq %struct.tpool* %10, @funk_global_memory_pool
  %12 = zext i1 %11 to i64
  %13 = select i1 %11, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.18, i32 0, i32 0)
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  %17 = load %struct.tnode*, %struct.tnode** %4, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 1
  %19 = load i32, i32* %18, align 4
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.29, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_next_node, i32 0, i32 0), i8* %13, i32 %16, i32 %19)
  br label %21

; <label>:21:                                     ; preds = %7, %2
  %22 = load %struct.tnode*, %struct.tnode** %4, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 2
  %24 = load %struct.tpool*, %struct.tpool** %23, align 8
  %25 = load %struct.tnode*, %struct.tnode** %3, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 2
  store %struct.tpool* %24, %struct.tpool** %26, align 8
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %31, label %60

; <label>:31:                                     ; preds = %21
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 0
  %34 = load i32, i32* %33, align 8
  %35 = load %struct.tnode*, %struct.tnode** %3, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 0
  store i32 %34, i32* %36, align 8
  %37 = load %struct.tnode*, %struct.tnode** %3, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 1
  store i32 1, i32* %38, align 4
  %39 = load %struct.tnode*, %struct.tnode** %3, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 2
  %41 = load %struct.tpool*, %struct.tpool** %40, align 8
  %42 = getelementptr inbounds %struct.tpool, %struct.tpool* %41, i32 0, i32 0
  %43 = load %struct.tnode*, %struct.tnode** %3, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %42, i64 0, i64 %46
  %48 = getelementptr inbounds %struct.tdata, %struct.tdata* %47, i32 0, i32 0
  store i8 4, i8* %48, align 8
  %49 = load %struct.tnode*, %struct.tnode** %3, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 2
  %51 = load %struct.tpool*, %struct.tpool** %50, align 8
  %52 = getelementptr inbounds %struct.tpool, %struct.tpool* %51, i32 0, i32 0
  %53 = load %struct.tnode*, %struct.tnode** %3, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 0
  %55 = load i32, i32* %54, align 8
  %56 = zext i32 %55 to i64
  %57 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %52, i64 0, i64 %56
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 1
  %59 = bitcast %union.data_type* %58 to i32*
  store i32 0, i32* %59, align 8
  br label %73

; <label>:60:                                     ; preds = %21
  %61 = load %struct.tnode*, %struct.tnode** %4, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 1
  %63 = load i32, i32* %62, align 4
  %64 = sub i32 %63, 1
  %65 = load %struct.tnode*, %struct.tnode** %3, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 1
  store i32 %64, i32* %66, align 4
  %67 = load %struct.tnode*, %struct.tnode** %4, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 0
  %69 = load i32, i32* %68, align 8
  %70 = add i32 %69, 1
  %71 = load %struct.tnode*, %struct.tnode** %3, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 0
  store i32 %70, i32* %72, align 8
  br label %73

; <label>:73:                                     ; preds = %60, %31
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_function_entry_hook() #0 {
  %1 = alloca [8 x i8], align 1
  %2 = load i32, i32* @funk_debug_function_entry_hook.run_until_the_end, align 4
  %3 = icmp eq i32 %2, 1
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %0
  br label %39

; <label>:5:                                      ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.30, i32 0, i32 0))
  br label %7

; <label>:7:                                      ; preds = %35, %5
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.31, i32 0, i32 0))
  %9 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %10 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8
  %11 = call i8* @fgets(i8* %9, i32 8, %struct.__sFILE* %10)
  %12 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %13 = call i32 @strncmp(i8* %12, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i32 0, i32 0), i64 5)
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %16, label %15

; <label>:15:                                     ; preds = %7
  call void @funk_print_pool(%struct.tpool* @funk_global_memory_pool)
  br label %34

; <label>:16:                                     ; preds = %7
  %17 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %18 = call i32 @strncmp(i8* %17, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.18, i32 0, i32 0), i64 5)
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %21, label %20

; <label>:20:                                     ; preds = %16
  call void @funk_print_pool(%struct.tpool* @funk_functions_memory_pool)
  br label %33

; <label>:21:                                     ; preds = %16
  %22 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %23 = call i32 @strncmp(i8* %22, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.32, i32 0, i32 0), i64 6)
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %26, label %25

; <label>:25:                                     ; preds = %21
  store i32 1, i32* @funk_debug_function_entry_hook.run_until_the_end, align 4
  br label %32

; <label>:26:                                     ; preds = %21
  %27 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %28 = call i32 @strncmp(i8* %27, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.33, i32 0, i32 0), i64 1)
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %31, label %30

; <label>:30:                                     ; preds = %26
  call void @exit(i32 0) #4
  unreachable

; <label>:31:                                     ; preds = %26
  br label %32

; <label>:32:                                     ; preds = %31, %25
  br label %33

; <label>:33:                                     ; preds = %32, %20
  br label %34

; <label>:34:                                     ; preds = %33, %15
  br label %35

; <label>:35:                                     ; preds = %34
  %36 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %37 = call i32 @strncmp(i8* %36, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.34, i32 0, i32 0), i64 1)
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %7, label %39

; <label>:39:                                     ; preds = %4, %35
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
  store i32 0, i32* %9, align 4
  br label %10

; <label>:10:                                     ; preds = %25, %4
  %11 = load i32, i32* %9, align 4
  %12 = load i32, i32* %7, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %28

; <label>:14:                                     ; preds = %10
  %15 = load %struct.tnode*, %struct.tnode** %5, align 8
  %16 = load i32, i32* %9, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i64 %17
  %19 = load %struct.tnode*, %struct.tnode** %6, align 8
  %20 = load i32, i32* %9, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i64 %21
  %23 = bitcast %struct.tnode* %18 to i8*
  %24 = bitcast %struct.tnode* %22 to i8*
  call void @memcpy(i8* %23, i8* %24, i64 32, i32 8, i1 false)
  br label %25

; <label>:25:                                     ; preds = %14
  %26 = load i32, i32* %9, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, i32* %9, align 4
  br label %10

; <label>:28:                                     ; preds = %10
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
  %18 = select i1 %16, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.18, i32 0, i32 0)
  %19 = load %struct.tnode*, %struct.tnode** %9, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = load i32, i32* %10, align 4
  %23 = add i32 %21, %22
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.35, i32 0, i32 0), i8* %18, i32 %23)
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
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.36, i32 0, i32 0))
  %42 = load %struct.tnode*, %struct.tnode** %11, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 2
  %44 = load %struct.tpool*, %struct.tpool** %43, align 8
  %45 = icmp eq %struct.tpool* %44, @funk_global_memory_pool
  %46 = zext i1 %45 to i64
  %47 = select i1 %45, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.18, i32 0, i32 0)
  %48 = load %struct.tnode*, %struct.tnode** %11, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 0
  %50 = load i32, i32* %49, align 8
  %51 = load i32, i32* %12, align 4
  %52 = add i32 %50, %51
  %53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.35, i32 0, i32 0), i8* %47, i32 %52)
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
  %75 = select i1 %73, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.18, i32 0, i32 0)
  %76 = load %struct.tnode*, %struct.tnode** %7, align 8
  %77 = getelementptr inbounds %struct.tnode, %struct.tnode* %76, i32 0, i32 0
  %78 = load i32, i32* %77, align 8
  %79 = load i32, i32* %8, align 4
  %80 = add i32 %78, %79
  %81 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.37, i32 0, i32 0), i8* %75, i32 %80)
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
  %98 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.38, i32 0, i32 0))
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

; <label>:16:                                     ; preds = %5
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__FUNCTION__.funk_add_ri, i32 0, i32 0))
  br label %18

; <label>:18:                                     ; preds = %16, %5
  %19 = load i32, i32* %9, align 4
  %20 = load %struct.tnode*, %struct.tnode** %8, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 4
  %23 = icmp ugt i32 %19, %22
  br i1 %23, label %24, label %30

; <label>:24:                                     ; preds = %18
  %25 = load i32, i32* %9, align 4
  %26 = load %struct.tnode*, %struct.tnode** %8, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = load i32, i32* %27, align 4
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.39, i32 0, i32 0), i32 %25, i32 %28)
  br label %30

; <label>:30:                                     ; preds = %24, %18
  %31 = load i32, i32* %7, align 4
  %32 = load %struct.tnode*, %struct.tnode** %6, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = load i32, i32* %33, align 4
  %35 = icmp ugt i32 %31, %34
  br i1 %35, label %36, label %42

; <label>:36:                                     ; preds = %30
  %37 = load i32, i32* %7, align 4
  %38 = load %struct.tnode*, %struct.tnode** %6, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.39, i32 0, i32 0), i32 %37, i32 %40)
  br label %42

; <label>:42:                                     ; preds = %36, %30
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
  call void @memcpy(i8* %54, i8* %55, i64 16, i32 8, i1 false)
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

; <label>:72:                                     ; preds = %42
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

; <label>:83:                                     ; preds = %42
  %84 = load i8, i8* %13, align 1
  %85 = zext i8 %84 to i32
  %86 = icmp eq i32 %85, 2
  br i1 %86, label %87, label %99

; <label>:87:                                     ; preds = %83
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

; <label>:99:                                     ; preds = %83
  %100 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.40, i32 0, i32 0))
  %101 = load %struct.tdata*, %struct.tdata** %12, align 8
  %102 = getelementptr inbounds %struct.tdata, %struct.tdata* %101, i32 0, i32 0
  store i8 0, i8* %102, align 8
  br label %103

; <label>:103:                                    ; preds = %99, %87
  br label %104

; <label>:104:                                    ; preds = %103, %72
  %105 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %106 = icmp ne i32 %105, 0
  br i1 %106, label %107, label %147

; <label>:107:                                    ; preds = %104
  %108 = load %struct.tnode*, %struct.tnode** %8, align 8
  %109 = getelementptr inbounds %struct.tnode, %struct.tnode* %108, i32 0, i32 2
  %110 = load %struct.tpool*, %struct.tpool** %109, align 8
  %111 = icmp eq %struct.tpool* %110, @funk_global_memory_pool
  %112 = zext i1 %111 to i64
  %113 = select i1 %111, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.18, i32 0, i32 0)
  %114 = load %struct.tnode*, %struct.tnode** %8, align 8
  %115 = getelementptr inbounds %struct.tnode, %struct.tnode* %114, i32 0, i32 0
  %116 = load i32, i32* %115, align 8
  %117 = load i32, i32* %9, align 4
  %118 = add i32 %116, %117
  %119 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.35, i32 0, i32 0), i8* %113, i32 %118)
  %120 = bitcast %struct.tdata* %11 to { i8, i64 }*
  %121 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %120, i32 0, i32 0
  %122 = load i8, i8* %121, align 8
  %123 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %120, i32 0, i32 1
  %124 = load i64, i64* %123, align 8
  call void @funk_print_scalar_element(i8 %122, i64 %124)
  %125 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.36, i32 0, i32 0))
  %126 = load i32, i32* %10, align 4
  %127 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.41, i32 0, i32 0), i32 %126)
  %128 = load %struct.tnode*, %struct.tnode** %6, align 8
  %129 = getelementptr inbounds %struct.tnode, %struct.tnode* %128, i32 0, i32 2
  %130 = load %struct.tpool*, %struct.tpool** %129, align 8
  %131 = icmp eq %struct.tpool* %130, @funk_global_memory_pool
  %132 = zext i1 %131 to i64
  %133 = select i1 %131, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.18, i32 0, i32 0)
  %134 = load %struct.tnode*, %struct.tnode** %6, align 8
  %135 = getelementptr inbounds %struct.tnode, %struct.tnode* %134, i32 0, i32 0
  %136 = load i32, i32* %135, align 8
  %137 = load i32, i32* %7, align 4
  %138 = add i32 %136, %137
  %139 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.37, i32 0, i32 0), i8* %133, i32 %138)
  %140 = load %struct.tdata*, %struct.tdata** %12, align 8
  %141 = bitcast %struct.tdata* %140 to { i8, i64 }*
  %142 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %141, i32 0, i32 0
  %143 = load i8, i8* %142, align 8
  %144 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %141, i32 0, i32 1
  %145 = load i64, i64* %144, align 8
  call void @funk_print_scalar_element(i8 %143, i64 %145)
  %146 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.38, i32 0, i32 0))
  br label %147

; <label>:147:                                    ; preds = %107, %104
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
  %13 = alloca %struct.tdata, align 8
  %14 = alloca %struct.tdata, align 8
  %15 = alloca %struct.tdata*, align 8
  %16 = alloca i8, align 1
  %17 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %18 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %22

; <label>:20:                                     ; preds = %6
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__FUNCTION__.funk_add_rr, i32 0, i32 0))
  br label %22

; <label>:22:                                     ; preds = %20, %6
  %23 = load i32, i32* %10, align 4
  %24 = load %struct.tnode*, %struct.tnode** %9, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 4
  %27 = icmp ugt i32 %23, %26
  br i1 %27, label %28, label %34

; <label>:28:                                     ; preds = %22
  %29 = load i32, i32* %10, align 4
  %30 = load %struct.tnode*, %struct.tnode** %9, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 1
  %32 = load i32, i32* %31, align 4
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.39, i32 0, i32 0), i32 %29, i32 %32)
  br label %34

; <label>:34:                                     ; preds = %28, %22
  %35 = load i32, i32* %12, align 4
  %36 = load %struct.tnode*, %struct.tnode** %11, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = load i32, i32* %37, align 4
  %39 = icmp ugt i32 %35, %38
  br i1 %39, label %40, label %46

; <label>:40:                                     ; preds = %34
  %41 = load i32, i32* %12, align 4
  %42 = load %struct.tnode*, %struct.tnode** %11, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 1
  %44 = load i32, i32* %43, align 4
  %45 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.39, i32 0, i32 0), i32 %41, i32 %44)
  br label %46

; <label>:46:                                     ; preds = %40, %34
  %47 = load i32, i32* %8, align 4
  %48 = load %struct.tnode*, %struct.tnode** %7, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = load i32, i32* %49, align 4
  %51 = icmp ugt i32 %47, %50
  br i1 %51, label %52, label %58

; <label>:52:                                     ; preds = %46
  %53 = load i32, i32* %8, align 4
  %54 = load %struct.tnode*, %struct.tnode** %7, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 1
  %56 = load i32, i32* %55, align 4
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.39, i32 0, i32 0), i32 %53, i32 %56)
  br label %58

; <label>:58:                                     ; preds = %52, %46
  %59 = load %struct.tnode*, %struct.tnode** %9, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 2
  %61 = load %struct.tpool*, %struct.tpool** %60, align 8
  %62 = getelementptr inbounds %struct.tpool, %struct.tpool* %61, i32 0, i32 0
  %63 = load %struct.tnode*, %struct.tnode** %9, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 0
  %65 = load i32, i32* %64, align 8
  %66 = load i32, i32* %10, align 4
  %67 = add i32 %65, %66
  %68 = zext i32 %67 to i64
  %69 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %62, i64 0, i64 %68
  %70 = bitcast %struct.tdata* %13 to i8*
  %71 = bitcast %struct.tdata* %69 to i8*
  call void @memcpy(i8* %70, i8* %71, i64 16, i32 8, i1 false)
  %72 = load %struct.tnode*, %struct.tnode** %11, align 8
  %73 = getelementptr inbounds %struct.tnode, %struct.tnode* %72, i32 0, i32 2
  %74 = load %struct.tpool*, %struct.tpool** %73, align 8
  %75 = getelementptr inbounds %struct.tpool, %struct.tpool* %74, i32 0, i32 0
  %76 = load %struct.tnode*, %struct.tnode** %11, align 8
  %77 = getelementptr inbounds %struct.tnode, %struct.tnode* %76, i32 0, i32 0
  %78 = load i32, i32* %77, align 8
  %79 = load i32, i32* %12, align 4
  %80 = add i32 %78, %79
  %81 = zext i32 %80 to i64
  %82 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %75, i64 0, i64 %81
  %83 = bitcast %struct.tdata* %14 to i8*
  %84 = bitcast %struct.tdata* %82 to i8*
  call void @memcpy(i8* %83, i8* %84, i64 16, i32 8, i1 false)
  %85 = load %struct.tnode*, %struct.tnode** %7, align 8
  %86 = getelementptr inbounds %struct.tnode, %struct.tnode* %85, i32 0, i32 2
  %87 = load %struct.tpool*, %struct.tpool** %86, align 8
  %88 = getelementptr inbounds %struct.tpool, %struct.tpool* %87, i32 0, i32 0
  %89 = load %struct.tnode*, %struct.tnode** %7, align 8
  %90 = getelementptr inbounds %struct.tnode, %struct.tnode* %89, i32 0, i32 0
  %91 = load i32, i32* %90, align 8
  %92 = load i32, i32* %8, align 4
  %93 = add i32 %91, %92
  %94 = zext i32 %93 to i64
  %95 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %88, i64 0, i64 %94
  store %struct.tdata* %95, %struct.tdata** %15, align 8
  %96 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 0
  %97 = load i8, i8* %96, align 8
  store i8 %97, i8* %16, align 1
  %98 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %99 = load i8, i8* %98, align 8
  store i8 %99, i8* %17, align 1
  %100 = load i8, i8* %17, align 1
  %101 = zext i8 %100 to i32
  %102 = icmp eq i32 %101, 4
  br i1 %102, label %103, label %104

; <label>:103:                                    ; preds = %58
  store i8 1, i8* %17, align 1
  br label %104

; <label>:104:                                    ; preds = %103, %58
  %105 = load i8, i8* %16, align 1
  %106 = zext i8 %105 to i32
  %107 = icmp eq i32 %106, 4
  br i1 %107, label %108, label %109

; <label>:108:                                    ; preds = %104
  store i8 1, i8* %16, align 1
  br label %109

; <label>:109:                                    ; preds = %108, %104
  %110 = load i8, i8* %16, align 1
  %111 = zext i8 %110 to i32
  %112 = icmp eq i32 %111, 1
  br i1 %112, label %113, label %130

; <label>:113:                                    ; preds = %109
  %114 = load i8, i8* %17, align 1
  %115 = zext i8 %114 to i32
  %116 = icmp eq i32 %115, 1
  br i1 %116, label %117, label %130

; <label>:117:                                    ; preds = %113
  %118 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %119 = bitcast %union.data_type* %118 to i32*
  %120 = load i32, i32* %119, align 8
  %121 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %122 = bitcast %union.data_type* %121 to i32*
  %123 = load i32, i32* %122, align 8
  %124 = add nsw i32 %120, %123
  %125 = load %struct.tdata*, %struct.tdata** %15, align 8
  %126 = getelementptr inbounds %struct.tdata, %struct.tdata* %125, i32 0, i32 1
  %127 = bitcast %union.data_type* %126 to i32*
  store i32 %124, i32* %127, align 8
  %128 = load %struct.tdata*, %struct.tdata** %15, align 8
  %129 = getelementptr inbounds %struct.tdata, %struct.tdata* %128, i32 0, i32 0
  store i8 1, i8* %129, align 8
  br label %206

; <label>:130:                                    ; preds = %113, %109
  %131 = load i8, i8* %16, align 1
  %132 = zext i8 %131 to i32
  %133 = icmp eq i32 %132, 2
  br i1 %133, label %134, label %151

; <label>:134:                                    ; preds = %130
  %135 = load i8, i8* %17, align 1
  %136 = zext i8 %135 to i32
  %137 = icmp eq i32 %136, 2
  br i1 %137, label %138, label %151

; <label>:138:                                    ; preds = %134
  %139 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %140 = bitcast %union.data_type* %139 to double*
  %141 = load double, double* %140, align 8
  %142 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %143 = bitcast %union.data_type* %142 to double*
  %144 = load double, double* %143, align 8
  %145 = fadd double %141, %144
  %146 = load %struct.tdata*, %struct.tdata** %15, align 8
  %147 = getelementptr inbounds %struct.tdata, %struct.tdata* %146, i32 0, i32 1
  %148 = bitcast %union.data_type* %147 to double*
  store double %145, double* %148, align 8
  %149 = load %struct.tdata*, %struct.tdata** %15, align 8
  %150 = getelementptr inbounds %struct.tdata, %struct.tdata* %149, i32 0, i32 0
  store i8 2, i8* %150, align 8
  br label %205

; <label>:151:                                    ; preds = %134, %130
  %152 = load i8, i8* %16, align 1
  %153 = zext i8 %152 to i32
  %154 = icmp eq i32 %153, 2
  br i1 %154, label %155, label %173

; <label>:155:                                    ; preds = %151
  %156 = load i8, i8* %17, align 1
  %157 = zext i8 %156 to i32
  %158 = icmp eq i32 %157, 1
  br i1 %158, label %159, label %173

; <label>:159:                                    ; preds = %155
  %160 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %161 = bitcast %union.data_type* %160 to double*
  %162 = load double, double* %161, align 8
  %163 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %164 = bitcast %union.data_type* %163 to i32*
  %165 = load i32, i32* %164, align 8
  %166 = sitofp i32 %165 to double
  %167 = fadd double %162, %166
  %168 = load %struct.tdata*, %struct.tdata** %15, align 8
  %169 = getelementptr inbounds %struct.tdata, %struct.tdata* %168, i32 0, i32 1
  %170 = bitcast %union.data_type* %169 to double*
  store double %167, double* %170, align 8
  %171 = load %struct.tdata*, %struct.tdata** %15, align 8
  %172 = getelementptr inbounds %struct.tdata, %struct.tdata* %171, i32 0, i32 0
  store i8 2, i8* %172, align 8
  br label %204

; <label>:173:                                    ; preds = %155, %151
  %174 = load i8, i8* %16, align 1
  %175 = zext i8 %174 to i32
  %176 = icmp eq i32 %175, 1
  br i1 %176, label %177, label %195

; <label>:177:                                    ; preds = %173
  %178 = load i8, i8* %17, align 1
  %179 = zext i8 %178 to i32
  %180 = icmp eq i32 %179, 2
  br i1 %180, label %181, label %195

; <label>:181:                                    ; preds = %177
  %182 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %183 = bitcast %union.data_type* %182 to i32*
  %184 = load i32, i32* %183, align 8
  %185 = sitofp i32 %184 to double
  %186 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %187 = bitcast %union.data_type* %186 to double*
  %188 = load double, double* %187, align 8
  %189 = fadd double %185, %188
  %190 = load %struct.tdata*, %struct.tdata** %15, align 8
  %191 = getelementptr inbounds %struct.tdata, %struct.tdata* %190, i32 0, i32 1
  %192 = bitcast %union.data_type* %191 to double*
  store double %189, double* %192, align 8
  %193 = load %struct.tdata*, %struct.tdata** %15, align 8
  %194 = getelementptr inbounds %struct.tdata, %struct.tdata* %193, i32 0, i32 0
  store i8 2, i8* %194, align 8
  br label %203

; <label>:195:                                    ; preds = %177, %173
  %196 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.42, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__FUNCTION__.funk_add_rr, i32 0, i32 0))
  %197 = load i8, i8* %16, align 1
  call void @funk_print_type(i8 zeroext %197)
  %198 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.36, i32 0, i32 0))
  %199 = load i8, i8* %17, align 1
  call void @funk_print_type(i8 zeroext %199)
  %200 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i32 0, i32 0))
  %201 = load %struct.tdata*, %struct.tdata** %15, align 8
  %202 = getelementptr inbounds %struct.tdata, %struct.tdata* %201, i32 0, i32 0
  store i8 0, i8* %202, align 8
  br label %203

; <label>:203:                                    ; preds = %195, %181
  br label %204

; <label>:204:                                    ; preds = %203, %159
  br label %205

; <label>:205:                                    ; preds = %204, %138
  br label %206

; <label>:206:                                    ; preds = %205, %117
  %207 = load i32, i32* @g_funk_internal_function_tracing_enabled, align 4
  %208 = icmp ne i32 %207, 0
  br i1 %208, label %209, label %216

; <label>:209:                                    ; preds = %206
  %210 = load %struct.tnode*, %struct.tnode** %7, align 8
  %211 = load i32, i32* %8, align 4
  %212 = load %struct.tnode*, %struct.tnode** %9, align 8
  %213 = load i32, i32* %10, align 4
  %214 = load %struct.tnode*, %struct.tnode** %11, align 8
  %215 = load i32, i32* %12, align 4
  call void @debug_print_arith_operation(%struct.tnode* %210, i32 %211, %struct.tnode* %212, i32 %213, %struct.tnode* %214, i32 %215)
  br label %216

; <label>:216:                                    ; preds = %209, %206
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
  %13 = alloca %struct.tdata, align 8
  %14 = alloca %struct.tdata, align 8
  %15 = alloca %struct.tdata*, align 8
  %16 = alloca i8, align 1
  %17 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store i32 %3, i32* %10, align 4
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store i32 %5, i32* %12, align 4
  %18 = load i32, i32* %10, align 4
  %19 = load %struct.tnode*, %struct.tnode** %9, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 4
  %22 = icmp ugt i32 %18, %21
  br i1 %22, label %23, label %29

; <label>:23:                                     ; preds = %6
  %24 = load i32, i32* %10, align 4
  %25 = load %struct.tnode*, %struct.tnode** %9, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = load i32, i32* %26, align 4
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.39, i32 0, i32 0), i32 %24, i32 %27)
  br label %29

; <label>:29:                                     ; preds = %23, %6
  %30 = load i32, i32* %12, align 4
  %31 = load %struct.tnode*, %struct.tnode** %11, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 1
  %33 = load i32, i32* %32, align 4
  %34 = icmp ugt i32 %30, %33
  br i1 %34, label %35, label %41

; <label>:35:                                     ; preds = %29
  %36 = load i32, i32* %12, align 4
  %37 = load %struct.tnode*, %struct.tnode** %11, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 1
  %39 = load i32, i32* %38, align 4
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.39, i32 0, i32 0), i32 %36, i32 %39)
  br label %41

; <label>:41:                                     ; preds = %35, %29
  %42 = load i32, i32* %8, align 4
  %43 = load %struct.tnode*, %struct.tnode** %7, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 1
  %45 = load i32, i32* %44, align 4
  %46 = icmp ugt i32 %42, %45
  br i1 %46, label %47, label %53

; <label>:47:                                     ; preds = %41
  %48 = load i32, i32* %8, align 4
  %49 = load %struct.tnode*, %struct.tnode** %7, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  %51 = load i32, i32* %50, align 4
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.39, i32 0, i32 0), i32 %48, i32 %51)
  br label %53

; <label>:53:                                     ; preds = %47, %41
  %54 = load %struct.tnode*, %struct.tnode** %9, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 2
  %56 = load %struct.tpool*, %struct.tpool** %55, align 8
  %57 = getelementptr inbounds %struct.tpool, %struct.tpool* %56, i32 0, i32 0
  %58 = load %struct.tnode*, %struct.tnode** %9, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 0
  %60 = load i32, i32* %59, align 8
  %61 = load i32, i32* %10, align 4
  %62 = add i32 %60, %61
  %63 = zext i32 %62 to i64
  %64 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %57, i64 0, i64 %63
  %65 = bitcast %struct.tdata* %13 to i8*
  %66 = bitcast %struct.tdata* %64 to i8*
  call void @memcpy(i8* %65, i8* %66, i64 16, i32 8, i1 false)
  %67 = load %struct.tnode*, %struct.tnode** %11, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 2
  %69 = load %struct.tpool*, %struct.tpool** %68, align 8
  %70 = getelementptr inbounds %struct.tpool, %struct.tpool* %69, i32 0, i32 0
  %71 = load %struct.tnode*, %struct.tnode** %11, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 0
  %73 = load i32, i32* %72, align 8
  %74 = load i32, i32* %12, align 4
  %75 = add i32 %73, %74
  %76 = zext i32 %75 to i64
  %77 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %70, i64 0, i64 %76
  %78 = bitcast %struct.tdata* %14 to i8*
  %79 = bitcast %struct.tdata* %77 to i8*
  call void @memcpy(i8* %78, i8* %79, i64 16, i32 8, i1 false)
  %80 = load %struct.tnode*, %struct.tnode** %7, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 2
  %82 = load %struct.tpool*, %struct.tpool** %81, align 8
  %83 = getelementptr inbounds %struct.tpool, %struct.tpool* %82, i32 0, i32 0
  %84 = load %struct.tnode*, %struct.tnode** %7, align 8
  %85 = getelementptr inbounds %struct.tnode, %struct.tnode* %84, i32 0, i32 0
  %86 = load i32, i32* %85, align 8
  %87 = load i32, i32* %8, align 4
  %88 = add i32 %86, %87
  %89 = zext i32 %88 to i64
  %90 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %83, i64 0, i64 %89
  store %struct.tdata* %90, %struct.tdata** %15, align 8
  %91 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 0
  %92 = load i8, i8* %91, align 8
  store i8 %92, i8* %16, align 1
  %93 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %94 = load i8, i8* %93, align 8
  store i8 %94, i8* %17, align 1
  %95 = load i8, i8* %16, align 1
  %96 = zext i8 %95 to i32
  %97 = icmp eq i32 %96, 1
  br i1 %97, label %98, label %115

; <label>:98:                                     ; preds = %53
  %99 = load i8, i8* %17, align 1
  %100 = zext i8 %99 to i32
  %101 = icmp eq i32 %100, 1
  br i1 %101, label %102, label %115

; <label>:102:                                    ; preds = %98
  %103 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %104 = bitcast %union.data_type* %103 to i32*
  %105 = load i32, i32* %104, align 8
  %106 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %107 = bitcast %union.data_type* %106 to i32*
  %108 = load i32, i32* %107, align 8
  %109 = mul nsw i32 %105, %108
  %110 = load %struct.tdata*, %struct.tdata** %15, align 8
  %111 = getelementptr inbounds %struct.tdata, %struct.tdata* %110, i32 0, i32 1
  %112 = bitcast %union.data_type* %111 to i32*
  store i32 %109, i32* %112, align 8
  %113 = load %struct.tdata*, %struct.tdata** %15, align 8
  %114 = getelementptr inbounds %struct.tdata, %struct.tdata* %113, i32 0, i32 0
  store i8 1, i8* %114, align 8
  br label %187

; <label>:115:                                    ; preds = %98, %53
  %116 = load i8, i8* %16, align 1
  %117 = zext i8 %116 to i32
  %118 = icmp eq i32 %117, 2
  br i1 %118, label %119, label %136

; <label>:119:                                    ; preds = %115
  %120 = load i8, i8* %17, align 1
  %121 = zext i8 %120 to i32
  %122 = icmp eq i32 %121, 2
  br i1 %122, label %123, label %136

; <label>:123:                                    ; preds = %119
  %124 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %125 = bitcast %union.data_type* %124 to double*
  %126 = load double, double* %125, align 8
  %127 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %128 = bitcast %union.data_type* %127 to double*
  %129 = load double, double* %128, align 8
  %130 = fmul double %126, %129
  %131 = load %struct.tdata*, %struct.tdata** %15, align 8
  %132 = getelementptr inbounds %struct.tdata, %struct.tdata* %131, i32 0, i32 1
  %133 = bitcast %union.data_type* %132 to double*
  store double %130, double* %133, align 8
  %134 = load %struct.tdata*, %struct.tdata** %15, align 8
  %135 = getelementptr inbounds %struct.tdata, %struct.tdata* %134, i32 0, i32 0
  store i8 2, i8* %135, align 8
  br label %186

; <label>:136:                                    ; preds = %119, %115
  %137 = load i8, i8* %16, align 1
  %138 = zext i8 %137 to i32
  %139 = icmp eq i32 %138, 2
  br i1 %139, label %140, label %158

; <label>:140:                                    ; preds = %136
  %141 = load i8, i8* %17, align 1
  %142 = zext i8 %141 to i32
  %143 = icmp eq i32 %142, 1
  br i1 %143, label %144, label %158

; <label>:144:                                    ; preds = %140
  %145 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %146 = bitcast %union.data_type* %145 to double*
  %147 = load double, double* %146, align 8
  %148 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %149 = bitcast %union.data_type* %148 to i32*
  %150 = load i32, i32* %149, align 8
  %151 = sitofp i32 %150 to double
  %152 = fmul double %147, %151
  %153 = load %struct.tdata*, %struct.tdata** %15, align 8
  %154 = getelementptr inbounds %struct.tdata, %struct.tdata* %153, i32 0, i32 1
  %155 = bitcast %union.data_type* %154 to double*
  store double %152, double* %155, align 8
  %156 = load %struct.tdata*, %struct.tdata** %15, align 8
  %157 = getelementptr inbounds %struct.tdata, %struct.tdata* %156, i32 0, i32 0
  store i8 2, i8* %157, align 8
  br label %185

; <label>:158:                                    ; preds = %140, %136
  %159 = load i8, i8* %16, align 1
  %160 = zext i8 %159 to i32
  %161 = icmp eq i32 %160, 1
  br i1 %161, label %162, label %180

; <label>:162:                                    ; preds = %158
  %163 = load i8, i8* %17, align 1
  %164 = zext i8 %163 to i32
  %165 = icmp eq i32 %164, 2
  br i1 %165, label %166, label %180

; <label>:166:                                    ; preds = %162
  %167 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %168 = bitcast %union.data_type* %167 to i32*
  %169 = load i32, i32* %168, align 8
  %170 = sitofp i32 %169 to double
  %171 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %172 = bitcast %union.data_type* %171 to double*
  %173 = load double, double* %172, align 8
  %174 = fmul double %170, %173
  %175 = load %struct.tdata*, %struct.tdata** %15, align 8
  %176 = getelementptr inbounds %struct.tdata, %struct.tdata* %175, i32 0, i32 1
  %177 = bitcast %union.data_type* %176 to double*
  store double %174, double* %177, align 8
  %178 = load %struct.tdata*, %struct.tdata** %15, align 8
  %179 = getelementptr inbounds %struct.tdata, %struct.tdata* %178, i32 0, i32 0
  store i8 2, i8* %179, align 8
  br label %184

; <label>:180:                                    ; preds = %162, %158
  %181 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.40, i32 0, i32 0))
  %182 = load %struct.tdata*, %struct.tdata** %15, align 8
  %183 = getelementptr inbounds %struct.tdata, %struct.tdata* %182, i32 0, i32 0
  store i8 0, i8* %183, align 8
  br label %184

; <label>:184:                                    ; preds = %180, %166
  br label %185

; <label>:185:                                    ; preds = %184, %144
  br label %186

; <label>:186:                                    ; preds = %185, %123
  br label %187

; <label>:187:                                    ; preds = %186, %102
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_dimension(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.43, i32 0, i32 0))
  store i32 0, i32* %3, align 4
  br label %5

; <label>:5:                                      ; preds = %21, %1
  %6 = load i32, i32* %3, align 4
  %7 = load %struct.tnode*, %struct.tnode** %2, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 3
  %9 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %8, i32 0, i32 0
  %10 = load i32, i32* %9, align 8
  %11 = icmp ult i32 %6, %10
  br i1 %11, label %12, label %24

; <label>:12:                                     ; preds = %5
  %13 = load %struct.tnode*, %struct.tnode** %2, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 3
  %15 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %14, i32 0, i32 1
  %16 = load i32, i32* %3, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [2 x i32], [2 x i32]* %15, i64 0, i64 %17
  %19 = load i32, i32* %18, align 4
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.44, i32 0, i32 0), i32 %19)
  br label %21

; <label>:21:                                     ; preds = %12
  %22 = load i32, i32* %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %3, align 4
  br label %5

; <label>:24:                                     ; preds = %5
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.45, i32 0, i32 0))
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

; <label>:11:                                     ; preds = %1
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
  br label %126

; <label>:26:                                     ; preds = %1
  %27 = load %struct.tnode*, %struct.tnode** %2, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 3
  %29 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %28, i32 0, i32 0
  %30 = load i32, i32* %29, align 8
  %31 = icmp eq i32 %30, 1
  br i1 %31, label %32, label %63

; <label>:32:                                     ; preds = %26
  %33 = load %struct.tnode*, %struct.tnode** %2, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 0
  %35 = load i32, i32* %34, align 8
  store i32 %35, i32* %3, align 4
  br label %36

; <label>:36:                                     ; preds = %59, %32
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

; <label>:46:                                     ; preds = %36
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

; <label>:59:                                     ; preds = %46
  %60 = load i32, i32* %3, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, i32* %3, align 4
  br label %36

; <label>:62:                                     ; preds = %36
  br label %125

; <label>:63:                                     ; preds = %26
  %64 = load %struct.tnode*, %struct.tnode** %2, align 8
  %65 = getelementptr inbounds %struct.tnode, %struct.tnode* %64, i32 0, i32 3
  %66 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %65, i32 0, i32 0
  %67 = load i32, i32* %66, align 8
  %68 = icmp eq i32 %67, 2
  br i1 %68, label %69, label %122

; <label>:69:                                     ; preds = %63
  %70 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i32 0, i32 0))
  store i32 0, i32* %4, align 4
  br label %71

; <label>:71:                                     ; preds = %118, %69
  %72 = load i32, i32* %4, align 4
  %73 = load %struct.tnode*, %struct.tnode** %2, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 3
  %75 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %74, i32 0, i32 1
  %76 = getelementptr inbounds [2 x i32], [2 x i32]* %75, i64 0, i64 0
  %77 = load i32, i32* %76, align 4
  %78 = icmp ult i32 %72, %77
  br i1 %78, label %79, label %121

; <label>:79:                                     ; preds = %71
  store i32 0, i32* %5, align 4
  br label %80

; <label>:80:                                     ; preds = %113, %79
  %81 = load i32, i32* %5, align 4
  %82 = load %struct.tnode*, %struct.tnode** %2, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 3
  %84 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %83, i32 0, i32 1
  %85 = getelementptr inbounds [2 x i32], [2 x i32]* %84, i64 0, i64 1
  %86 = load i32, i32* %85, align 4
  %87 = icmp ult i32 %81, %86
  br i1 %87, label %88, label %116

; <label>:88:                                     ; preds = %80
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

; <label>:113:                                    ; preds = %88
  %114 = load i32, i32* %5, align 4
  %115 = add nsw i32 %114, 1
  store i32 %115, i32* %5, align 4
  br label %80

; <label>:116:                                    ; preds = %80
  %117 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i32 0, i32 0))
  br label %118

; <label>:118:                                    ; preds = %116
  %119 = load i32, i32* %4, align 4
  %120 = add nsw i32 %119, 1
  store i32 %120, i32* %4, align 4
  br label %71

; <label>:121:                                    ; preds = %71
  br label %124

; <label>:122:                                    ; preds = %63
  %123 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.46, i32 0, i32 0))
  br label %124

; <label>:124:                                    ; preds = %122, %121
  br label %125

; <label>:125:                                    ; preds = %124, %62
  br label %126

; <label>:126:                                    ; preds = %125, %11
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

; <label>:17:                                     ; preds = %1
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

; <label>:31:                                     ; preds = %1
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

; <label>:45:                                     ; preds = %31
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

; <label>:59:                                     ; preds = %31
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

; <label>:70:                                     ; preds = %59, %45, %17
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
  %11 = call %struct.__sFILE* @"\01_fopen"(i8* %10, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.47, i32 0, i32 0))
  store %struct.__sFILE* %11, %struct.__sFILE** %7, align 8
  %12 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %13 = icmp eq %struct.__sFILE* %12, null
  br i1 %13, label %14, label %17

; <label>:14:                                     ; preds = %3
  %15 = load i8*, i8** %6, align 8
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.48, i32 0, i32 0), i8* %15)
  call void @exit(i32 1) #4
  unreachable

; <label>:17:                                     ; preds = %3
  %18 = load i8*, i8** %6, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.49, i32 0, i32 0), i8* %18)
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

; <label>:31:                                     ; preds = %35, %17
  %32 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %33 = call i32 (%struct.__sFILE*, i8*, ...) @fscanf(%struct.__sFILE* %32, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.50, i32 0, i32 0), i32* %8)
  %34 = icmp eq i32 %33, 1
  br i1 %34, label %35, label %68

; <label>:35:                                     ; preds = %31
  %36 = load %struct.tpool*, %struct.tpool** %4, align 8
  %37 = getelementptr inbounds %struct.tpool, %struct.tpool* %36, i32 0, i32 1
  %38 = load i32, i32* %37, align 8
  %39 = load i32, i32* %8, align 4
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.51, i32 0, i32 0), i32 %38, i32 %39)
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

; <label>:68:                                     ; preds = %31
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
  %78 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.52, i32 0, i32 0), i32 %74, i32 %77)
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

; <label>:13:                                     ; preds = %43, %3
  %14 = load i32, i32* %8, align 4
  %15 = load i32, i32* %6, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %20

; <label>:17:                                     ; preds = %13
  %18 = load i32, i32* %8, align 4
  %19 = icmp slt i32 %18, 2
  br label %20

; <label>:20:                                     ; preds = %17, %13
  %21 = phi i1 [ false, %13 ], [ %19, %17 ]
  br i1 %21, label %22, label %46

; <label>:22:                                     ; preds = %20
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

; <label>:43:                                     ; preds = %22
  %44 = load i32, i32* %8, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, i32* %8, align 4
  br label %13

; <label>:46:                                     ; preds = %20
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
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.53, i32 0, i32 0), i32 %50, i32 %55, i32 %60)
  %62 = load i32, i32* %7, align 4
  %63 = load %struct.tnode*, %struct.tnode** %4, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 1
  %65 = load i32, i32* %64, align 4
  %66 = icmp ugt i32 %62, %65
  br i1 %66, label %67, label %72

; <label>:67:                                     ; preds = %46
  %68 = load %struct.tnode*, %struct.tnode** %4, align 8
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i32 0, i32 1
  %70 = load i32, i32* %69, align 4
  %71 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([66 x i8], [66 x i8]* @.str.54, i32 0, i32 0), i32 %70)
  br label %72

; <label>:72:                                     ; preds = %67, %46
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 6.0.1 (tags/RELEASE_601/final)"}
