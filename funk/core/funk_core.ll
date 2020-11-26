; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.16.0"

%struct.tpool = type { [250000 x %struct.tdata], i32 }
%struct.tdata = type { i8, %union.data_type }
%union.data_type = type { double }
%struct.tnode = type { i32, i32, %struct.tpool*, %struct.tdimensions }
%struct.tdimensions = type { i32, [2 x i32] }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }

@funk_types_str = global [7 x [100 x i8]] [[100 x i8] c"type_invalid\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_int\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_double\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_empty_array\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_scalar\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", [100 x i8] c"type_function\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00"], align 16
@g_funk_print_array_max_elements = global i32 30, align 4
@g_funk_print_array_element_per_row = global i32 50, align 4
@g_debug_continue = global i32 0, align 4
@g_funk_verbosity = global i32 0, align 4
@funk_sleep.first = internal global i32 1, align 4
@funk_global_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str = private unnamed_addr constant [53 x i8] c"%s -I- wrapping around pool %s. tail = %d, max = %d\0A\00", align 1
@__FUNCTION__.funk_increment_pool_tail = private unnamed_addr constant [25 x i8] c"funk_increment_pool_tail\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"gpool\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"fpool\00", align 1
@.str.3 = private unnamed_addr constant [26 x i8] c"%s[%d :%d] %d-dimensional\00", align 1
@gRenderLoopState = common global %struct.tnode zeroinitializer, align 8
@.str.4 = private unnamed_addr constant [43 x i8] c"-I- Setting conf parameter %d to value %d\0A\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.6 = private unnamed_addr constant [24 x i8] c"-E- %s Invalid type %d\0A\00", align 1
@__FUNCTION__.funk_print_type = private unnamed_addr constant [16 x i8] c"funk_print_type\00", align 1
@.str.7 = private unnamed_addr constant [13 x i8] c"-I- Exiting\0A\00", align 1
@funk_functions_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str.8 = private unnamed_addr constant [50 x i8] c"-E- %s node lhs data type is %d but shall be int\0A\00", align 1
@__FUNCTION__.funk_create_list_slide_2d_var = private unnamed_addr constant [30 x i8] c"funk_create_list_slide_2d_var\00", align 1
@.str.9 = private unnamed_addr constant [42 x i8] c"-E- %s index %d out of array boundary %d\0A\00", align 1
@__FUNCTION__.funk_create_list_slide_1d_var = private unnamed_addr constant [30 x i8] c"funk_create_list_slide_1d_var\00", align 1
@.str.10 = private unnamed_addr constant [76 x i8] c"-E- %s the number of indexes provided %d does not match dimension count %d\0A\00", align 1
@__FUNCTION__.funk_create_list_slide_lit = private unnamed_addr constant [27 x i8] c"funk_create_list_slide_lit\00", align 1
@.str.11 = private unnamed_addr constant [56 x i8] c"-E- %s the index %d >  upper bound %d for dimension %d\0A\00", align 1
@.str.12 = private unnamed_addr constant [44 x i8] c"-E- %s %d dimensions are not yet supported\0A\00", align 1
@.str.13 = private unnamed_addr constant [41 x i8] c"-E- %s index %d out of range for len %d\0A\00", align 1
@.str.14 = private unnamed_addr constant [38 x i8] c"-E- Indexes %d, %d are out of bounds\0A\00", align 1
@.str.15 = private unnamed_addr constant [6 x i8] c" %3d \00", align 1
@.str.16 = private unnamed_addr constant [8 x i8] c" %5.5f \00", align 1
@.str.17 = private unnamed_addr constant [6 x i8] c" %5s \00", align 1
@.str.18 = private unnamed_addr constant [3 x i8] c"[]\00", align 1
@.str.19 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.20 = private unnamed_addr constant [43 x i8] c"-E- %s: offset %d out of bounds for len %d\00", align 1
@__FUNCTION__.funk_get_node_type = private unnamed_addr constant [19 x i8] c"funk_get_node_type\00", align 1
@__FUNCTION__.funk_set_node_type = private unnamed_addr constant [19 x i8] c"funk_set_node_type\00", align 1
@__FUNCTION__.funk_set_node_value_int = private unnamed_addr constant [24 x i8] c"funk_set_node_value_int\00", align 1
@__FUNCTION__.funk_get_node_value_int = private unnamed_addr constant [24 x i8] c"funk_get_node_value_int\00", align 1
@.str.21 = private unnamed_addr constant [12 x i8] c"tail @: %d\0A\00", align 1
@.str.22 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.23 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.24 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.25 = private unnamed_addr constant [10 x i8] c" = %s[%d]\00", align 1
@.str.26 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
@.str.27 = private unnamed_addr constant [54 x i8] c"-E- Invalid index %d is greater than array size of %d\00", align 1
@.str.28 = private unnamed_addr constant [24 x i8] c"-E- %s: invalid types: \00", align 1
@__FUNCTION__.funk_arith_op_rr = private unnamed_addr constant [17 x i8] c"funk_arith_op_rr\00", align 1
@.str.29 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.30 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.31 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.32 = private unnamed_addr constant [10 x i8] c"%d x %d \0A\00", align 1
@.str.33 = private unnamed_addr constant [40 x i8] c" [...] %d-dimensional with %d elements\0A\00", align 1
@.str.34 = private unnamed_addr constant [65 x i8] c"%s Error cannot address as a matrix since node has %d dimensions\00", align 1
@__FUNCTION__.print_2d_array_element_reg_reg = private unnamed_addr constant [31 x i8] c"print_2d_array_element_reg_reg\00", align 1
@.str.35 = private unnamed_addr constant [9 x i8] c"ERROR %s\00", align 1
@__FUNCTION__.funk_ToFloat = private unnamed_addr constant [13 x i8] c"funk_ToFloat\00", align 1
@.str.36 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.37 = private unnamed_addr constant [30 x i8] c"-E- File '%s' cannot be read\0A\00", align 1
@.str.38 = private unnamed_addr constant [21 x i8] c"-D- Opened file '%s'\00", align 1
@.str.39 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.40 = private unnamed_addr constant [66 x i8] c"-E- reshape operation not possible for variable with %d elements\0A\00", align 1
@.str.41 = private unnamed_addr constant [46 x i8] c"Error: %s shall have 2 dimensions and not %d\0A\00", align 1
@__FUNCTION__.funk_create_sub_matrix = private unnamed_addr constant [23 x i8] c"funk_create_sub_matrix\00", align 1
@.str.42 = private unnamed_addr constant [28 x i8] c"%s Error r1 (%d) > r2 (%d)\0A\00", align 1
@.str.43 = private unnamed_addr constant [28 x i8] c"%s Error c1 (%d) > c2 (%d)\0A\00", align 1

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
  %11 = load %struct.tnode*, %struct.tnode** %3, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 2
  %13 = load %struct.tpool*, %struct.tpool** %12, align 8
  %14 = getelementptr inbounds %struct.tpool, %struct.tpool* %13, i32 0, i32 0
  %15 = load i32, i32* %5, align 4
  %16 = urem i32 %15, 250000
  %17 = zext i32 %16 to i64
  %18 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %14, i64 0, i64 %17
  ret %struct.tdata* %18
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
  %13 = icmp uge i32 %12, 250000
  br i1 %13, label %14, label %23

14:                                               ; preds = %7
  %15 = load %struct.tpool*, %struct.tpool** %3, align 8
  %16 = icmp eq %struct.tpool* %15, @funk_global_memory_pool
  %17 = zext i1 %16 to i64
  %18 = select i1 %16, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)
  %19 = load %struct.tpool*, %struct.tpool** %3, align 8
  %20 = getelementptr inbounds %struct.tpool, %struct.tpool* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 8
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([53 x i8], [53 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @__FUNCTION__.funk_increment_pool_tail, i64 0, i64 0), i8* %18, i32 %21, i32 250000)
  store i32 0, i32* @g_debug_continue, align 4
  br label %23

23:                                               ; preds = %14, %7, %2
  %24 = load %struct.tpool*, %struct.tpool** %3, align 8
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 8
  %27 = load i32, i32* %4, align 4
  %28 = add i32 %26, %27
  %29 = urem i32 %28, 250000
  %30 = load %struct.tpool*, %struct.tpool** %3, align 8
  %31 = getelementptr inbounds %struct.tpool, %struct.tpool* %30, i32 0, i32 1
  store i32 %29, i32* %31, align 8
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_node_info(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = getelementptr inbounds %struct.tnode, %struct.tnode* %3, i32 0, i32 2
  %5 = load %struct.tpool*, %struct.tpool** %4, align 8
  %6 = icmp eq %struct.tpool* %5, @funk_global_memory_pool
  %7 = zext i1 %6 to i64
  %8 = select i1 %6, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 0
  %11 = load i32, i32* %10, align 8
  %12 = load %struct.tnode*, %struct.tnode** %2, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 1
  %14 = load i32, i32* %13, align 4
  %15 = load %struct.tnode*, %struct.tnode** %2, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 3
  %17 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.3, i64 0, i64 0), i8* %8, i32 %11, i32 %14, i32 %18)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_copy_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %6 = load %struct.tnode*, %struct.tnode** %4, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 0
  %8 = load i32, i32* %7, align 8
  %9 = load %struct.tnode*, %struct.tnode** %3, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 0
  store i32 %8, i32* %10, align 8
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 1
  %13 = load i32, i32* %12, align 4
  %14 = load %struct.tnode*, %struct.tnode** %3, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  store i32 %13, i32* %15, align 4
  %16 = load %struct.tnode*, %struct.tnode** %4, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 3
  %18 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %17, i32 0, i32 0
  %19 = load i32, i32* %18, align 8
  %20 = load %struct.tnode*, %struct.tnode** %3, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 3
  %22 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %21, i32 0, i32 0
  store i32 %19, i32* %22, align 8
  store i32 0, i32* %5, align 4
  br label %23

23:                                               ; preds = %40, %2
  %24 = load i32, i32* %5, align 4
  %25 = icmp slt i32 %24, 2
  br i1 %25, label %26, label %43

26:                                               ; preds = %23
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 3
  %29 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %28, i32 0, i32 1
  %30 = load i32, i32* %5, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [2 x i32], [2 x i32]* %29, i64 0, i64 %31
  %33 = load i32, i32* %32, align 4
  %34 = load %struct.tnode*, %struct.tnode** %3, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 3
  %36 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %35, i32 0, i32 1
  %37 = load i32, i32* %5, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [2 x i32], [2 x i32]* %36, i64 0, i64 %38
  store i32 %33, i32* %39, align 4
  br label %40

40:                                               ; preds = %26
  %41 = load i32, i32* %5, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %5, align 4
  br label %23

43:                                               ; preds = %23
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 2
  %46 = load %struct.tpool*, %struct.tpool** %45, align 8
  %47 = load %struct.tnode*, %struct.tnode** %3, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 2
  store %struct.tpool* %46, %struct.tpool** %48, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @set_s2d_user_global_state(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_copy_node(%struct.tnode* @gRenderLoopState, %struct.tnode* %3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @get_s2d_user_global_state(%struct.tnode* noalias sret) #0 {
  %2 = bitcast %struct.tnode* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %2, i8* align 8 bitcast (%struct.tnode* @gRenderLoopState to i8*), i64 32, i1 false)
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
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.4, i64 0, i64 0), i32 %5, i32 %6)
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
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i64 0, i64 0), i8* %14)
  br label %20

16:                                               ; preds = %6, %1
  %17 = load i8, i8* %2, align 1
  %18 = zext i8 %17 to i32
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @__FUNCTION__.funk_print_type, i64 0, i64 0), i32 %18)
  br label %20

20:                                               ; preds = %16, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_exit() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.7, i64 0, i64 0))
  call void @exit(i32 0) #5
  unreachable
}

; Function Attrs: noreturn
declare void @exit(i32) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_init() #0 {
  %1 = alloca i32, align 4
  %2 = call i64 @time(i64* null)
  %3 = trunc i64 %2 to i32
  store i32 %3, i32* %1, align 4
  %4 = load i32, i32* %1, align 4
  call void @srand(i32 %4)
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 1), align 8
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 1), align 8
  ret void
}

declare i64 @time(i64*) #1

declare void @srand(i32) #1

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
  %9 = load i32, i32* %5, align 4
  %10 = icmp sle i32 %9, 1
  br i1 %10, label %11, label %12

11:                                               ; preds = %2
  store i32 1, i32* %3, align 4
  br label %38

12:                                               ; preds = %2
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i64 0
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  store i32 %16, i32* %6, align 4
  store i32 1, i32* %7, align 4
  br label %17

17:                                               ; preds = %34, %12
  %18 = load i32, i32* %7, align 4
  %19 = load i32, i32* %5, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %37

21:                                               ; preds = %17
  %22 = load %struct.tnode*, %struct.tnode** %4, align 8
  %23 = load i32, i32* %7, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i64 %24
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 0
  %27 = load i32, i32* %26, align 8
  store i32 %27, i32* %8, align 4
  %28 = load i32, i32* %6, align 4
  %29 = add nsw i32 %28, 1
  %30 = load i32, i32* %8, align 4
  %31 = icmp ne i32 %29, %30
  br i1 %31, label %32, label %33

32:                                               ; preds = %21
  store i32 0, i32* %3, align 4
  br label %38

33:                                               ; preds = %21
  br label %34

34:                                               ; preds = %33
  %35 = load i32, i32* %7, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %7, align 4
  br label %17

37:                                               ; preds = %17
  store i32 0, i32* %3, align 4
  br label %38

38:                                               ; preds = %37, %32, %11
  %39 = load i32, i32* %3, align 4
  ret i32 %39
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
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %22)
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
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %36)
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
  %58 = add i32 %56, %57
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
  %72 = add i32 %70, %71
  br label %75

73:                                               ; preds = %61
  %74 = load i32, i32* %10, align 4
  br label %75

75:                                               ; preds = %73, %65
  %76 = phi i32 [ %72, %65 ], [ %74, %73 ]
  store i32 %76, i32* %10, align 4
  %77 = load %struct.tnode*, %struct.tnode** %5, align 8
  %78 = getelementptr inbounds %struct.tnode, %struct.tnode* %77, i32 0, i32 3
  %79 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %78, i32 0, i32 1
  %80 = getelementptr inbounds [2 x i32], [2 x i32]* %79, i64 0, i64 0
  %81 = load i32, i32* %80, align 4
  %82 = load i32, i32* %9, align 4
  %83 = urem i32 %82, %81
  store i32 %83, i32* %9, align 4
  %84 = load %struct.tnode*, %struct.tnode** %5, align 8
  %85 = getelementptr inbounds %struct.tnode, %struct.tnode* %84, i32 0, i32 3
  %86 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %85, i32 0, i32 1
  %87 = getelementptr inbounds [2 x i32], [2 x i32]* %86, i64 0, i64 1
  %88 = load i32, i32* %87, align 4
  %89 = load i32, i32* %10, align 4
  %90 = urem i32 %89, %88
  store i32 %90, i32* %10, align 4
  %91 = load i32, i32* %10, align 4
  %92 = load %struct.tnode*, %struct.tnode** %5, align 8
  %93 = getelementptr inbounds %struct.tnode, %struct.tnode* %92, i32 0, i32 3
  %94 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %93, i32 0, i32 1
  %95 = getelementptr inbounds [2 x i32], [2 x i32]* %94, i64 0, i64 0
  %96 = load i32, i32* %95, align 4
  %97 = icmp uge i32 %91, %96
  br i1 %97, label %98, label %106

98:                                               ; preds = %75
  %99 = load i32, i32* %10, align 4
  %100 = load %struct.tnode*, %struct.tnode** %5, align 8
  %101 = getelementptr inbounds %struct.tnode, %struct.tnode* %100, i32 0, i32 3
  %102 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %101, i32 0, i32 1
  %103 = getelementptr inbounds [2 x i32], [2 x i32]* %102, i64 0, i64 0
  %104 = load i32, i32* %103, align 4
  %105 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %99, i32 %104)
  br label %106

106:                                              ; preds = %98, %75
  %107 = load i32, i32* %9, align 4
  %108 = load %struct.tnode*, %struct.tnode** %5, align 8
  %109 = getelementptr inbounds %struct.tnode, %struct.tnode* %108, i32 0, i32 3
  %110 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %109, i32 0, i32 1
  %111 = getelementptr inbounds [2 x i32], [2 x i32]* %110, i64 0, i64 1
  %112 = load i32, i32* %111, align 4
  %113 = icmp uge i32 %107, %112
  br i1 %113, label %114, label %122

114:                                              ; preds = %106
  %115 = load i32, i32* %9, align 4
  %116 = load %struct.tnode*, %struct.tnode** %5, align 8
  %117 = getelementptr inbounds %struct.tnode, %struct.tnode* %116, i32 0, i32 3
  %118 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %117, i32 0, i32 1
  %119 = getelementptr inbounds [2 x i32], [2 x i32]* %118, i64 0, i64 1
  %120 = load i32, i32* %119, align 4
  %121 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_2d_var, i64 0, i64 0), i32 %115, i32 %120)
  br label %122

122:                                              ; preds = %114, %106
  %123 = load %struct.tnode*, %struct.tnode** %5, align 8
  %124 = getelementptr inbounds %struct.tnode, %struct.tnode* %123, i32 0, i32 2
  %125 = load %struct.tpool*, %struct.tpool** %124, align 8
  %126 = load %struct.tnode*, %struct.tnode** %6, align 8
  %127 = getelementptr inbounds %struct.tnode, %struct.tnode* %126, i32 0, i32 2
  store %struct.tpool* %125, %struct.tpool** %127, align 8
  %128 = load %struct.tnode*, %struct.tnode** %6, align 8
  %129 = getelementptr inbounds %struct.tnode, %struct.tnode* %128, i32 0, i32 3
  %130 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %129, i32 0, i32 0
  store i32 0, i32* %130, align 8
  %131 = load %struct.tnode*, %struct.tnode** %6, align 8
  %132 = getelementptr inbounds %struct.tnode, %struct.tnode* %131, i32 0, i32 1
  store i32 1, i32* %132, align 4
  %133 = load %struct.tnode*, %struct.tnode** %5, align 8
  %134 = getelementptr inbounds %struct.tnode, %struct.tnode* %133, i32 0, i32 0
  %135 = load i32, i32* %134, align 8
  %136 = load %struct.tnode*, %struct.tnode** %5, align 8
  %137 = getelementptr inbounds %struct.tnode, %struct.tnode* %136, i32 0, i32 3
  %138 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %137, i32 0, i32 1
  %139 = getelementptr inbounds [2 x i32], [2 x i32]* %138, i64 0, i64 0
  %140 = load i32, i32* %139, align 4
  %141 = load i32, i32* %9, align 4
  %142 = mul i32 %140, %141
  %143 = add i32 %135, %142
  %144 = load i32, i32* %10, align 4
  %145 = add i32 %143, %144
  %146 = urem i32 %145, 250000
  %147 = load %struct.tnode*, %struct.tnode** %6, align 8
  %148 = getelementptr inbounds %struct.tnode, %struct.tnode* %147, i32 0, i32 0
  store i32 %146, i32* %148, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_slide_1d_lit(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %6, align 4
  %8 = icmp slt i32 %7, 0
  br i1 %8, label %9, label %15

9:                                                ; preds = %3
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* %6, align 4
  %14 = add i32 %12, %13
  br label %17

15:                                               ; preds = %3
  %16 = load i32, i32* %6, align 4
  br label %17

17:                                               ; preds = %15, %9
  %18 = phi i32 [ %14, %9 ], [ %16, %15 ]
  store i32 %18, i32* %6, align 4
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 1
  %21 = load i32, i32* %20, align 4
  %22 = load i32, i32* %6, align 4
  %23 = urem i32 %22, %21
  store i32 %23, i32* %6, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 2
  %26 = load %struct.tpool*, %struct.tpool** %25, align 8
  %27 = load %struct.tnode*, %struct.tnode** %5, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 2
  store %struct.tpool* %26, %struct.tpool** %28, align 8
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 3
  %31 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %30, i32 0, i32 0
  store i32 0, i32* %31, align 8
  %32 = load %struct.tnode*, %struct.tnode** %5, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  store i32 1, i32* %33, align 4
  %34 = load %struct.tnode*, %struct.tnode** %4, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 0
  %36 = load i32, i32* %35, align 8
  %37 = load i32, i32* %6, align 4
  %38 = add i32 %36, %37
  %39 = urem i32 %38, 250000
  %40 = load %struct.tnode*, %struct.tnode** %5, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 0
  store i32 %39, i32* %41, align 8
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
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([30 x i8], [30 x i8]* @__FUNCTION__.funk_create_list_slide_1d_var, i64 0, i64 0), i32 %19)
  br label %21

21:                                               ; preds = %14, %3
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0)
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 1
  %25 = bitcast %union.data_type* %24 to i32*
  %26 = load i32, i32* %25, align 8
  store i32 %26, i32* %7, align 4
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = load %struct.tnode*, %struct.tnode** %5, align 8
  %29 = load i32, i32* %7, align 4
  call void @funk_create_list_slide_1d_lit(%struct.tnode* %27, %struct.tnode* %28, i32 %29)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_list_slide_lit(%struct.tnode*, %struct.tnode*, i32*, i32) #0 {
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
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([76 x i8], [76 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_create_list_slide_lit, i64 0, i64 0), i32 %17, i32 %21)
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
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.11, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_create_list_slide_lit, i64 0, i64 0), i32 %47, i32 %54, i32 %55)
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
  %82 = urem i32 %81, 250000
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
  %106 = urem i32 %105, 250000
  %107 = load %struct.tnode*, %struct.tnode** %6, align 8
  %108 = getelementptr inbounds %struct.tnode, %struct.tnode* %107, i32 0, i32 0
  store i32 %106, i32* %108, align 8
  br label %112

109:                                              ; preds = %85
  %110 = load i32, i32* %8, align 4
  %111 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_create_list_slide_lit, i64 0, i64 0), i32 %110)
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
  %128 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.13, i64 0, i64 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @__FUNCTION__.funk_create_list_slide_lit, i64 0, i64 0), i32 %124, i32 %127)
  br label %129

129:                                              ; preds = %121, %113
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
  %10 = load %struct.tpool*, %struct.tpool** %5, align 8
  %11 = load %struct.tnode*, %struct.tnode** %6, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 2
  store %struct.tpool* %10, %struct.tpool** %12, align 8
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 3
  %15 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %14, i32 0, i32 0
  store i32 1, i32* %15, align 8
  %16 = load %struct.tnode*, %struct.tnode** %7, align 8
  %17 = load i32, i32* %8, align 4
  %18 = call i32 @is_list_consecutive_in_memory(%struct.tnode* %16, i32 %17)
  %19 = icmp eq i32 %18, 1
  br i1 %19, label %20, label %30

20:                                               ; preds = %4
  %21 = load %struct.tnode*, %struct.tnode** %7, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i64 0
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = load %struct.tnode*, %struct.tnode** %6, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 0
  store i32 %24, i32* %26, align 8
  %27 = load i32, i32* %8, align 4
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 1
  store i32 %27, i32* %29, align 4
  br label %60

30:                                               ; preds = %4
  %31 = load %struct.tpool*, %struct.tpool** %5, align 8
  %32 = getelementptr inbounds %struct.tpool, %struct.tpool* %31, i32 0, i32 1
  %33 = load i32, i32* %32, align 8
  %34 = load %struct.tnode*, %struct.tnode** %6, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 0
  store i32 %33, i32* %35, align 8
  %36 = load i32, i32* %8, align 4
  %37 = load %struct.tnode*, %struct.tnode** %6, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 1
  store i32 %36, i32* %38, align 4
  %39 = load %struct.tpool*, %struct.tpool** %5, align 8
  %40 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %39, i32 %40)
  store i32 0, i32* %9, align 4
  br label %41

41:                                               ; preds = %56, %30
  %42 = load i32, i32* %9, align 4
  %43 = load i32, i32* %8, align 4
  %44 = icmp slt i32 %42, %43
  br i1 %44, label %45, label %59

45:                                               ; preds = %41
  %46 = load %struct.tnode*, %struct.tnode** %6, align 8
  %47 = load i32, i32* %9, align 4
  %48 = call %struct.tdata* @get_node(%struct.tnode* %46, i32 %47)
  %49 = load %struct.tnode*, %struct.tnode** %7, align 8
  %50 = load i32, i32* %9, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i64 %51
  %53 = call %struct.tdata* @get_node(%struct.tnode* %52, i32 0)
  %54 = bitcast %struct.tdata* %48 to i8*
  %55 = bitcast %struct.tdata* %53 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %54, i8* align 8 %55, i64 16, i1 false)
  br label %56

56:                                               ; preds = %45
  %57 = load i32, i32* %9, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, i32* %9, align 4
  br label %41

59:                                               ; preds = %41
  br label %60

60:                                               ; preds = %59, %20
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
  %11 = load %struct.tpool*, %struct.tpool** %6, align 8
  %12 = load %struct.tnode*, %struct.tnode** %7, align 8
  %13 = load %struct.tnode*, %struct.tnode** %8, align 8
  %14 = load i32, i32* %9, align 4
  %15 = load i32, i32* %10, align 4
  %16 = mul nsw i32 %14, %15
  call void @funk_create_list(%struct.tpool* %11, %struct.tnode* %12, %struct.tnode* %13, i32 %16)
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 3
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 0
  store i32 2, i32* %19, align 8
  %20 = load i32, i32* %9, align 4
  %21 = load %struct.tnode*, %struct.tnode** %7, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 3
  %23 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %22, i32 0, i32 1
  %24 = getelementptr inbounds [2 x i32], [2 x i32]* %23, i64 0, i64 0
  store i32 %20, i32* %24, align 4
  %25 = load i32, i32* %10, align 4
  %26 = load %struct.tnode*, %struct.tnode** %7, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 3
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 1
  %29 = getelementptr inbounds [2 x i32], [2 x i32]* %28, i64 0, i64 1
  store i32 %25, i32* %29, align 4
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
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = bitcast i32* %6 to i8*
  call void @funk_create_scalar(%struct.tpool* %7, %struct.tnode* %8, i8* %9, i32 1)
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
  %7 = load %struct.tpool*, %struct.tpool** %4, align 8
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = bitcast double* %6 to i8*
  call void @funk_create_scalar(%struct.tpool* %7, %struct.tnode* %8, i8* %9, i32 2)
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
  %10 = load %struct.tpool*, %struct.tpool** %5, align 8
  %11 = getelementptr inbounds %struct.tpool, %struct.tpool* %10, i32 0, i32 1
  %12 = load i32, i32* %11, align 8
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 0
  store i32 %12, i32* %14, align 8
  %15 = load i32, i32* %8, align 4
  %16 = load %struct.tnode*, %struct.tnode** %6, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 1
  store i32 %15, i32* %17, align 4
  %18 = load %struct.tpool*, %struct.tpool** %5, align 8
  %19 = load %struct.tnode*, %struct.tnode** %6, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 2
  store %struct.tpool* %18, %struct.tpool** %20, align 8
  %21 = load %struct.tnode*, %struct.tnode** %6, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 3
  %23 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %22, i32 0, i32 0
  store i32 1, i32* %23, align 8
  %24 = load %struct.tpool*, %struct.tpool** %5, align 8
  %25 = load i32, i32* %8, align 4
  call void @funk_increment_pool_tail(%struct.tpool* %24, i32 %25)
  store i32 0, i32* %9, align 4
  br label %26

26:                                               ; preds = %45, %4
  %27 = load i32, i32* %9, align 4
  %28 = load i32, i32* %8, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %48

30:                                               ; preds = %26
  %31 = load %struct.tnode*, %struct.tnode** %6, align 8
  %32 = load i32, i32* %9, align 4
  %33 = call %struct.tdata* @get_node(%struct.tnode* %31, i32 %32)
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 0
  store i8 1, i8* %34, align 8
  %35 = load i32*, i32** %7, align 8
  %36 = load i32, i32* %9, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i32, i32* %35, i64 %37
  %39 = load i32, i32* %38, align 4
  %40 = load %struct.tnode*, %struct.tnode** %6, align 8
  %41 = load i32, i32* %9, align 4
  %42 = call %struct.tdata* @get_node(%struct.tnode* %40, i32 %41)
  %43 = getelementptr inbounds %struct.tdata, %struct.tdata* %42, i32 0, i32 1
  %44 = bitcast %union.data_type* %43 to i32*
  store i32 %39, i32* %44, align 8
  br label %45

45:                                               ; preds = %30
  %46 = load i32, i32* %9, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, i32* %9, align 4
  br label %26

48:                                               ; preds = %26
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
  %11 = load %struct.tpool*, %struct.tpool** %6, align 8
  %12 = load %struct.tnode*, %struct.tnode** %7, align 8
  %13 = load i32*, i32** %8, align 8
  %14 = load i32, i32* %9, align 4
  %15 = load i32, i32* %10, align 4
  %16 = mul nsw i32 %14, %15
  call void @funk_create_list_int_literal(%struct.tpool* %11, %struct.tnode* %12, i32* %13, i32 %16)
  %17 = load %struct.tnode*, %struct.tnode** %7, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 3
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 0
  store i32 2, i32* %19, align 8
  %20 = load i32, i32* %9, align 4
  %21 = load %struct.tnode*, %struct.tnode** %7, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 3
  %23 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %22, i32 0, i32 1
  %24 = getelementptr inbounds [2 x i32], [2 x i32]* %23, i64 0, i64 0
  store i32 %20, i32* %24, align 4
  %25 = load i32, i32* %10, align 4
  %26 = load %struct.tnode*, %struct.tnode** %7, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 3
  %28 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %27, i32 0, i32 1
  %29 = getelementptr inbounds [2 x i32], [2 x i32]* %28, i64 0, i64 1
  store i32 %25, i32* %29, align 4
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
  %12 = load %struct.tnode*, %struct.tnode** %8, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 3
  %14 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %13, i32 0, i32 1
  %15 = getelementptr inbounds [2 x i32], [2 x i32]* %14, i64 0, i64 0
  %16 = load i32, i32* %15, align 4
  %17 = load i32, i32* %9, align 4
  %18 = mul i32 %16, %17
  %19 = load i32, i32* %10, align 4
  %20 = add i32 %18, %19
  store i32 %20, i32* %11, align 4
  %21 = load i32, i32* %11, align 4
  %22 = load %struct.tnode*, %struct.tnode** %8, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 1
  %24 = load i32, i32* %23, align 4
  %25 = icmp uge i32 %21, %24
  br i1 %25, label %26, label %30

26:                                               ; preds = %5
  %27 = load i32, i32* %9, align 4
  %28 = load i32, i32* %10, align 4
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.14, i64 0, i64 0), i32 %27, i32 %28)
  br label %40

30:                                               ; preds = %5
  %31 = load %struct.tnode*, %struct.tnode** %8, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = load i32, i32* %11, align 4
  %35 = add i32 %33, %34
  %36 = load %struct.tnode*, %struct.tnode** %7, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 0
  store i32 %35, i32* %37, align 8
  %38 = load %struct.tnode*, %struct.tnode** %7, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  store i32 1, i32* %39, align 4
  br label %40

40:                                               ; preds = %30, %26
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
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.15, i64 0, i64 0), i32 %13)
  br label %24

15:                                               ; preds = %2
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.16, i64 0, i64 0), double %18)
  br label %24

20:                                               ; preds = %2
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.18, i64 0, i64 0))
  br label %24

22:                                               ; preds = %2
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.19, i64 0, i64 0))
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
  %7 = load %struct.tnode*, %struct.tnode** %4, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = load i32, i32* %8, align 4
  %10 = icmp ugt i32 %9, 0
  br i1 %10, label %11, label %23

11:                                               ; preds = %3
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
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_get_node_type, i64 0, i64 0), i32 %18, i32 %21)
  br label %23

23:                                               ; preds = %17, %11, %3
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  %28 = load i8, i8* %27, align 8
  %29 = load i8*, i8** %6, align 8
  store i8 %28, i8* %29, align 1
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
  %7 = load i32, i32* %5, align 4
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp uge i32 %7, %10
  br i1 %11, label %12, label %18

12:                                               ; preds = %3
  %13 = load i32, i32* %5, align 4
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__FUNCTION__.funk_set_node_type, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load i8, i8* %6, align 1
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = load i32, i32* %5, align 4
  %22 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 %21)
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 0
  store i8 %19, i8* %23, align 8
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
  %7 = load i32, i32* %5, align 4
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp uge i32 %7, %10
  br i1 %11, label %12, label %18

12:                                               ; preds = %3
  %13 = load i32, i32* %5, align 4
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = load i32, i32* %15, align 4
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_set_node_value_int, i64 0, i64 0), i32 %13, i32 %16)
  br label %18

18:                                               ; preds = %12, %3
  %19 = load %struct.tnode*, %struct.tnode** %4, align 8
  %20 = load i32, i32* %5, align 4
  %21 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 %20)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 0
  store i8 1, i8* %22, align 8
  %23 = load i32, i32* %6, align 4
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = load i32, i32* %5, align 4
  %26 = call %struct.tdata* @get_node(%struct.tnode* %24, i32 %25)
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
  %28 = bitcast %union.data_type* %27 to i32*
  store i32 %23, i32* %28, align 8
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
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @__FUNCTION__.funk_get_node_value_int, i64 0, i64 0), i32 %11, i32 %14)
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
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.21, i64 0, i64 0), i32 %10)
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
  %24 = getelementptr inbounds [250000 x %struct.tdata], [250000 x %struct.tdata]* %21, i64 0, i64 %23
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
  %38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.22, i64 0, i64 0))
  br label %39

39:                                               ; preds = %37, %32, %19
  br label %40

40:                                               ; preds = %39
  %41 = load i32, i32* %7, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %7, align 4
  br label %13

43:                                               ; preds = %13
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.22, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_next_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %6 = load %struct.tnode*, %struct.tnode** %4, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 2
  %8 = load %struct.tpool*, %struct.tpool** %7, align 8
  %9 = load %struct.tnode*, %struct.tnode** %3, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 2
  store %struct.tpool* %8, %struct.tpool** %10, align 8
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 3
  %13 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 8
  %15 = load %struct.tnode*, %struct.tnode** %3, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 3
  %17 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %16, i32 0, i32 0
  store i32 %14, i32* %17, align 8
  store i32 0, i32* %5, align 4
  br label %18

18:                                               ; preds = %35, %2
  %19 = load i32, i32* %5, align 4
  %20 = icmp slt i32 %19, 2
  br i1 %20, label %21, label %38

21:                                               ; preds = %18
  %22 = load %struct.tnode*, %struct.tnode** %4, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 3
  %24 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %23, i32 0, i32 1
  %25 = load i32, i32* %5, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [2 x i32], [2 x i32]* %24, i64 0, i64 %26
  %28 = load i32, i32* %27, align 4
  %29 = load %struct.tnode*, %struct.tnode** %3, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 3
  %31 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %30, i32 0, i32 1
  %32 = load i32, i32* %5, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [2 x i32], [2 x i32]* %31, i64 0, i64 %33
  store i32 %28, i32* %34, align 4
  br label %35

35:                                               ; preds = %21
  %36 = load i32, i32* %5, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %5, align 4
  br label %18

38:                                               ; preds = %18
  %39 = load %struct.tnode*, %struct.tnode** %4, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 1
  %41 = load i32, i32* %40, align 4
  %42 = icmp eq i32 %41, 0
  br i1 %42, label %43, label %58

43:                                               ; preds = %38
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 0
  %46 = load i32, i32* %45, align 8
  %47 = load %struct.tnode*, %struct.tnode** %3, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 0
  store i32 %46, i32* %48, align 8
  %49 = load %struct.tnode*, %struct.tnode** %3, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  store i32 1, i32* %50, align 4
  %51 = load %struct.tnode*, %struct.tnode** %3, align 8
  %52 = call %struct.tdata* @get_node(%struct.tnode* %51, i32 0)
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 0
  store i8 4, i8* %53, align 8
  %54 = load %struct.tnode*, %struct.tnode** %3, align 8
  %55 = call %struct.tdata* @get_node(%struct.tnode* %54, i32 0)
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 1
  %57 = bitcast %union.data_type* %56 to i32*
  store i32 0, i32* %57, align 8
  br label %71

58:                                               ; preds = %38
  %59 = load %struct.tnode*, %struct.tnode** %4, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 1
  %61 = load i32, i32* %60, align 4
  %62 = sub i32 %61, 1
  %63 = load %struct.tnode*, %struct.tnode** %3, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 1
  store i32 %62, i32* %64, align 4
  %65 = load %struct.tnode*, %struct.tnode** %4, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 0
  %67 = load i32, i32* %66, align 8
  %68 = add i32 %67, 1
  %69 = load %struct.tnode*, %struct.tnode** %3, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 0
  store i32 %68, i32* %70, align 8
  br label %71

71:                                               ; preds = %58, %43
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_function_entry_hook(i8*) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
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
  store i32 0, i32* %9, align 4
  br label %10

10:                                               ; preds = %23, %4
  %11 = load i32, i32* %9, align 4
  %12 = load i32, i32* %7, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %26

14:                                               ; preds = %10
  %15 = load %struct.tnode*, %struct.tnode** %5, align 8
  %16 = load i32, i32* %9, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i64 %17
  %19 = load %struct.tnode*, %struct.tnode** %6, align 8
  %20 = load i32, i32* %9, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i64 %21
  call void @funk_copy_node(%struct.tnode* %18, %struct.tnode* %22)
  br label %23

23:                                               ; preds = %14
  %24 = load i32, i32* %9, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, i32* %9, align 4
  br label %10

26:                                               ; preds = %10
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
  %18 = select i1 %16, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)
  %19 = load %struct.tnode*, %struct.tnode** %9, align 8
  %20 = getelementptr inbounds %struct.tnode, %struct.tnode* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = load i32, i32* %10, align 4
  %23 = add i32 %21, %22
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.23, i64 0, i64 0), i8* %18, i32 %23)
  %25 = load %struct.tnode*, %struct.tnode** %9, align 8
  %26 = load i32, i32* %10, align 4
  %27 = call %struct.tdata* @get_node(%struct.tnode* %25, i32 %26)
  %28 = bitcast %struct.tdata* %27 to { i8, i64 }*
  %29 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %28, i32 0, i32 0
  %30 = load i8, i8* %29, align 8
  %31 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %28, i32 0, i32 1
  %32 = load i64, i64* %31, align 8
  call void @funk_print_scalar_element(i8 %30, i64 %32)
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.24, i64 0, i64 0))
  %34 = load %struct.tnode*, %struct.tnode** %11, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 2
  %36 = load %struct.tpool*, %struct.tpool** %35, align 8
  %37 = icmp eq %struct.tpool* %36, @funk_global_memory_pool
  %38 = zext i1 %37 to i64
  %39 = select i1 %37, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)
  %40 = load %struct.tnode*, %struct.tnode** %11, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 0
  %42 = load i32, i32* %41, align 8
  %43 = load i32, i32* %12, align 4
  %44 = add i32 %42, %43
  %45 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.23, i64 0, i64 0), i8* %39, i32 %44)
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
  %59 = select i1 %57, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)
  %60 = load %struct.tnode*, %struct.tnode** %7, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 0
  %62 = load i32, i32* %61, align 8
  %63 = load i32, i32* %8, align 4
  %64 = add i32 %62, %63
  %65 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.25, i64 0, i64 0), i8* %59, i32 %64)
  %66 = load %struct.tnode*, %struct.tnode** %7, align 8
  %67 = load i32, i32* %8, align 4
  %68 = call %struct.tdata* @get_node(%struct.tnode* %66, i32 %67)
  %69 = bitcast %struct.tdata* %68 to { i8, i64 }*
  %70 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %69, i32 0, i32 0
  %71 = load i8, i8* %70, align 8
  %72 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %69, i32 0, i32 1
  %73 = load i64, i64* %72, align 8
  call void @funk_print_scalar_element(i8 %71, i64 %73)
  %74 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.26, i64 0, i64 0))
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
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.27, i64 0, i64 0), i32 %26, i32 %29)
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
  %42 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.27, i64 0, i64 0), i32 %38, i32 %41)
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
  %54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.27, i64 0, i64 0), i32 %50, i32 %53)
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
  %171 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.28, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @__FUNCTION__.funk_arith_op_rr, i64 0, i64 0))
  %172 = load i8, i8* %18, align 1
  call void @funk_print_type(i8 zeroext %172)
  %173 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.24, i64 0, i64 0))
  %174 = load i8, i8* %19, align 1
  call void @funk_print_type(i8 zeroext %174)
  %175 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.22, i64 0, i64 0))
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
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.29, i64 0, i64 0))
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
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.30, i64 0, i64 0), i32 %19)
  br label %21

21:                                               ; preds = %12
  %22 = load i32, i32* %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %3, align 4
  br label %5

24:                                               ; preds = %5
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.31, i64 0, i64 0))
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
  br i1 %10, label %11, label %19

11:                                               ; preds = %1
  %12 = load %struct.tnode*, %struct.tnode** %2, align 8
  %13 = call %struct.tdata* @get_node(%struct.tnode* %12, i32 0)
  %14 = bitcast %struct.tdata* %13 to { i8, i64 }*
  %15 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %14, i32 0, i32 1
  %18 = load i64, i64* %17, align 8
  call void @funk_print_scalar_element(i8 %16, i64 %18)
  br label %118

19:                                               ; preds = %1
  %20 = load %struct.tnode*, %struct.tnode** %2, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 3
  %22 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = icmp eq i32 %23, 1
  br i1 %24, label %25, label %45

25:                                               ; preds = %19
  store i32 0, i32* %3, align 4
  br label %26

26:                                               ; preds = %41, %25
  %27 = load i32, i32* %3, align 4
  %28 = load %struct.tnode*, %struct.tnode** %2, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 1
  %30 = load i32, i32* %29, align 4
  %31 = icmp ult i32 %27, %30
  br i1 %31, label %32, label %44

32:                                               ; preds = %26
  %33 = load %struct.tnode*, %struct.tnode** %2, align 8
  %34 = load i32, i32* %3, align 4
  %35 = call %struct.tdata* @get_node(%struct.tnode* %33, i32 %34)
  %36 = bitcast %struct.tdata* %35 to { i8, i64 }*
  %37 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %36, i32 0, i32 0
  %38 = load i8, i8* %37, align 8
  %39 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %36, i32 0, i32 1
  %40 = load i64, i64* %39, align 8
  call void @funk_print_scalar_element(i8 %38, i64 %40)
  br label %41

41:                                               ; preds = %32
  %42 = load i32, i32* %3, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, i32* %3, align 4
  br label %26

44:                                               ; preds = %26
  br label %117

45:                                               ; preds = %19
  %46 = load %struct.tnode*, %struct.tnode** %2, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 3
  %48 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %47, i32 0, i32 0
  %49 = load i32, i32* %48, align 8
  %50 = icmp eq i32 %49, 2
  br i1 %50, label %51, label %107

51:                                               ; preds = %45
  %52 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_print_node_info(%struct.tnode* %52)
  %53 = load %struct.tnode*, %struct.tnode** %2, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 3
  %55 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %54, i32 0, i32 1
  %56 = getelementptr inbounds [2 x i32], [2 x i32]* %55, i64 0, i64 0
  %57 = load i32, i32* %56, align 4
  %58 = load %struct.tnode*, %struct.tnode** %2, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 3
  %60 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %59, i32 0, i32 1
  %61 = getelementptr inbounds [2 x i32], [2 x i32]* %60, i64 0, i64 1
  %62 = load i32, i32* %61, align 4
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.32, i64 0, i64 0), i32 %57, i32 %62)
  store i32 0, i32* %4, align 4
  br label %64

64:                                               ; preds = %103, %51
  %65 = load i32, i32* %4, align 4
  %66 = load %struct.tnode*, %struct.tnode** %2, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 3
  %68 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %67, i32 0, i32 1
  %69 = getelementptr inbounds [2 x i32], [2 x i32]* %68, i64 0, i64 1
  %70 = load i32, i32* %69, align 4
  %71 = icmp ult i32 %65, %70
  br i1 %71, label %72, label %106

72:                                               ; preds = %64
  store i32 0, i32* %5, align 4
  br label %73

73:                                               ; preds = %98, %72
  %74 = load i32, i32* %5, align 4
  %75 = load %struct.tnode*, %struct.tnode** %2, align 8
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %75, i32 0, i32 3
  %77 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %76, i32 0, i32 1
  %78 = getelementptr inbounds [2 x i32], [2 x i32]* %77, i64 0, i64 0
  %79 = load i32, i32* %78, align 4
  %80 = icmp ult i32 %74, %79
  br i1 %80, label %81, label %101

81:                                               ; preds = %73
  %82 = load %struct.tnode*, %struct.tnode** %2, align 8
  %83 = load i32, i32* %4, align 4
  %84 = load %struct.tnode*, %struct.tnode** %2, align 8
  %85 = getelementptr inbounds %struct.tnode, %struct.tnode* %84, i32 0, i32 3
  %86 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %85, i32 0, i32 1
  %87 = getelementptr inbounds [2 x i32], [2 x i32]* %86, i64 0, i64 0
  %88 = load i32, i32* %87, align 4
  %89 = mul i32 %83, %88
  %90 = load i32, i32* %5, align 4
  %91 = add i32 %89, %90
  %92 = call %struct.tdata* @get_node(%struct.tnode* %82, i32 %91)
  %93 = bitcast %struct.tdata* %92 to { i8, i64 }*
  %94 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %93, i32 0, i32 0
  %95 = load i8, i8* %94, align 8
  %96 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %93, i32 0, i32 1
  %97 = load i64, i64* %96, align 8
  call void @funk_print_scalar_element(i8 %95, i64 %97)
  br label %98

98:                                               ; preds = %81
  %99 = load i32, i32* %5, align 4
  %100 = add nsw i32 %99, 1
  store i32 %100, i32* %5, align 4
  br label %73

101:                                              ; preds = %73
  %102 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.22, i64 0, i64 0))
  br label %103

103:                                              ; preds = %101
  %104 = load i32, i32* %4, align 4
  %105 = add nsw i32 %104, 1
  store i32 %105, i32* %4, align 4
  br label %64

106:                                              ; preds = %64
  br label %116

107:                                              ; preds = %45
  %108 = load %struct.tnode*, %struct.tnode** %2, align 8
  %109 = getelementptr inbounds %struct.tnode, %struct.tnode* %108, i32 0, i32 3
  %110 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %109, i32 0, i32 0
  %111 = load i32, i32* %110, align 8
  %112 = load %struct.tnode*, %struct.tnode** %2, align 8
  %113 = getelementptr inbounds %struct.tnode, %struct.tnode* %112, i32 0, i32 1
  %114 = load i32, i32* %113, align 4
  %115 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.33, i64 0, i64 0), i32 %111, i32 %114)
  br label %116

116:                                              ; preds = %107, %106
  br label %117

117:                                              ; preds = %116, %44
  br label %118

118:                                              ; preds = %117, %11
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
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([65 x i8], [65 x i8]* @.str.34, i64 0, i64 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @__FUNCTION__.print_2d_array_element_reg_reg, i64 0, i64 0), i32 %19)
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
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = load %struct.tnode*, %struct.tnode** %4, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 3
  %35 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %34, i32 0, i32 1
  %36 = getelementptr inbounds [2 x i32], [2 x i32]* %35, i64 0, i64 0
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* %7, align 4
  %39 = mul i32 %37, %38
  %40 = load i32, i32* %8, align 4
  %41 = add i32 %39, %40
  %42 = call %struct.tdata* @get_node(%struct.tnode* %32, i32 %41)
  %43 = bitcast %struct.tdata* %42 to { i8, i64 }*
  %44 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %43, i32 0, i32 0
  %45 = load i8, i8* %44, align 8
  %46 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %43, i32 0, i32 1
  %47 = load i64, i64* %46, align 8
  call void @funk_print_scalar_element(i8 %45, i64 %47)
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
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.35, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @__FUNCTION__.funk_ToFloat, i64 0, i64 0))
  call void @exit(i32 1) #5
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
  %11 = call %struct.__sFILE* @"\01_fopen"(i8* %10, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.36, i64 0, i64 0))
  store %struct.__sFILE* %11, %struct.__sFILE** %7, align 8
  %12 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %13 = icmp eq %struct.__sFILE* %12, null
  br i1 %13, label %14, label %17

14:                                               ; preds = %3
  %15 = load i8*, i8** %6, align 8
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.37, i64 0, i64 0), i8* %15)
  call void @exit(i32 1) #5
  unreachable

17:                                               ; preds = %3
  %18 = load i32, i32* @g_funk_verbosity, align 4
  %19 = icmp ugt i32 %18, 0
  br i1 %19, label %20, label %23

20:                                               ; preds = %17
  %21 = load i8*, i8** %6, align 8
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.38, i64 0, i64 0), i8* %21)
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
  %37 = call i32 (%struct.__sFILE*, i8*, ...) @fscanf(%struct.__sFILE* %36, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.39, i64 0, i64 0), i32* %8)
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
  %61 = load %struct.__sFILE*, %struct.__sFILE** %7, align 8
  %62 = call i32 @fclose(%struct.__sFILE* %61)
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
  br label %70

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
  %55 = load %struct.tnode*, %struct.tnode** %4, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 1
  %57 = load i32, i32* %56, align 4
  %58 = icmp ugt i32 %57, 0
  br i1 %58, label %59, label %70

59:                                               ; preds = %54
  %60 = load i32, i32* %7, align 4
  %61 = load %struct.tnode*, %struct.tnode** %4, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 1
  %63 = load i32, i32* %62, align 4
  %64 = icmp ugt i32 %60, %63
  br i1 %64, label %65, label %70

65:                                               ; preds = %59
  %66 = load %struct.tnode*, %struct.tnode** %4, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 1
  %68 = load i32, i32* %67, align 4
  %69 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([66 x i8], [66 x i8]* @.str.40, i64 0, i64 0), i32 %68)
  br label %70

70:                                               ; preds = %15, %65, %59, %54
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_get_len(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %5 = load %struct.tnode*, %struct.tnode** %4, align 8
  %6 = load %struct.tnode*, %struct.tnode** %3, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  call void @funk_create_int_scalar(%struct.tpool* @funk_functions_memory_pool, %struct.tnode* %5, i32 %8)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_create_sub_matrix(%struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca %struct.tnode*, align 8
  %11 = alloca %struct.tnode*, align 8
  %12 = alloca %struct.tnode*, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32*, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %7, align 8
  store %struct.tnode* %1, %struct.tnode** %8, align 8
  store %struct.tnode* %2, %struct.tnode** %9, align 8
  store %struct.tnode* %3, %struct.tnode** %10, align 8
  store %struct.tnode* %4, %struct.tnode** %11, align 8
  store %struct.tnode* %5, %struct.tnode** %12, align 8
  %20 = load %struct.tnode*, %struct.tnode** %7, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 3
  %22 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = icmp ne i32 %23, 2
  br i1 %24, label %25, label %32

25:                                               ; preds = %6
  %26 = load %struct.tnode*, %struct.tnode** %7, align 8
  call void @funk_print_node_info(%struct.tnode* %26)
  %27 = load %struct.tnode*, %struct.tnode** %7, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 3
  %29 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %28, i32 0, i32 0
  %30 = load i32, i32* %29, align 8
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.41, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 %30)
  call void @exit(i32 1) #5
  unreachable

32:                                               ; preds = %6
  %33 = load %struct.tnode*, %struct.tnode** %9, align 8
  %34 = call %struct.tdata* @get_node(%struct.tnode* %33, i32 0)
  %35 = getelementptr inbounds %struct.tdata, %struct.tdata* %34, i32 0, i32 1
  %36 = bitcast %union.data_type* %35 to i32*
  %37 = load i32, i32* %36, align 8
  %38 = load %struct.tnode*, %struct.tnode** %10, align 8
  %39 = call %struct.tdata* @get_node(%struct.tnode* %38, i32 0)
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 1
  %41 = bitcast %union.data_type* %40 to i32*
  %42 = load i32, i32* %41, align 8
  %43 = icmp sgt i32 %37, %42
  br i1 %43, label %44, label %56

44:                                               ; preds = %32
  %45 = load %struct.tnode*, %struct.tnode** %9, align 8
  %46 = call %struct.tdata* @get_node(%struct.tnode* %45, i32 0)
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 1
  %48 = bitcast %union.data_type* %47 to i32*
  %49 = load i32, i32* %48, align 8
  %50 = load %struct.tnode*, %struct.tnode** %10, align 8
  %51 = call %struct.tdata* @get_node(%struct.tnode* %50, i32 0)
  %52 = getelementptr inbounds %struct.tdata, %struct.tdata* %51, i32 0, i32 1
  %53 = bitcast %union.data_type* %52 to i32*
  %54 = load i32, i32* %53, align 8
  %55 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.42, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 %49, i32 %54)
  br label %56

56:                                               ; preds = %44, %32
  %57 = load %struct.tnode*, %struct.tnode** %11, align 8
  %58 = call %struct.tdata* @get_node(%struct.tnode* %57, i32 0)
  %59 = getelementptr inbounds %struct.tdata, %struct.tdata* %58, i32 0, i32 1
  %60 = bitcast %union.data_type* %59 to i32*
  %61 = load i32, i32* %60, align 8
  %62 = load %struct.tnode*, %struct.tnode** %12, align 8
  %63 = call %struct.tdata* @get_node(%struct.tnode* %62, i32 0)
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 1
  %65 = bitcast %union.data_type* %64 to i32*
  %66 = load i32, i32* %65, align 8
  %67 = icmp sgt i32 %61, %66
  br i1 %67, label %68, label %80

68:                                               ; preds = %56
  %69 = load %struct.tnode*, %struct.tnode** %11, align 8
  %70 = call %struct.tdata* @get_node(%struct.tnode* %69, i32 0)
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %70, i32 0, i32 1
  %72 = bitcast %union.data_type* %71 to i32*
  %73 = load i32, i32* %72, align 8
  %74 = load %struct.tnode*, %struct.tnode** %12, align 8
  %75 = call %struct.tdata* @get_node(%struct.tnode* %74, i32 0)
  %76 = getelementptr inbounds %struct.tdata, %struct.tdata* %75, i32 0, i32 1
  %77 = bitcast %union.data_type* %76 to i32*
  %78 = load i32, i32* %77, align 8
  %79 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.43, i64 0, i64 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @__FUNCTION__.funk_create_sub_matrix, i64 0, i64 0), i32 %73, i32 %78)
  br label %80

80:                                               ; preds = %68, %56
  store i32 0, i32* %13, align 4
  %81 = load %struct.tnode*, %struct.tnode** %10, align 8
  %82 = call %struct.tdata* @get_node(%struct.tnode* %81, i32 0)
  %83 = getelementptr inbounds %struct.tdata, %struct.tdata* %82, i32 0, i32 1
  %84 = bitcast %union.data_type* %83 to i32*
  %85 = load i32, i32* %84, align 8
  %86 = load %struct.tnode*, %struct.tnode** %9, align 8
  %87 = call %struct.tdata* @get_node(%struct.tnode* %86, i32 0)
  %88 = getelementptr inbounds %struct.tdata, %struct.tdata* %87, i32 0, i32 1
  %89 = bitcast %union.data_type* %88 to i32*
  %90 = load i32, i32* %89, align 8
  %91 = sub nsw i32 %85, %90
  %92 = add nsw i32 %91, 1
  store i32 %92, i32* %14, align 4
  %93 = load %struct.tnode*, %struct.tnode** %12, align 8
  %94 = call %struct.tdata* @get_node(%struct.tnode* %93, i32 0)
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %94, i32 0, i32 1
  %96 = bitcast %union.data_type* %95 to i32*
  %97 = load i32, i32* %96, align 8
  %98 = load %struct.tnode*, %struct.tnode** %11, align 8
  %99 = call %struct.tdata* @get_node(%struct.tnode* %98, i32 0)
  %100 = getelementptr inbounds %struct.tdata, %struct.tdata* %99, i32 0, i32 1
  %101 = bitcast %union.data_type* %100 to i32*
  %102 = load i32, i32* %101, align 8
  %103 = sub nsw i32 %97, %102
  %104 = add nsw i32 %103, 1
  store i32 %104, i32* %15, align 4
  %105 = load i32, i32* %14, align 4
  %106 = sext i32 %105 to i64
  %107 = mul i64 4, %106
  %108 = load i32, i32* %15, align 4
  %109 = sext i32 %108 to i64
  %110 = mul i64 %107, %109
  %111 = call i8* @malloc(i64 %110) #6
  %112 = bitcast i8* %111 to i32*
  store i32* %112, i32** %16, align 8
  store i32 0, i32* %17, align 4
  %113 = load %struct.tnode*, %struct.tnode** %9, align 8
  %114 = call %struct.tdata* @get_node(%struct.tnode* %113, i32 0)
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 1
  %116 = bitcast %union.data_type* %115 to i32*
  %117 = load i32, i32* %116, align 8
  store i32 %117, i32* %18, align 4
  br label %118

118:                                              ; preds = %179, %80
  %119 = load i32, i32* %18, align 4
  %120 = load %struct.tnode*, %struct.tnode** %10, align 8
  %121 = call %struct.tdata* @get_node(%struct.tnode* %120, i32 0)
  %122 = getelementptr inbounds %struct.tdata, %struct.tdata* %121, i32 0, i32 1
  %123 = bitcast %union.data_type* %122 to i32*
  %124 = load i32, i32* %123, align 8
  %125 = icmp sle i32 %119, %124
  br i1 %125, label %126, label %182

126:                                              ; preds = %118
  %127 = load %struct.tnode*, %struct.tnode** %11, align 8
  %128 = call %struct.tdata* @get_node(%struct.tnode* %127, i32 0)
  %129 = getelementptr inbounds %struct.tdata, %struct.tdata* %128, i32 0, i32 1
  %130 = bitcast %union.data_type* %129 to i32*
  %131 = load i32, i32* %130, align 8
  store i32 %131, i32* %19, align 4
  br label %132

132:                                              ; preds = %175, %126
  %133 = load i32, i32* %19, align 4
  %134 = load %struct.tnode*, %struct.tnode** %12, align 8
  %135 = call %struct.tdata* @get_node(%struct.tnode* %134, i32 0)
  %136 = getelementptr inbounds %struct.tdata, %struct.tdata* %135, i32 0, i32 1
  %137 = bitcast %union.data_type* %136 to i32*
  %138 = load i32, i32* %137, align 8
  %139 = icmp sle i32 %133, %138
  br i1 %139, label %140, label %178

140:                                              ; preds = %132
  %141 = load %struct.tnode*, %struct.tnode** %7, align 8
  %142 = getelementptr inbounds %struct.tnode, %struct.tnode* %141, i32 0, i32 3
  %143 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %142, i32 0, i32 1
  %144 = getelementptr inbounds [2 x i32], [2 x i32]* %143, i64 0, i64 0
  %145 = load i32, i32* %144, align 4
  %146 = load i32, i32* %18, align 4
  %147 = urem i32 %146, %145
  store i32 %147, i32* %18, align 4
  %148 = load %struct.tnode*, %struct.tnode** %7, align 8
  %149 = getelementptr inbounds %struct.tnode, %struct.tnode* %148, i32 0, i32 3
  %150 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %149, i32 0, i32 1
  %151 = getelementptr inbounds [2 x i32], [2 x i32]* %150, i64 0, i64 1
  %152 = load i32, i32* %151, align 4
  %153 = load i32, i32* %19, align 4
  %154 = urem i32 %153, %152
  store i32 %154, i32* %19, align 4
  %155 = load %struct.tnode*, %struct.tnode** %7, align 8
  %156 = load i32, i32* %18, align 4
  %157 = load %struct.tnode*, %struct.tnode** %7, align 8
  %158 = getelementptr inbounds %struct.tnode, %struct.tnode* %157, i32 0, i32 3
  %159 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %158, i32 0, i32 1
  %160 = getelementptr inbounds [2 x i32], [2 x i32]* %159, i64 0, i64 0
  %161 = load i32, i32* %160, align 4
  %162 = mul i32 %156, %161
  %163 = load i32, i32* %19, align 4
  %164 = add i32 %162, %163
  %165 = call %struct.tdata* @get_node(%struct.tnode* %155, i32 %164)
  %166 = getelementptr inbounds %struct.tdata, %struct.tdata* %165, i32 0, i32 1
  %167 = bitcast %union.data_type* %166 to i32*
  %168 = load i32, i32* %167, align 8
  %169 = load i32*, i32** %16, align 8
  %170 = load i32, i32* %17, align 4
  %171 = sext i32 %170 to i64
  %172 = getelementptr inbounds i32, i32* %169, i64 %171
  store i32 %168, i32* %172, align 4
  %173 = load i32, i32* %17, align 4
  %174 = add nsw i32 %173, 1
  store i32 %174, i32* %17, align 4
  br label %175

175:                                              ; preds = %140
  %176 = load i32, i32* %19, align 4
  %177 = add nsw i32 %176, 1
  store i32 %177, i32* %19, align 4
  br label %132

178:                                              ; preds = %132
  br label %179

179:                                              ; preds = %178
  %180 = load i32, i32* %18, align 4
  %181 = add nsw i32 %180, 1
  store i32 %181, i32* %18, align 4
  br label %118

182:                                              ; preds = %118
  %183 = load %struct.tnode*, %struct.tnode** %8, align 8
  %184 = load i32*, i32** %16, align 8
  %185 = load i32, i32* %14, align 4
  %186 = load i32, i32* %15, align 4
  call void @funk_create_2d_matrix_int_literal(%struct.tpool* @funk_global_memory_pool, %struct.tnode* %183, i32* %184, i32 %185, i32 %186)
  %187 = load i32*, i32** %16, align 8
  %188 = bitcast i32* %187 to i8*
  call void @free(i8* %188)
  ret void
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #4

declare void @free(i8*) #1

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn }
attributes #6 = { allocsize(0) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 9.0.1 "}
