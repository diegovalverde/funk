; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.tpool = type { [1024 x %struct.tdata], i32 }
%struct.tdata = type { i8, %union.data_type }
%union.data_type = type { double }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.tnode = type { i32, i32, %struct.tpool*, %struct.tdimensions }
%struct.tdimensions = type { i32, [2 x i32] }

@g_funk_debug_current_executed_line = global i32 0, align 4
@funk_types_str = global [7 x [100 x i8]] [[100 x i8] c"type_invalid\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_int\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_double\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_empty_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_scalar\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_function\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00"], align 16
@g_funk_print_array_max_elements = global i32 30, align 4
@g_funk_print_array_element_per_row = global i32 50, align 4
@g_funk_verbosity = global i32 0, align 4
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
@__FUNCTION__.funk_create_list = private unnamed_addr constant [17 x i8] c"funk_create_list\00", align 1
@__FUNCTION__.funk_create_2d_matrix = private unnamed_addr constant [22 x i8] c"funk_create_2d_matrix\00", align 1
@.str.8 = private unnamed_addr constant [27 x i8] c">>>>> %d %d pool_tail: %d\0A\00", align 1
@.str.9 = private unnamed_addr constant [16 x i8] c"%s %s[%d] = %d\0A\00", align 1
@__FUNCTION__.funk_create_int_scalar = private unnamed_addr constant [23 x i8] c"funk_create_int_scalar\00", align 1
@.str.10 = private unnamed_addr constant [6 x i8] c"gpool\00", align 1
@.str.11 = private unnamed_addr constant [6 x i8] c"fpool\00", align 1
@.str.12 = private unnamed_addr constant [24 x i8] c"Created node with type:\00", align 1
@.str.13 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@__FUNCTION__.funk_create_list_int_literal = private unnamed_addr constant [29 x i8] c"funk_create_list_int_literal\00", align 1
@__FUNCTION__.funk_create_2d_matrix_int_literal = private unnamed_addr constant [34 x i8] c"funk_create_2d_matrix_int_literal\00", align 1
@__FUNCTION__.funk_copy_element_from_pool = private unnamed_addr constant [28 x i8] c"funk_copy_element_from_pool\00", align 1
@.str.14 = private unnamed_addr constant [38 x i8] c"-E- Indexes %d, %d are out of bounds\0A\00", align 1
@.str.15 = private unnamed_addr constant [8 x i8] c" %9.9d \00", align 1
@.str.16 = private unnamed_addr constant [8 x i8] c" %9.9f \00", align 1
@.str.17 = private unnamed_addr constant [8 x i8] c" %9.9s \00", align 1
@.str.18 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str.19 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.20 = private unnamed_addr constant [10 x i8] c"%s %s[%d]\00", align 1
@__FUNCTION__.funk_get_node_type = private unnamed_addr constant [19 x i8] c"funk_get_node_type\00", align 1
@.str.21 = private unnamed_addr constant [43 x i8] c"-E- %s: offset %d out of bounds for len %d\00", align 1
@.str.22 = private unnamed_addr constant [3 x i8] c"\0A \00", align 1
@__FUNCTION__.funk_set_node_type = private unnamed_addr constant [19 x i8] c"funk_set_node_type\00", align 1
@__FUNCTION__.funk_set_node_value_int = private unnamed_addr constant [24 x i8] c"funk_set_node_value_int\00", align 1
@.str.23 = private unnamed_addr constant [25 x i8] c"%s %s start: %d len: %d\0A\00", align 1
@__FUNCTION__.funk_get_next_node = private unnamed_addr constant [19 x i8] c"funk_get_next_node\00", align 1
@.str.24 = private unnamed_addr constant [8 x i8] c"end %s\0A\00", align 1
@funk_debug_function_entry_hook.run_until_the_end = internal global i32 0, align 4
@.str.25 = private unnamed_addr constant [38 x i8] c"Stopped at the beginning of function\0A\00", align 1
@.str.26 = private unnamed_addr constant [2 x i8] c">\00", align 1
@__stdinp = external global %struct.__sFILE*, align 8
@.str.27 = private unnamed_addr constant [7 x i8] c"nostop\00", align 1
@.str.28 = private unnamed_addr constant [2 x i8] c"q\00", align 1
@.str.29 = private unnamed_addr constant [2 x i8] c"c\00", align 1
@.str.30 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.31 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.32 = private unnamed_addr constant [10 x i8] c" = %s[%d]\00", align 1
@.str.33 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
@__FUNCTION__.funk_add_ri = private unnamed_addr constant [12 x i8] c"funk_add_ri\00", align 1
@.str.34 = private unnamed_addr constant [54 x i8] c"-E- Invalid index %d is greater than array size of %d\00", align 1
@.str.35 = private unnamed_addr constant [34 x i8] c"-E- funk_mul_rr: invalid types:\0A \00", align 1
@.str.36 = private unnamed_addr constant [8 x i8] c"lit(%d)\00", align 1
@__FUNCTION__.funk_add_rr = private unnamed_addr constant [12 x i8] c"funk_add_rr\00", align 1
@.str.37 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.38 = private unnamed_addr constant [24 x i8] c"-E- %s: invalid types: \00", align 1
@__FUNCTION__.funk_mul_rr = private unnamed_addr constant [12 x i8] c"funk_mul_rr\00", align 1
@.str.39 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.40 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.41 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.42 = private unnamed_addr constant [4 x i8] c" [ \00", align 1
@.str.43 = private unnamed_addr constant [5 x i8] c" ]  \00", align 1
@.str.44 = private unnamed_addr constant [9 x i8] c" [...] \0A\00", align 1

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
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.is_list_consecutive_in_memory, i32 0, i32 0))
  %10 = load i32, i32* %5, align 4
  %11 = icmp sle i32 %10, 1
  br i1 %11, label %12, label %13

; <label>:12:                                     ; preds = %2
  store i32 1, i32* %3, align 4
  br label %39

; <label>:13:                                     ; preds = %2
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i64 0
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 0
  %17 = load i32, i32* %16, align 8
  store i32 %17, i32* %6, align 4
  store i32 1, i32* %7, align 4
  br label %18

; <label>:18:                                     ; preds = %35, %13
  %19 = load i32, i32* %7, align 4
  %20 = load i32, i32* %5, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %38

; <label>:22:                                     ; preds = %18
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = load i32, i32* %7, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i64 %25
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 0
  %28 = load i32, i32* %27, align 8
  store i32 %28, i32* %8, align 4
  %29 = load i32, i32* %6, align 4
  %30 = add nsw i32 %29, 1
  %31 = load i32, i32* %8, align 4
  %32 = icmp ne i32 %30, %31
  br i1 %32, label %33, label %34

; <label>:33:                                     ; preds = %22
  store i32 0, i32* %3, align 4
  br label %39

; <label>:34:                                     ; preds = %22
  br label %35

; <label>:35:                                     ; preds = %34
  %36 = load i32, i32* %7, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %7, align 4
  br label %18

; <label>:38:                                     ; preds = %18
  store i32 0, i32* %3, align 4
  br label %39

; <label>:39:                                     ; preds = %38, %33, %12
  %40 = load i32, i32* %3, align 4
  ret i32 %40
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
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_create_list, i32 0, i32 0))
  %11 = load %struct.tpool*, %struct.tpool** %5, align 8
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 2
  store %struct.tpool* %11, %struct.tpool** %13, align 8
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 3
  %16 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %15, i32 0, i32 0
  store i32 1, i32* %16, align 8
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = load i32, i32* %8, align 4
  %19 = call i32 @is_list_consecutive_in_memory(%struct.tnode* %17, i32 %18)
  %20 = icmp eq i32 %19, 1
  br i1 %20, label %21, label %31

; <label>:21:                                     ; preds = %4
  %22 = load %struct.tnode*, %struct.tnode** %7, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i64 0
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 0
  store i32 %25, i32* %27, align 8
  %28 = load i32, i32* %8, align 4
  %29 = load %struct.tnode*, %struct.tnode** %6, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  store i32 %28, i32* %30, align 4
  br label %83

; <label>:31:                                     ; preds = %4
  %32 = load %struct.tpool*, %struct.tpool** %5, align 8
  %33 = getelementptr inbounds %struct.tpool, %struct.tpool* %32, i32 0, i32 1
  %34 = load i32, i32* %33, align 8
  %35 = load %struct.tnode*, %struct.tnode** %6, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 0
  store i32 %34, i32* %36, align 8
  %37 = load i32, i32* %8, align 4
  %38 = load %struct.tnode*, %struct.tnode** %6, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  store i32 %37, i32* %39, align 4
  %40 = load %struct.tpool*, %struct.tpool** %5, align 8
  %41 = getelementptr inbounds %struct.tpool, %struct.tpool* %40, i32 0, i32 1
  %42 = load i32, i32* %41, align 8
  %43 = load i32, i32* %8, align 4
  %44 = add i32 %42, %43
  %45 = urem i32 %44, 1024
  %46 = load %struct.tpool*, %struct.tpool** %5, align 8
  %47 = getelementptr inbounds %struct.tpool, %struct.tpool* %46, i32 0, i32 1
  store i32 %45, i32* %47, align 8
  store i32 0, i32* %9, align 4
  br label %48

; <label>:48:                                     ; preds = %79, %31
  %49 = load i32, i32* %9, align 4
  %50 = load i32, i32* %8, align 4
  %51 = icmp slt i32 %49, %50
  br i1 %51, label %52, label %82

; <label>:52:                                     ; preds = %48
  %53 = load %struct.tpool*, %struct.tpool** %5, align 8
  %54 = getelementptr inbounds %struct.tpool, %struct.tpool* %53, i32 0, i32 0
  %55 = load %struct.tnode*, %struct.tnode** %6, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 0
  %57 = load i32, i32* %56, align 8
  %58 = load i32, i32* %9, align 4
  %59 = add i32 %57, %58
  %60 = zext i32 %59 to i64
  %61 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %54, i64 0, i64 %60
  %62 = load %struct.tnode*, %struct.tnode** %7, align 8
  %63 = load i32, i32* %9, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds %struct.tnode, %struct.tnode* %62, i64 %64
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 2
  %67 = load %struct.tpool*, %struct.tpool** %66, align 8
  %68 = getelementptr inbounds %struct.tpool, %struct.tpool* %67, i32 0, i32 0
  %69 = load %struct.tnode*, %struct.tnode** %7, align 8
  %70 = load i32, i32* %9, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i64 %71
  %73 = getelementptr inbounds %struct.tnode, %struct.tnode* %72, i32 0, i32 0
  %74 = load i32, i32* %73, align 8
  %75 = zext i32 %74 to i64
  %76 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %68, i64 0, i64 %75
  %77 = bitcast %struct.tdata* %61 to i8*
  %78 = bitcast %struct.tdata* %76 to i8*
  call void @memcpy(i8* %77, i8* %78, i64 16, i32 8, i1 false)
  br label %79

; <label>:79:                                     ; preds = %52
  %80 = load i32, i32* %9, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, i32* %9, align 4
  br label %48

; <label>:82:                                     ; preds = %48
  br label %83

; <label>:83:                                     ; preds = %82, %21
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @memcpy(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

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
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @__FUNCTION__.funk_create_2d_matrix, i32 0, i32 0))
  %12 = load %struct.tpool*, %struct.tpool** %6, align 8
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load %struct.tnode*, %struct.tnode** %8, align 8
  %15 = load i32, i32* %9, align 4
  %16 = load i32, i32* %10, align 4
  %17 = mul nsw i32 %15, %16
  call void @funk_create_list(%struct.tpool* %12, %struct.tnode* %13, %struct.tnode* %14, i32 %17)
  %18 = load %struct.tnode*, %struct.tnode** %7, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 3
  %20 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %19, i32 0, i32 0
  store i32 2, i32* %20, align 8
  %21 = load i32, i32* %9, align 4
  %22 = load %struct.tnode*, %struct.tnode** %7, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 3
  %24 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %23, i32 0, i32 1
  %25 = getelementptr inbounds [2 x i32], [2 x i32]* %24, i64 0, i64 0
  store i32 %21, i32* %25, align 4
  %26 = load i32, i32* %10, align 4
  %27 = load %struct.tnode*, %struct.tnode** %7, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 3
  %29 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %28, i32 0, i32 1
  %30 = getelementptr inbounds [2 x i32], [2 x i32]* %29, i64 0, i64 1
  store i32 %26, i32* %30, align 4
  %31 = load %struct.tnode*, %struct.tnode** %7, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = load %struct.tnode*, %struct.tnode** %7, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 1
  %36 = load i32, i32* %35, align 4
  %37 = load %struct.tpool*, %struct.tpool** %6, align 8
  %38 = getelementptr inbounds %struct.tpool, %struct.tpool* %37, i32 0, i32 1
  %39 = load i32, i32* %38, align 8
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.8, i32 0, i32 0), i32 %33, i32 %36, i32 %39)
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
  %7 = load %struct.tpool*, %struct.tpool** %4, align 8
  %8 = icmp eq %struct.tpool* %7, @funk_global_memory_pool
  %9 = zext i1 %8 to i64
  %10 = select i1 %8, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0)
  %11 = load %struct.tpool*, %struct.tpool** %4, align 8
  %12 = getelementptr inbounds %struct.tpool, %struct.tpool* %11, i32 0, i32 1
  %13 = load i32, i32* %12, align 8
  %14 = load i32, i32* %6, align 4
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.9, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_int_scalar, i32 0, i32 0), i8* %10, i32 %13, i32 %14)
  %16 = load %struct.tpool*, %struct.tpool** %4, align 8
  %17 = getelementptr inbounds %struct.tpool, %struct.tpool* %16, i32 0, i32 1
  %18 = load i32, i32* %17, align 8
  %19 = load %struct.tnode*, %struct.tnode** %5, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 0
  store i32 %18, i32* %20, align 8
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  store i32 1, i32* %22, align 4
  %23 = load %struct.tpool*, %struct.tpool** %4, align 8
  %24 = load %struct.tnode*, %struct.tnode** %5, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 2
  store %struct.tpool* %23, %struct.tpool** %25, align 8
  %26 = load %struct.tnode*, %struct.tnode** %5, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 3
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 0
  store i32 1, i32* %28, align 8
  %29 = load %struct.tpool*, %struct.tpool** %4, align 8
  %30 = getelementptr inbounds %struct.tpool, %struct.tpool* %29, i32 0, i32 1
  %31 = load i32, i32* %30, align 8
  %32 = add i32 %31, 1
  %33 = urem i32 %32, 1024
  %34 = load %struct.tpool*, %struct.tpool** %4, align 8
  %35 = getelementptr inbounds %struct.tpool, %struct.tpool* %34, i32 0, i32 1
  store i32 %33, i32* %35, align 8
  %36 = load %struct.tpool*, %struct.tpool** %4, align 8
  %37 = getelementptr inbounds %struct.tpool, %struct.tpool* %36, i32 0, i32 0
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 0
  %40 = load i32, i32* %39, align 8
  %41 = zext i32 %40 to i64
  %42 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %37, i64 0, i64 %41
  %43 = getelementptr inbounds %struct.tdata, %struct.tdata* %42, i32 0, i32 0
  store i8 1, i8* %43, align 8
  %44 = load i32, i32* %6, align 4
  %45 = load %struct.tpool*, %struct.tpool** %4, align 8
  %46 = getelementptr inbounds %struct.tpool, %struct.tpool* %45, i32 0, i32 0
  %47 = load %struct.tnode*, %struct.tnode** %5, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 0
  %49 = load i32, i32* %48, align 8
  %50 = zext i32 %49 to i64
  %51 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %46, i64 0, i64 %50
  %52 = getelementptr inbounds %struct.tdata, %struct.tdata* %51, i32 0, i32 1
  %53 = bitcast %union.data_type* %52 to i32*
  store i32 %44, i32* %53, align 8
  %54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.12, i32 0, i32 0))
  %55 = load %struct.tnode*, %struct.tnode** %5, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 2
  %57 = load %struct.tpool*, %struct.tpool** %56, align 8
  %58 = getelementptr inbounds %struct.tpool, %struct.tpool* %57, i32 0, i32 0
  %59 = load %struct.tnode*, %struct.tnode** %5, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 0
  %61 = load i32, i32* %60, align 8
  %62 = zext i32 %61 to i64
  %63 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %58, i64 0, i64 %62
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 0
  %65 = load i8, i8* %64, align 8
  call void @funk_print_type(i8 zeroext %65)
  %66 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i32 0, i32 0))
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
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @__FUNCTION__.funk_create_list_int_literal, i32 0, i32 0))
  %11 = load %struct.tpool*, %struct.tpool** %5, align 8
  %12 = getelementptr inbounds %struct.tpool, %struct.tpool* %11, i32 0, i32 1
  %13 = load i32, i32* %12, align 8
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 0
  store i32 %13, i32* %15, align 8
  %16 = load i32, i32* %8, align 4
  %17 = load %struct.tnode*, %struct.tnode** %6, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 1
  store i32 %16, i32* %18, align 4
  %19 = load %struct.tpool*, %struct.tpool** %5, align 8
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 2
  store %struct.tpool* %19, %struct.tpool** %21, align 8
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 3
  %24 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %23, i32 0, i32 0
  store i32 1, i32* %24, align 8
  %25 = load %struct.tpool*, %struct.tpool** %5, align 8
  %26 = getelementptr inbounds %struct.tpool, %struct.tpool* %25, i32 0, i32 1
  %27 = load i32, i32* %26, align 8
  %28 = load i32, i32* %8, align 4
  %29 = add i32 %27, %28
  %30 = urem i32 %29, 1024
  %31 = load %struct.tpool*, %struct.tpool** %5, align 8
  %32 = getelementptr inbounds %struct.tpool, %struct.tpool* %31, i32 0, i32 1
  store i32 %30, i32* %32, align 8
  store i32 0, i32* %9, align 4
  br label %33

; <label>:33:                                     ; preds = %64, %4
  %34 = load i32, i32* %9, align 4
  %35 = load i32, i32* %8, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %67

; <label>:37:                                     ; preds = %33
  %38 = load %struct.tpool*, %struct.tpool** %5, align 8
  %39 = getelementptr inbounds %struct.tpool, %struct.tpool* %38, i32 0, i32 0
  %40 = load %struct.tnode*, %struct.tnode** %6, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 0
  %42 = load i32, i32* %41, align 8
  %43 = load i32, i32* %9, align 4
  %44 = add i32 %42, %43
  %45 = zext i32 %44 to i64
  %46 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %39, i64 0, i64 %45
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 0
  store i8 1, i8* %47, align 8
  %48 = load i32*, i32** %7, align 8
  %49 = load i32, i32* %9, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds i32, i32* %48, i64 %50
  %52 = load i32, i32* %51, align 4
  %53 = load %struct.tpool*, %struct.tpool** %5, align 8
  %54 = getelementptr inbounds %struct.tpool, %struct.tpool* %53, i32 0, i32 0
  %55 = load %struct.tnode*, %struct.tnode** %6, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 0
  %57 = load i32, i32* %56, align 8
  %58 = load i32, i32* %9, align 4
  %59 = add i32 %57, %58
  %60 = zext i32 %59 to i64
  %61 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %54, i64 0, i64 %60
  %62 = getelementptr inbounds %struct.tdata, %struct.tdata* %61, i32 0, i32 1
  %63 = bitcast %union.data_type* %62 to i32*
  store i32 %52, i32* %63, align 8
  br label %64

; <label>:64:                                     ; preds = %37
  %65 = load i32, i32* %9, align 4
  %66 = add nsw i32 %65, 1
  store i32 %66, i32* %9, align 4
  br label %33

; <label>:67:                                     ; preds = %33
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
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @__FUNCTION__.funk_create_2d_matrix_int_literal, i32 0, i32 0))
  %12 = load %struct.tpool*, %struct.tpool** %6, align 8
  %13 = load %struct.tnode*, %struct.tnode** %7, align 8
  %14 = load i32*, i32** %8, align 8
  %15 = load i32, i32* %9, align 4
  %16 = load i32, i32* %10, align 4
  %17 = mul nsw i32 %15, %16
  call void @funk_create_list_int_literal(%struct.tpool* %12, %struct.tnode* %13, i32* %14, i32 %17)
  %18 = load %struct.tnode*, %struct.tnode** %7, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 3
  %20 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %19, i32 0, i32 0
  store i32 2, i32* %20, align 8
  %21 = load i32, i32* %9, align 4
  %22 = load %struct.tnode*, %struct.tnode** %7, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 3
  %24 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %23, i32 0, i32 1
  %25 = getelementptr inbounds [2 x i32], [2 x i32]* %24, i64 0, i64 0
  store i32 %21, i32* %25, align 4
  %26 = load i32, i32* %10, align 4
  %27 = load %struct.tnode*, %struct.tnode** %7, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 3
  %29 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %28, i32 0, i32 1
  %30 = getelementptr inbounds [2 x i32], [2 x i32]* %29, i64 0, i64 1
  store i32 %26, i32* %30, align 4
  %31 = load %struct.tnode*, %struct.tnode** %7, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = load %struct.tnode*, %struct.tnode** %7, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 1
  %36 = load i32, i32* %35, align 4
  %37 = load %struct.tpool*, %struct.tpool** %6, align 8
  %38 = getelementptr inbounds %struct.tpool, %struct.tpool* %37, i32 0, i32 1
  %39 = load i32, i32* %38, align 8
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.8, i32 0, i32 0), i32 %33, i32 %36, i32 %39)
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
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__FUNCTION__.funk_copy_element_from_pool, i32 0, i32 0))
  %13 = load %struct.tnode*, %struct.tnode** %8, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 3
  %15 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %14, i32 0, i32 1
  %16 = getelementptr inbounds [2 x i32], [2 x i32]* %15, i64 0, i64 0
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* %9, align 4
  %19 = mul i32 %17, %18
  %20 = load i32, i32* %10, align 4
  %21 = add i32 %19, %20
  store i32 %21, i32* %11, align 4
  %22 = load i32, i32* %11, align 4
  %23 = load %struct.tnode*, %struct.tnode** %8, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = icmp uge i32 %22, %25
  br i1 %26, label %27, label %31

; <label>:27:                                     ; preds = %5
  %28 = load i32, i32* %9, align 4
  %29 = load i32, i32* %10, align 4
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.14, i32 0, i32 0), i32 %28, i32 %29)
  br label %41

; <label>:31:                                     ; preds = %5
  %32 = load %struct.tnode*, %struct.tnode** %8, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 0
  %34 = load i32, i32* %33, align 8
  %35 = load i32, i32* %11, align 4
  %36 = add i32 %34, %35
  %37 = load %struct.tnode*, %struct.tnode** %7, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 0
  store i32 %36, i32* %38, align 8
  %39 = load %struct.tnode*, %struct.tnode** %7, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 1
  store i32 1, i32* %40, align 4
  br label %41

; <label>:41:                                     ; preds = %31, %27
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
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.15, i32 0, i32 0), i32 %13)
  br label %24

; <label>:15:                                     ; preds = %2
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.16, i32 0, i32 0), double %18)
  br label %24

; <label>:20:                                     ; preds = %2
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.18, i32 0, i32 0))
  br label %24

; <label>:22:                                     ; preds = %2
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.19, i32 0, i32 0))
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
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 2
  %9 = load %struct.tpool*, %struct.tpool** %8, align 8
  %10 = icmp eq %struct.tpool* %9, @funk_global_memory_pool
  %11 = zext i1 %10 to i64
  %12 = select i1 %10, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0)
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 0
  %15 = load i32, i32* %14, align 8
  %16 = load i32, i32* %5, align 4
  %17 = add i32 %15, %16
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.20, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i32 0, i32 0), i8* %12, i32 %17)
  %19 = load i32, i32* %5, align 4
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 4
  %23 = icmp uge i32 %19, %22
  br i1 %23, label %24, label %30

; <label>:24:                                     ; preds = %3
  %25 = load i32, i32* %5, align 4
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = load i32, i32* %27, align 4
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.21, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i32 0, i32 0), i32 %25, i32 %28)
  br label %30

; <label>:30:                                     ; preds = %24, %3
  %31 = load %struct.tnode*, %struct.tnode** %4, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 2
  %33 = load %struct.tpool*, %struct.tpool** %32, align 8
  %34 = getelementptr inbounds %struct.tpool, %struct.tpool* %33, i32 0, i32 0
  %35 = load %struct.tnode*, %struct.tnode** %4, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 0
  %37 = load i32, i32* %36, align 8
  %38 = load i32, i32* %5, align 4
  %39 = add i32 %37, %38
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %34, i64 0, i64 %40
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  %43 = load i8, i8* %42, align 8
  %44 = load i8*, i8** %6, align 8
  store i8 %43, i8* %44, align 1
  %45 = load i8*, i8** %6, align 8
  %46 = load i8, i8* %45, align 1
  call void @funk_print_type(i8 zeroext %46)
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.22, i32 0, i32 0))
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
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i32 0, i32 0))
  %8 = load i32, i32* %5, align 4
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = icmp uge i32 %8, %11
  br i1 %12, label %13, label %19

; <label>:13:                                     ; preds = %3
  %14 = load i32, i32* %5, align 4
  %15 = load %struct.tnode*, %struct.tnode** %4, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 1
  %17 = load i32, i32* %16, align 4
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.21, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i32 0, i32 0), i32 %14, i32 %17)
  br label %19

; <label>:19:                                     ; preds = %13, %3
  %20 = load i8, i8* %6, align 1
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 2
  %23 = load %struct.tpool*, %struct.tpool** %22, align 8
  %24 = getelementptr inbounds %struct.tpool, %struct.tpool* %23, i32 0, i32 0
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 0
  %27 = load i32, i32* %26, align 8
  %28 = load i32, i32* %5, align 4
  %29 = add i32 %27, %28
  %30 = zext i32 %29 to i64
  %31 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %24, i64 0, i64 %30
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  store i8 %20, i8* %32, align 8
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
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i32 0, i32 0))
  %8 = load i32, i32* %5, align 4
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = icmp uge i32 %8, %11
  br i1 %12, label %13, label %19

; <label>:13:                                     ; preds = %3
  %14 = load i32, i32* %5, align 4
  %15 = load %struct.tnode*, %struct.tnode** %4, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 1
  %17 = load i32, i32* %16, align 4
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.21, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i32 0, i32 0), i32 %14, i32 %17)
  br label %19

; <label>:19:                                     ; preds = %13, %3
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 2
  %22 = load %struct.tpool*, %struct.tpool** %21, align 8
  %23 = getelementptr inbounds %struct.tpool, %struct.tpool* %22, i32 0, i32 0
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = load i32, i32* %5, align 4
  %28 = add i32 %26, %27
  %29 = zext i32 %28 to i64
  %30 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %23, i64 0, i64 %29
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  store i8 1, i8* %31, align 8
  %32 = load i32, i32* %6, align 4
  %33 = load %struct.tnode*, %struct.tnode** %4, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 2
  %35 = load %struct.tpool*, %struct.tpool** %34, align 8
  %36 = getelementptr inbounds %struct.tpool, %struct.tpool* %35, i32 0, i32 0
  %37 = load %struct.tnode*, %struct.tnode** %4, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 0
  %39 = load i32, i32* %38, align 8
  %40 = load i32, i32* %5, align 4
  %41 = add i32 %39, %40
  %42 = zext i32 %41 to i64
  %43 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %36, i64 0, i64 %42
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 1
  %45 = bitcast %union.data_type* %44 to i32*
  store i32 %32, i32* %45, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @foo() #0 {
  %1 = alloca %struct.tnode, align 8
  %2 = alloca i32, align 4
  store i32 777, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  call void @funk_set_node_value_int(%struct.tnode* %1, i32 0, i32 %3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_pool(%struct.tpool*) #0 {
  %2 = alloca %struct.tpool*, align 8
  %3 = alloca i32, align 4
  store %struct.tpool* %0, %struct.tpool** %2, align 8
  store i32 0, i32* %3, align 4
  br label %4

; <label>:4:                                      ; preds = %27, %1
  %5 = load i32, i32* %3, align 4
  %6 = icmp slt i32 %5, 64
  br i1 %6, label %7, label %30

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
  br i1 %19, label %20, label %26

; <label>:20:                                     ; preds = %7
  %21 = load i32, i32* %3, align 4
  %22 = srem i32 %21, 7
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %24, label %26

; <label>:24:                                     ; preds = %20
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i32 0, i32 0))
  br label %26

; <label>:26:                                     ; preds = %24, %20, %7
  br label %27

; <label>:27:                                     ; preds = %26
  %28 = load i32, i32* %3, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %3, align 4
  br label %4

; <label>:30:                                     ; preds = %4
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i32 0, i32 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_next_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %5 = load %struct.tnode*, %struct.tnode** %4, align 8
  %6 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 2
  %7 = load %struct.tpool*, %struct.tpool** %6, align 8
  %8 = icmp eq %struct.tpool* %7, @funk_global_memory_pool
  %9 = zext i1 %8 to i64
  %10 = select i1 %8, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0)
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 0
  %13 = load i32, i32* %12, align 8
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.23, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_next_node, i32 0, i32 0), i8* %10, i32 %13, i32 %16)
  %18 = load %struct.tnode*, %struct.tnode** %4, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 2
  %20 = load %struct.tpool*, %struct.tpool** %19, align 8
  %21 = load %struct.tnode*, %struct.tnode** %3, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 2
  store %struct.tpool* %20, %struct.tpool** %22, align 8
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %56

; <label>:27:                                     ; preds = %2
  %28 = load %struct.tnode*, %struct.tnode** %4, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 0
  %30 = load i32, i32* %29, align 8
  %31 = load %struct.tnode*, %struct.tnode** %3, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 0
  store i32 %30, i32* %32, align 8
  %33 = load %struct.tnode*, %struct.tnode** %3, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 1
  store i32 1, i32* %34, align 4
  %35 = load %struct.tnode*, %struct.tnode** %3, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 2
  %37 = load %struct.tpool*, %struct.tpool** %36, align 8
  %38 = getelementptr inbounds %struct.tpool, %struct.tpool* %37, i32 0, i32 0
  %39 = load %struct.tnode*, %struct.tnode** %3, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 0
  %41 = load i32, i32* %40, align 8
  %42 = zext i32 %41 to i64
  %43 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %38, i64 0, i64 %42
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 0
  store i8 4, i8* %44, align 8
  %45 = load %struct.tnode*, %struct.tnode** %3, align 8
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %45, i32 0, i32 2
  %47 = load %struct.tpool*, %struct.tpool** %46, align 8
  %48 = getelementptr inbounds %struct.tpool, %struct.tpool* %47, i32 0, i32 0
  %49 = load %struct.tnode*, %struct.tnode** %3, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 0
  %51 = load i32, i32* %50, align 8
  %52 = zext i32 %51 to i64
  %53 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %48, i64 0, i64 %52
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 1
  %55 = bitcast %union.data_type* %54 to i32*
  store i32 0, i32* %55, align 8
  br label %69

; <label>:56:                                     ; preds = %2
  %57 = load %struct.tnode*, %struct.tnode** %4, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 1
  %59 = load i32, i32* %58, align 4
  %60 = sub i32 %59, 1
  %61 = load %struct.tnode*, %struct.tnode** %3, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 1
  store i32 %60, i32* %62, align 4
  %63 = load %struct.tnode*, %struct.tnode** %4, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 0
  %65 = load i32, i32* %64, align 8
  %66 = add i32 %65, 1
  %67 = load %struct.tnode*, %struct.tnode** %3, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 0
  store i32 %66, i32* %68, align 8
  br label %69

; <label>:69:                                     ; preds = %56, %27
  %70 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.24, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_next_node, i32 0, i32 0))
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
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.25, i32 0, i32 0))
  br label %7

; <label>:7:                                      ; preds = %35, %5
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.26, i32 0, i32 0))
  %9 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %10 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8
  %11 = call i8* @fgets(i8* %9, i32 8, %struct.__sFILE* %10)
  %12 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %13 = call i32 @strncmp(i8* %12, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i64 5)
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %16, label %15

; <label>:15:                                     ; preds = %7
  call void @funk_print_pool(%struct.tpool* @funk_global_memory_pool)
  br label %34

; <label>:16:                                     ; preds = %7
  %17 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %18 = call i32 @strncmp(i8* %17, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0), i64 5)
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %21, label %20

; <label>:20:                                     ; preds = %16
  call void @funk_print_pool(%struct.tpool* @funk_functions_memory_pool)
  br label %33

; <label>:21:                                     ; preds = %16
  %22 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %23 = call i32 @strncmp(i8* %22, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.27, i32 0, i32 0), i64 6)
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %26, label %25

; <label>:25:                                     ; preds = %21
  store i32 1, i32* @funk_debug_function_entry_hook.run_until_the_end, align 4
  br label %32

; <label>:26:                                     ; preds = %21
  %27 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %28 = call i32 @strncmp(i8* %27, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.28, i32 0, i32 0), i64 1)
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
  %37 = call i32 @strncmp(i8* %36, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.29, i32 0, i32 0), i64 1)
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
  %18 = select i1 %16, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0)
  %19 = load %struct.tnode*, %struct.tnode** %9, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = load i32, i32* %10, align 4
  %23 = add i32 %21, %22
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.30, i32 0, i32 0), i8* %18, i32 %23)
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
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.31, i32 0, i32 0))
  %42 = load %struct.tnode*, %struct.tnode** %11, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 2
  %44 = load %struct.tpool*, %struct.tpool** %43, align 8
  %45 = icmp eq %struct.tpool* %44, @funk_global_memory_pool
  %46 = zext i1 %45 to i64
  %47 = select i1 %45, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0)
  %48 = load %struct.tnode*, %struct.tnode** %11, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 0
  %50 = load i32, i32* %49, align 8
  %51 = load i32, i32* %12, align 4
  %52 = add i32 %50, %51
  %53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.30, i32 0, i32 0), i8* %47, i32 %52)
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
  %75 = select i1 %73, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0)
  %76 = load %struct.tnode*, %struct.tnode** %7, align 8
  %77 = getelementptr inbounds %struct.tnode, %struct.tnode* %76, i32 0, i32 0
  %78 = load i32, i32* %77, align 8
  %79 = load i32, i32* %8, align 4
  %80 = add i32 %78, %79
  %81 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.32, i32 0, i32 0), i8* %75, i32 %80)
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
  %98 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.33, i32 0, i32 0))
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
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__FUNCTION__.funk_add_ri, i32 0, i32 0))
  %15 = load i32, i32* %9, align 4
  %16 = load %struct.tnode*, %struct.tnode** %8, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 1
  %18 = load i32, i32* %17, align 4
  %19 = icmp ugt i32 %15, %18
  br i1 %19, label %20, label %26

; <label>:20:                                     ; preds = %5
  %21 = load i32, i32* %9, align 4
  %22 = load %struct.tnode*, %struct.tnode** %8, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 1
  %24 = load i32, i32* %23, align 4
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.34, i32 0, i32 0), i32 %21, i32 %24)
  br label %26

; <label>:26:                                     ; preds = %20, %5
  %27 = load i32, i32* %7, align 4
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 1
  %30 = load i32, i32* %29, align 4
  %31 = icmp ugt i32 %27, %30
  br i1 %31, label %32, label %38

; <label>:32:                                     ; preds = %26
  %33 = load i32, i32* %7, align 4
  %34 = load %struct.tnode*, %struct.tnode** %6, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 1
  %36 = load i32, i32* %35, align 4
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.34, i32 0, i32 0), i32 %33, i32 %36)
  br label %38

; <label>:38:                                     ; preds = %32, %26
  %39 = load %struct.tnode*, %struct.tnode** %8, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 2
  %41 = load %struct.tpool*, %struct.tpool** %40, align 8
  %42 = getelementptr inbounds %struct.tpool, %struct.tpool* %41, i32 0, i32 0
  %43 = load %struct.tnode*, %struct.tnode** %8, align 8
  %44 = getelementptr inbounds %struct.tnode, %struct.tnode* %43, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = load i32, i32* %9, align 4
  %47 = add i32 %45, %46
  %48 = zext i32 %47 to i64
  %49 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %42, i64 0, i64 %48
  %50 = bitcast %struct.tdata* %11 to i8*
  %51 = bitcast %struct.tdata* %49 to i8*
  call void @memcpy(i8* %50, i8* %51, i64 16, i32 8, i1 false)
  %52 = load %struct.tnode*, %struct.tnode** %6, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 2
  %54 = load %struct.tpool*, %struct.tpool** %53, align 8
  %55 = getelementptr inbounds %struct.tpool, %struct.tpool* %54, i32 0, i32 0
  %56 = load %struct.tnode*, %struct.tnode** %6, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 0
  %58 = load i32, i32* %57, align 8
  %59 = load i32, i32* %7, align 4
  %60 = add i32 %58, %59
  %61 = zext i32 %60 to i64
  %62 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %55, i64 0, i64 %61
  store %struct.tdata* %62, %struct.tdata** %12, align 8
  %63 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 0
  %64 = load i8, i8* %63, align 8
  store i8 %64, i8* %13, align 1
  %65 = load i8, i8* %13, align 1
  %66 = zext i8 %65 to i32
  %67 = icmp eq i32 %66, 1
  br i1 %67, label %68, label %79

; <label>:68:                                     ; preds = %38
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 1
  %70 = bitcast %union.data_type* %69 to i32*
  %71 = load i32, i32* %70, align 8
  %72 = load i32, i32* %10, align 4
  %73 = add nsw i32 %71, %72
  %74 = load %struct.tdata*, %struct.tdata** %12, align 8
  %75 = getelementptr inbounds %struct.tdata, %struct.tdata* %74, i32 0, i32 1
  %76 = bitcast %union.data_type* %75 to i32*
  store i32 %73, i32* %76, align 8
  %77 = load %struct.tdata*, %struct.tdata** %12, align 8
  %78 = getelementptr inbounds %struct.tdata, %struct.tdata* %77, i32 0, i32 0
  store i8 1, i8* %78, align 8
  br label %100

; <label>:79:                                     ; preds = %38
  %80 = load i8, i8* %13, align 1
  %81 = zext i8 %80 to i32
  %82 = icmp eq i32 %81, 2
  br i1 %82, label %83, label %95

; <label>:83:                                     ; preds = %79
  %84 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 1
  %85 = bitcast %union.data_type* %84 to double*
  %86 = load double, double* %85, align 8
  %87 = load i32, i32* %10, align 4
  %88 = sitofp i32 %87 to double
  %89 = fadd double %86, %88
  %90 = load %struct.tdata*, %struct.tdata** %12, align 8
  %91 = getelementptr inbounds %struct.tdata, %struct.tdata* %90, i32 0, i32 1
  %92 = bitcast %union.data_type* %91 to double*
  store double %89, double* %92, align 8
  %93 = load %struct.tdata*, %struct.tdata** %12, align 8
  %94 = getelementptr inbounds %struct.tdata, %struct.tdata* %93, i32 0, i32 0
  store i8 2, i8* %94, align 8
  br label %99

; <label>:95:                                     ; preds = %79
  %96 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.35, i32 0, i32 0))
  %97 = load %struct.tdata*, %struct.tdata** %12, align 8
  %98 = getelementptr inbounds %struct.tdata, %struct.tdata* %97, i32 0, i32 0
  store i8 0, i8* %98, align 8
  br label %99

; <label>:99:                                     ; preds = %95, %83
  br label %100

; <label>:100:                                    ; preds = %99, %68
  %101 = load %struct.tnode*, %struct.tnode** %8, align 8
  %102 = getelementptr inbounds %struct.tnode, %struct.tnode* %101, i32 0, i32 2
  %103 = load %struct.tpool*, %struct.tpool** %102, align 8
  %104 = icmp eq %struct.tpool* %103, @funk_global_memory_pool
  %105 = zext i1 %104 to i64
  %106 = select i1 %104, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0)
  %107 = load %struct.tnode*, %struct.tnode** %8, align 8
  %108 = getelementptr inbounds %struct.tnode, %struct.tnode* %107, i32 0, i32 0
  %109 = load i32, i32* %108, align 8
  %110 = load i32, i32* %9, align 4
  %111 = add i32 %109, %110
  %112 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.30, i32 0, i32 0), i8* %106, i32 %111)
  %113 = bitcast %struct.tdata* %11 to { i8, i64 }*
  %114 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %113, i32 0, i32 0
  %115 = load i8, i8* %114, align 8
  %116 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %113, i32 0, i32 1
  %117 = load i64, i64* %116, align 8
  call void @funk_print_scalar_element(i8 %115, i64 %117)
  %118 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.31, i32 0, i32 0))
  %119 = load i32, i32* %10, align 4
  %120 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.36, i32 0, i32 0), i32 %119)
  %121 = load %struct.tnode*, %struct.tnode** %6, align 8
  %122 = getelementptr inbounds %struct.tnode, %struct.tnode* %121, i32 0, i32 2
  %123 = load %struct.tpool*, %struct.tpool** %122, align 8
  %124 = icmp eq %struct.tpool* %123, @funk_global_memory_pool
  %125 = zext i1 %124 to i64
  %126 = select i1 %124, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.11, i32 0, i32 0)
  %127 = load %struct.tnode*, %struct.tnode** %6, align 8
  %128 = getelementptr inbounds %struct.tnode, %struct.tnode* %127, i32 0, i32 0
  %129 = load i32, i32* %128, align 8
  %130 = load i32, i32* %7, align 4
  %131 = add i32 %129, %130
  %132 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.32, i32 0, i32 0), i8* %126, i32 %131)
  %133 = load %struct.tdata*, %struct.tdata** %12, align 8
  %134 = bitcast %struct.tdata* %133 to { i8, i64 }*
  %135 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %134, i32 0, i32 0
  %136 = load i8, i8* %135, align 8
  %137 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %134, i32 0, i32 1
  %138 = load i64, i64* %137, align 8
  call void @funk_print_scalar_element(i8 %136, i64 %138)
  %139 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.33, i32 0, i32 0))
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
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__FUNCTION__.funk_add_rr, i32 0, i32 0))
  %19 = load i32, i32* %10, align 4
  %20 = load %struct.tnode*, %struct.tnode** %9, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 4
  %23 = icmp ugt i32 %19, %22
  br i1 %23, label %24, label %30

; <label>:24:                                     ; preds = %6
  %25 = load i32, i32* %10, align 4
  %26 = load %struct.tnode*, %struct.tnode** %9, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = load i32, i32* %27, align 4
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.34, i32 0, i32 0), i32 %25, i32 %28)
  br label %30

; <label>:30:                                     ; preds = %24, %6
  %31 = load i32, i32* %12, align 4
  %32 = load %struct.tnode*, %struct.tnode** %11, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = load i32, i32* %33, align 4
  %35 = icmp ugt i32 %31, %34
  br i1 %35, label %36, label %42

; <label>:36:                                     ; preds = %30
  %37 = load i32, i32* %12, align 4
  %38 = load %struct.tnode*, %struct.tnode** %11, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.34, i32 0, i32 0), i32 %37, i32 %40)
  br label %42

; <label>:42:                                     ; preds = %36, %30
  %43 = load i32, i32* %8, align 4
  %44 = load %struct.tnode*, %struct.tnode** %7, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  %46 = load i32, i32* %45, align 4
  %47 = icmp ugt i32 %43, %46
  br i1 %47, label %48, label %54

; <label>:48:                                     ; preds = %42
  %49 = load i32, i32* %8, align 4
  %50 = load %struct.tnode*, %struct.tnode** %7, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 1
  %52 = load i32, i32* %51, align 4
  %53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.34, i32 0, i32 0), i32 %49, i32 %52)
  br label %54

; <label>:54:                                     ; preds = %48, %42
  %55 = load %struct.tnode*, %struct.tnode** %9, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 2
  %57 = load %struct.tpool*, %struct.tpool** %56, align 8
  %58 = getelementptr inbounds %struct.tpool, %struct.tpool* %57, i32 0, i32 0
  %59 = load %struct.tnode*, %struct.tnode** %9, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 0
  %61 = load i32, i32* %60, align 8
  %62 = load i32, i32* %10, align 4
  %63 = add i32 %61, %62
  %64 = zext i32 %63 to i64
  %65 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %58, i64 0, i64 %64
  %66 = bitcast %struct.tdata* %13 to i8*
  %67 = bitcast %struct.tdata* %65 to i8*
  call void @memcpy(i8* %66, i8* %67, i64 16, i32 8, i1 false)
  %68 = load %struct.tnode*, %struct.tnode** %11, align 8
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i32 0, i32 2
  %70 = load %struct.tpool*, %struct.tpool** %69, align 8
  %71 = getelementptr inbounds %struct.tpool, %struct.tpool* %70, i32 0, i32 0
  %72 = load %struct.tnode*, %struct.tnode** %11, align 8
  %73 = getelementptr inbounds %struct.tnode, %struct.tnode* %72, i32 0, i32 0
  %74 = load i32, i32* %73, align 8
  %75 = load i32, i32* %12, align 4
  %76 = add i32 %74, %75
  %77 = zext i32 %76 to i64
  %78 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %71, i64 0, i64 %77
  %79 = bitcast %struct.tdata* %14 to i8*
  %80 = bitcast %struct.tdata* %78 to i8*
  call void @memcpy(i8* %79, i8* %80, i64 16, i32 8, i1 false)
  %81 = load %struct.tnode*, %struct.tnode** %7, align 8
  %82 = getelementptr inbounds %struct.tnode, %struct.tnode* %81, i32 0, i32 2
  %83 = load %struct.tpool*, %struct.tpool** %82, align 8
  %84 = getelementptr inbounds %struct.tpool, %struct.tpool* %83, i32 0, i32 0
  %85 = load %struct.tnode*, %struct.tnode** %7, align 8
  %86 = getelementptr inbounds %struct.tnode, %struct.tnode* %85, i32 0, i32 0
  %87 = load i32, i32* %86, align 8
  %88 = load i32, i32* %8, align 4
  %89 = add i32 %87, %88
  %90 = zext i32 %89 to i64
  %91 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %84, i64 0, i64 %90
  store %struct.tdata* %91, %struct.tdata** %15, align 8
  %92 = bitcast %struct.tdata* %13 to { i8, i64 }*
  %93 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %92, i32 0, i32 0
  %94 = load i8, i8* %93, align 8
  %95 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %92, i32 0, i32 1
  %96 = load i64, i64* %95, align 8
  call void @funk_print_scalar_element(i8 %94, i64 %96)
  %97 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.37, i32 0, i32 0))
  %98 = bitcast %struct.tdata* %14 to { i8, i64 }*
  %99 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %98, i32 0, i32 0
  %100 = load i8, i8* %99, align 8
  %101 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %98, i32 0, i32 1
  %102 = load i64, i64* %101, align 8
  call void @funk_print_scalar_element(i8 %100, i64 %102)
  %103 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 0
  %104 = load i8, i8* %103, align 8
  store i8 %104, i8* %16, align 1
  %105 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %106 = load i8, i8* %105, align 8
  store i8 %106, i8* %17, align 1
  %107 = load i8, i8* %17, align 1
  %108 = zext i8 %107 to i32
  %109 = icmp eq i32 %108, 4
  br i1 %109, label %110, label %111

; <label>:110:                                    ; preds = %54
  store i8 1, i8* %17, align 1
  br label %111

; <label>:111:                                    ; preds = %110, %54
  %112 = load i8, i8* %16, align 1
  %113 = zext i8 %112 to i32
  %114 = icmp eq i32 %113, 4
  br i1 %114, label %115, label %116

; <label>:115:                                    ; preds = %111
  store i8 1, i8* %16, align 1
  br label %116

; <label>:116:                                    ; preds = %115, %111
  %117 = load i8, i8* %16, align 1
  %118 = zext i8 %117 to i32
  %119 = icmp eq i32 %118, 1
  br i1 %119, label %120, label %137

; <label>:120:                                    ; preds = %116
  %121 = load i8, i8* %17, align 1
  %122 = zext i8 %121 to i32
  %123 = icmp eq i32 %122, 1
  br i1 %123, label %124, label %137

; <label>:124:                                    ; preds = %120
  %125 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %126 = bitcast %union.data_type* %125 to i32*
  %127 = load i32, i32* %126, align 8
  %128 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %129 = bitcast %union.data_type* %128 to i32*
  %130 = load i32, i32* %129, align 8
  %131 = add nsw i32 %127, %130
  %132 = load %struct.tdata*, %struct.tdata** %15, align 8
  %133 = getelementptr inbounds %struct.tdata, %struct.tdata* %132, i32 0, i32 1
  %134 = bitcast %union.data_type* %133 to i32*
  store i32 %131, i32* %134, align 8
  %135 = load %struct.tdata*, %struct.tdata** %15, align 8
  %136 = getelementptr inbounds %struct.tdata, %struct.tdata* %135, i32 0, i32 0
  store i8 1, i8* %136, align 8
  br label %213

; <label>:137:                                    ; preds = %120, %116
  %138 = load i8, i8* %16, align 1
  %139 = zext i8 %138 to i32
  %140 = icmp eq i32 %139, 2
  br i1 %140, label %141, label %158

; <label>:141:                                    ; preds = %137
  %142 = load i8, i8* %17, align 1
  %143 = zext i8 %142 to i32
  %144 = icmp eq i32 %143, 2
  br i1 %144, label %145, label %158

; <label>:145:                                    ; preds = %141
  %146 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %147 = bitcast %union.data_type* %146 to double*
  %148 = load double, double* %147, align 8
  %149 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %150 = bitcast %union.data_type* %149 to double*
  %151 = load double, double* %150, align 8
  %152 = fadd double %148, %151
  %153 = load %struct.tdata*, %struct.tdata** %15, align 8
  %154 = getelementptr inbounds %struct.tdata, %struct.tdata* %153, i32 0, i32 1
  %155 = bitcast %union.data_type* %154 to double*
  store double %152, double* %155, align 8
  %156 = load %struct.tdata*, %struct.tdata** %15, align 8
  %157 = getelementptr inbounds %struct.tdata, %struct.tdata* %156, i32 0, i32 0
  store i8 2, i8* %157, align 8
  br label %212

; <label>:158:                                    ; preds = %141, %137
  %159 = load i8, i8* %16, align 1
  %160 = zext i8 %159 to i32
  %161 = icmp eq i32 %160, 2
  br i1 %161, label %162, label %180

; <label>:162:                                    ; preds = %158
  %163 = load i8, i8* %17, align 1
  %164 = zext i8 %163 to i32
  %165 = icmp eq i32 %164, 1
  br i1 %165, label %166, label %180

; <label>:166:                                    ; preds = %162
  %167 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %168 = bitcast %union.data_type* %167 to double*
  %169 = load double, double* %168, align 8
  %170 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %171 = bitcast %union.data_type* %170 to i32*
  %172 = load i32, i32* %171, align 8
  %173 = sitofp i32 %172 to double
  %174 = fadd double %169, %173
  %175 = load %struct.tdata*, %struct.tdata** %15, align 8
  %176 = getelementptr inbounds %struct.tdata, %struct.tdata* %175, i32 0, i32 1
  %177 = bitcast %union.data_type* %176 to double*
  store double %174, double* %177, align 8
  %178 = load %struct.tdata*, %struct.tdata** %15, align 8
  %179 = getelementptr inbounds %struct.tdata, %struct.tdata* %178, i32 0, i32 0
  store i8 2, i8* %179, align 8
  br label %211

; <label>:180:                                    ; preds = %162, %158
  %181 = load i8, i8* %16, align 1
  %182 = zext i8 %181 to i32
  %183 = icmp eq i32 %182, 1
  br i1 %183, label %184, label %202

; <label>:184:                                    ; preds = %180
  %185 = load i8, i8* %17, align 1
  %186 = zext i8 %185 to i32
  %187 = icmp eq i32 %186, 2
  br i1 %187, label %188, label %202

; <label>:188:                                    ; preds = %184
  %189 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %190 = bitcast %union.data_type* %189 to i32*
  %191 = load i32, i32* %190, align 8
  %192 = sitofp i32 %191 to double
  %193 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %194 = bitcast %union.data_type* %193 to double*
  %195 = load double, double* %194, align 8
  %196 = fadd double %192, %195
  %197 = load %struct.tdata*, %struct.tdata** %15, align 8
  %198 = getelementptr inbounds %struct.tdata, %struct.tdata* %197, i32 0, i32 1
  %199 = bitcast %union.data_type* %198 to double*
  store double %196, double* %199, align 8
  %200 = load %struct.tdata*, %struct.tdata** %15, align 8
  %201 = getelementptr inbounds %struct.tdata, %struct.tdata* %200, i32 0, i32 0
  store i8 2, i8* %201, align 8
  br label %210

; <label>:202:                                    ; preds = %184, %180
  %203 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.38, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__FUNCTION__.funk_add_rr, i32 0, i32 0))
  %204 = load i8, i8* %16, align 1
  call void @funk_print_type(i8 zeroext %204)
  %205 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.31, i32 0, i32 0))
  %206 = load i8, i8* %17, align 1
  call void @funk_print_type(i8 zeroext %206)
  %207 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i32 0, i32 0))
  %208 = load %struct.tdata*, %struct.tdata** %15, align 8
  %209 = getelementptr inbounds %struct.tdata, %struct.tdata* %208, i32 0, i32 0
  store i8 0, i8* %209, align 8
  br label %210

; <label>:210:                                    ; preds = %202, %188
  br label %211

; <label>:211:                                    ; preds = %210, %166
  br label %212

; <label>:212:                                    ; preds = %211, %145
  br label %213

; <label>:213:                                    ; preds = %212, %124
  %214 = load %struct.tnode*, %struct.tnode** %7, align 8
  %215 = load i32, i32* %8, align 4
  %216 = load %struct.tnode*, %struct.tnode** %9, align 8
  %217 = load i32, i32* %10, align 4
  %218 = load %struct.tnode*, %struct.tnode** %11, align 8
  %219 = load i32, i32* %12, align 4
  call void @debug_print_arith_operation(%struct.tnode* %214, i32 %215, %struct.tnode* %216, i32 %217, %struct.tnode* %218, i32 %219)
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
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @__FUNCTION__.funk_mul_rr, i32 0, i32 0))
  %19 = load i32, i32* %10, align 4
  %20 = load %struct.tnode*, %struct.tnode** %9, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 4
  %23 = icmp ugt i32 %19, %22
  br i1 %23, label %24, label %30

; <label>:24:                                     ; preds = %6
  %25 = load i32, i32* %10, align 4
  %26 = load %struct.tnode*, %struct.tnode** %9, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = load i32, i32* %27, align 4
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.34, i32 0, i32 0), i32 %25, i32 %28)
  br label %30

; <label>:30:                                     ; preds = %24, %6
  %31 = load i32, i32* %12, align 4
  %32 = load %struct.tnode*, %struct.tnode** %11, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = load i32, i32* %33, align 4
  %35 = icmp ugt i32 %31, %34
  br i1 %35, label %36, label %42

; <label>:36:                                     ; preds = %30
  %37 = load i32, i32* %12, align 4
  %38 = load %struct.tnode*, %struct.tnode** %11, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.34, i32 0, i32 0), i32 %37, i32 %40)
  br label %42

; <label>:42:                                     ; preds = %36, %30
  %43 = load i32, i32* %8, align 4
  %44 = load %struct.tnode*, %struct.tnode** %7, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  %46 = load i32, i32* %45, align 4
  %47 = icmp ugt i32 %43, %46
  br i1 %47, label %48, label %54

; <label>:48:                                     ; preds = %42
  %49 = load i32, i32* %8, align 4
  %50 = load %struct.tnode*, %struct.tnode** %7, align 8
  %51 = getelementptr inbounds %struct.tnode, %struct.tnode* %50, i32 0, i32 1
  %52 = load i32, i32* %51, align 4
  %53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.34, i32 0, i32 0), i32 %49, i32 %52)
  br label %54

; <label>:54:                                     ; preds = %48, %42
  %55 = load %struct.tnode*, %struct.tnode** %9, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 2
  %57 = load %struct.tpool*, %struct.tpool** %56, align 8
  %58 = getelementptr inbounds %struct.tpool, %struct.tpool* %57, i32 0, i32 0
  %59 = load %struct.tnode*, %struct.tnode** %9, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 0
  %61 = load i32, i32* %60, align 8
  %62 = load i32, i32* %10, align 4
  %63 = add i32 %61, %62
  %64 = zext i32 %63 to i64
  %65 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %58, i64 0, i64 %64
  %66 = bitcast %struct.tdata* %13 to i8*
  %67 = bitcast %struct.tdata* %65 to i8*
  call void @memcpy(i8* %66, i8* %67, i64 16, i32 8, i1 false)
  %68 = load %struct.tnode*, %struct.tnode** %11, align 8
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i32 0, i32 2
  %70 = load %struct.tpool*, %struct.tpool** %69, align 8
  %71 = getelementptr inbounds %struct.tpool, %struct.tpool* %70, i32 0, i32 0
  %72 = load %struct.tnode*, %struct.tnode** %11, align 8
  %73 = getelementptr inbounds %struct.tnode, %struct.tnode* %72, i32 0, i32 0
  %74 = load i32, i32* %73, align 8
  %75 = load i32, i32* %12, align 4
  %76 = add i32 %74, %75
  %77 = zext i32 %76 to i64
  %78 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %71, i64 0, i64 %77
  %79 = bitcast %struct.tdata* %14 to i8*
  %80 = bitcast %struct.tdata* %78 to i8*
  call void @memcpy(i8* %79, i8* %80, i64 16, i32 8, i1 false)
  %81 = load %struct.tnode*, %struct.tnode** %7, align 8
  %82 = getelementptr inbounds %struct.tnode, %struct.tnode* %81, i32 0, i32 2
  %83 = load %struct.tpool*, %struct.tpool** %82, align 8
  %84 = getelementptr inbounds %struct.tpool, %struct.tpool* %83, i32 0, i32 0
  %85 = load %struct.tnode*, %struct.tnode** %7, align 8
  %86 = getelementptr inbounds %struct.tnode, %struct.tnode* %85, i32 0, i32 0
  %87 = load i32, i32* %86, align 8
  %88 = load i32, i32* %8, align 4
  %89 = add i32 %87, %88
  %90 = zext i32 %89 to i64
  %91 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %84, i64 0, i64 %90
  store %struct.tdata* %91, %struct.tdata** %15, align 8
  %92 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 0
  %93 = load i8, i8* %92, align 8
  store i8 %93, i8* %16, align 1
  %94 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %95 = load i8, i8* %94, align 8
  store i8 %95, i8* %17, align 1
  %96 = load i8, i8* %16, align 1
  %97 = zext i8 %96 to i32
  %98 = icmp eq i32 %97, 1
  br i1 %98, label %99, label %116

; <label>:99:                                     ; preds = %54
  %100 = load i8, i8* %17, align 1
  %101 = zext i8 %100 to i32
  %102 = icmp eq i32 %101, 1
  br i1 %102, label %103, label %116

; <label>:103:                                    ; preds = %99
  %104 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %105 = bitcast %union.data_type* %104 to i32*
  %106 = load i32, i32* %105, align 8
  %107 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %108 = bitcast %union.data_type* %107 to i32*
  %109 = load i32, i32* %108, align 8
  %110 = mul nsw i32 %106, %109
  %111 = load %struct.tdata*, %struct.tdata** %15, align 8
  %112 = getelementptr inbounds %struct.tdata, %struct.tdata* %111, i32 0, i32 1
  %113 = bitcast %union.data_type* %112 to i32*
  store i32 %110, i32* %113, align 8
  %114 = load %struct.tdata*, %struct.tdata** %15, align 8
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 0
  store i8 1, i8* %115, align 8
  br label %188

; <label>:116:                                    ; preds = %99, %54
  %117 = load i8, i8* %16, align 1
  %118 = zext i8 %117 to i32
  %119 = icmp eq i32 %118, 2
  br i1 %119, label %120, label %137

; <label>:120:                                    ; preds = %116
  %121 = load i8, i8* %17, align 1
  %122 = zext i8 %121 to i32
  %123 = icmp eq i32 %122, 2
  br i1 %123, label %124, label %137

; <label>:124:                                    ; preds = %120
  %125 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %126 = bitcast %union.data_type* %125 to double*
  %127 = load double, double* %126, align 8
  %128 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %129 = bitcast %union.data_type* %128 to double*
  %130 = load double, double* %129, align 8
  %131 = fmul double %127, %130
  %132 = load %struct.tdata*, %struct.tdata** %15, align 8
  %133 = getelementptr inbounds %struct.tdata, %struct.tdata* %132, i32 0, i32 1
  %134 = bitcast %union.data_type* %133 to double*
  store double %131, double* %134, align 8
  %135 = load %struct.tdata*, %struct.tdata** %15, align 8
  %136 = getelementptr inbounds %struct.tdata, %struct.tdata* %135, i32 0, i32 0
  store i8 2, i8* %136, align 8
  br label %187

; <label>:137:                                    ; preds = %120, %116
  %138 = load i8, i8* %16, align 1
  %139 = zext i8 %138 to i32
  %140 = icmp eq i32 %139, 2
  br i1 %140, label %141, label %159

; <label>:141:                                    ; preds = %137
  %142 = load i8, i8* %17, align 1
  %143 = zext i8 %142 to i32
  %144 = icmp eq i32 %143, 1
  br i1 %144, label %145, label %159

; <label>:145:                                    ; preds = %141
  %146 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %147 = bitcast %union.data_type* %146 to double*
  %148 = load double, double* %147, align 8
  %149 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %150 = bitcast %union.data_type* %149 to i32*
  %151 = load i32, i32* %150, align 8
  %152 = sitofp i32 %151 to double
  %153 = fmul double %148, %152
  %154 = load %struct.tdata*, %struct.tdata** %15, align 8
  %155 = getelementptr inbounds %struct.tdata, %struct.tdata* %154, i32 0, i32 1
  %156 = bitcast %union.data_type* %155 to double*
  store double %153, double* %156, align 8
  %157 = load %struct.tdata*, %struct.tdata** %15, align 8
  %158 = getelementptr inbounds %struct.tdata, %struct.tdata* %157, i32 0, i32 0
  store i8 2, i8* %158, align 8
  br label %186

; <label>:159:                                    ; preds = %141, %137
  %160 = load i8, i8* %16, align 1
  %161 = zext i8 %160 to i32
  %162 = icmp eq i32 %161, 1
  br i1 %162, label %163, label %181

; <label>:163:                                    ; preds = %159
  %164 = load i8, i8* %17, align 1
  %165 = zext i8 %164 to i32
  %166 = icmp eq i32 %165, 2
  br i1 %166, label %167, label %181

; <label>:167:                                    ; preds = %163
  %168 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %169 = bitcast %union.data_type* %168 to i32*
  %170 = load i32, i32* %169, align 8
  %171 = sitofp i32 %170 to double
  %172 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %173 = bitcast %union.data_type* %172 to double*
  %174 = load double, double* %173, align 8
  %175 = fmul double %171, %174
  %176 = load %struct.tdata*, %struct.tdata** %15, align 8
  %177 = getelementptr inbounds %struct.tdata, %struct.tdata* %176, i32 0, i32 1
  %178 = bitcast %union.data_type* %177 to double*
  store double %175, double* %178, align 8
  %179 = load %struct.tdata*, %struct.tdata** %15, align 8
  %180 = getelementptr inbounds %struct.tdata, %struct.tdata* %179, i32 0, i32 0
  store i8 2, i8* %180, align 8
  br label %185

; <label>:181:                                    ; preds = %163, %159
  %182 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.35, i32 0, i32 0))
  %183 = load %struct.tdata*, %struct.tdata** %15, align 8
  %184 = getelementptr inbounds %struct.tdata, %struct.tdata* %183, i32 0, i32 0
  store i8 0, i8* %184, align 8
  br label %185

; <label>:185:                                    ; preds = %181, %167
  br label %186

; <label>:186:                                    ; preds = %185, %145
  br label %187

; <label>:187:                                    ; preds = %186, %124
  br label %188

; <label>:188:                                    ; preds = %187, %103
  %189 = load %struct.tnode*, %struct.tnode** %7, align 8
  %190 = load i32, i32* %8, align 4
  %191 = load %struct.tnode*, %struct.tnode** %9, align 8
  %192 = load i32, i32* %10, align 4
  %193 = load %struct.tnode*, %struct.tnode** %11, align 8
  %194 = load i32, i32* %12, align 4
  call void @debug_print_arith_operation(%struct.tnode* %189, i32 %190, %struct.tnode* %191, i32 %192, %struct.tnode* %193, i32 %194)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_dimension(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.39, i32 0, i32 0))
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
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.40, i32 0, i32 0), i32 %19)
  br label %21

; <label>:21:                                     ; preds = %12
  %22 = load i32, i32* %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %3, align 4
  br label %5

; <label>:24:                                     ; preds = %5
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.41, i32 0, i32 0))
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
  br label %128

; <label>:26:                                     ; preds = %1
  %27 = load %struct.tnode*, %struct.tnode** %2, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 3
  %29 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %28, i32 0, i32 0
  %30 = load i32, i32* %29, align 8
  %31 = icmp eq i32 %30, 1
  br i1 %31, label %32, label %65

; <label>:32:                                     ; preds = %26
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.42, i32 0, i32 0))
  %34 = load %struct.tnode*, %struct.tnode** %2, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 0
  %36 = load i32, i32* %35, align 8
  store i32 %36, i32* %3, align 4
  br label %37

; <label>:37:                                     ; preds = %60, %32
  %38 = load i32, i32* %3, align 4
  %39 = load %struct.tnode*, %struct.tnode** %2, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 0
  %41 = load i32, i32* %40, align 8
  %42 = load %struct.tnode*, %struct.tnode** %2, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 1
  %44 = load i32, i32* %43, align 4
  %45 = add i32 %41, %44
  %46 = icmp ult i32 %38, %45
  br i1 %46, label %47, label %63

; <label>:47:                                     ; preds = %37
  %48 = load %struct.tnode*, %struct.tnode** %2, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 2
  %50 = load %struct.tpool*, %struct.tpool** %49, align 8
  %51 = getelementptr inbounds %struct.tpool, %struct.tpool* %50, i32 0, i32 0
  %52 = load i32, i32* %3, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %51, i64 0, i64 %53
  %55 = bitcast %struct.tdata* %54 to { i8, i64 }*
  %56 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %55, i32 0, i32 0
  %57 = load i8, i8* %56, align 8
  %58 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %55, i32 0, i32 1
  %59 = load i64, i64* %58, align 8
  call void @funk_print_scalar_element(i8 %57, i64 %59)
  br label %60

; <label>:60:                                     ; preds = %47
  %61 = load i32, i32* %3, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, i32* %3, align 4
  br label %37

; <label>:63:                                     ; preds = %37
  %64 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.43, i32 0, i32 0))
  br label %127

; <label>:65:                                     ; preds = %26
  %66 = load %struct.tnode*, %struct.tnode** %2, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 3
  %68 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %67, i32 0, i32 0
  %69 = load i32, i32* %68, align 8
  %70 = icmp eq i32 %69, 2
  br i1 %70, label %71, label %124

; <label>:71:                                     ; preds = %65
  %72 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i32 0, i32 0))
  store i32 0, i32* %4, align 4
  br label %73

; <label>:73:                                     ; preds = %120, %71
  %74 = load i32, i32* %4, align 4
  %75 = load %struct.tnode*, %struct.tnode** %2, align 8
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %75, i32 0, i32 3
  %77 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %76, i32 0, i32 1
  %78 = getelementptr inbounds [2 x i32], [2 x i32]* %77, i64 0, i64 0
  %79 = load i32, i32* %78, align 4
  %80 = icmp ult i32 %74, %79
  br i1 %80, label %81, label %123

; <label>:81:                                     ; preds = %73
  store i32 0, i32* %5, align 4
  br label %82

; <label>:82:                                     ; preds = %115, %81
  %83 = load i32, i32* %5, align 4
  %84 = load %struct.tnode*, %struct.tnode** %2, align 8
  %85 = getelementptr inbounds %struct.tnode, %struct.tnode* %84, i32 0, i32 3
  %86 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %85, i32 0, i32 1
  %87 = getelementptr inbounds [2 x i32], [2 x i32]* %86, i64 0, i64 1
  %88 = load i32, i32* %87, align 4
  %89 = icmp ult i32 %83, %88
  br i1 %89, label %90, label %118

; <label>:90:                                     ; preds = %82
  %91 = load %struct.tnode*, %struct.tnode** %2, align 8
  %92 = getelementptr inbounds %struct.tnode, %struct.tnode* %91, i32 0, i32 2
  %93 = load %struct.tpool*, %struct.tpool** %92, align 8
  %94 = getelementptr inbounds %struct.tpool, %struct.tpool* %93, i32 0, i32 0
  %95 = load %struct.tnode*, %struct.tnode** %2, align 8
  %96 = getelementptr inbounds %struct.tnode, %struct.tnode* %95, i32 0, i32 0
  %97 = load i32, i32* %96, align 8
  %98 = load i32, i32* %4, align 4
  %99 = load %struct.tnode*, %struct.tnode** %2, align 8
  %100 = getelementptr inbounds %struct.tnode, %struct.tnode* %99, i32 0, i32 3
  %101 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %100, i32 0, i32 1
  %102 = getelementptr inbounds [2 x i32], [2 x i32]* %101, i64 0, i64 1
  %103 = load i32, i32* %102, align 4
  %104 = mul i32 %98, %103
  %105 = add i32 %97, %104
  %106 = load i32, i32* %5, align 4
  %107 = add i32 %105, %106
  %108 = zext i32 %107 to i64
  %109 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %94, i64 0, i64 %108
  %110 = bitcast %struct.tdata* %109 to { i8, i64 }*
  %111 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %110, i32 0, i32 0
  %112 = load i8, i8* %111, align 8
  %113 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %110, i32 0, i32 1
  %114 = load i64, i64* %113, align 8
  call void @funk_print_scalar_element(i8 %112, i64 %114)
  br label %115

; <label>:115:                                    ; preds = %90
  %116 = load i32, i32* %5, align 4
  %117 = add nsw i32 %116, 1
  store i32 %117, i32* %5, align 4
  br label %82

; <label>:118:                                    ; preds = %82
  %119 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i32 0, i32 0))
  br label %120

; <label>:120:                                    ; preds = %118
  %121 = load i32, i32* %4, align 4
  %122 = add nsw i32 %121, 1
  store i32 %122, i32* %4, align 4
  br label %73

; <label>:123:                                    ; preds = %73
  br label %126

; <label>:124:                                    ; preds = %65
  %125 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.44, i32 0, i32 0))
  br label %126

; <label>:126:                                    ; preds = %124, %123
  br label %127

; <label>:127:                                    ; preds = %126, %63
  br label %128

; <label>:128:                                    ; preds = %127, %11
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
