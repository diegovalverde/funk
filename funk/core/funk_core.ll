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

@g_funk_print_array_max_elements = global i32 30, align 4
@g_funk_print_array_element_per_row = global i32 50, align 4
@g_funk_verbosity = global i32 0, align 4
@.str = private unnamed_addr constant [43 x i8] c"-I- Setting conf parameter %d to value %d\0A\00", align 1
@funk_global_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str.1 = private unnamed_addr constant [39 x i8] c"===== FUNK Interactive debugger =====\0A\00", align 1
@.str.2 = private unnamed_addr constant [25 x i8] c"-I- Global pool size %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [26 x i8] c"-I- init_random_seed: %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [24 x i8] c"Press any key to start\0A\00", align 1
@.str.5 = private unnamed_addr constant [38 x i8] c"-E- Indexes %d, %d are out of bounds\0A\00", align 1
@.str.6 = private unnamed_addr constant [38 x i8] c"Stopped at the beginning of function\0A\00", align 1
@__stdinp = external global %struct.__sFILE*, align 8
@.str.7 = private unnamed_addr constant [54 x i8] c"-E- Invalid index %d is greater than array size of %d\00", align 1
@.str.8 = private unnamed_addr constant [34 x i8] c"-E- funk_mul_rr: invalid types:\0A \00", align 1
@.str.9 = private unnamed_addr constant [6 x i8] c" %d, \00", align 1
@.str.10 = private unnamed_addr constant [6 x i8] c" %f, \00", align 1
@.str.11 = private unnamed_addr constant [26 x i8] c"-E- Cannot print type %d\0A\00", align 1
@.str.12 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.13 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.14 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.15 = private unnamed_addr constant [4 x i8] c" [ \00", align 1
@.str.16 = private unnamed_addr constant [5 x i8] c" ]  \00", align 1
@.str.17 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.18 = private unnamed_addr constant [9 x i8] c" [...] \0A\00", align 1

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
define void @funk_init() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = call i64 @time(i64* null)
  %4 = trunc i64 %3 to i32
  store i32 %4, i32* %1, align 4
  %5 = load i32, i32* %1, align 4
  call void @srand(i32 %5)
  store i32 0, i32* %2, align 4
  br label %6

; <label>:6:                                      ; preds = %15, %0
  %7 = load i32, i32* %2, align 4
  %8 = icmp slt i32 %7, 1024
  br i1 %8, label %9, label %18

; <label>:9:                                      ; preds = %6
  %10 = load i32, i32* %2, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 0), i64 0, i64 %11
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 1
  %14 = bitcast %union.data_type* %13 to i32*
  store i32 0, i32* %14, align 8
  br label %15

; <label>:15:                                     ; preds = %9
  %16 = load i32, i32* %2, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, i32* %2, align 4
  br label %6

; <label>:18:                                     ; preds = %6
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.1, i32 0, i32 0))
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.2, i32 0, i32 0), i32 1024)
  %21 = load i32, i32* %1, align 4
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.3, i32 0, i32 0), i32 %21)
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.4, i32 0, i32 0))
  %24 = call i32 @getchar()
  ret void
}

declare i64 @time(i64*) #1

declare void @srand(i32) #1

declare i32 @getchar() #1

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
  %25 = getelementptr inbounds %struct.tpool, %struct.tpool* %24, i32 0, i32 1
  %26 = load i32, i32* %25, align 8
  %27 = load i32, i32* %8, align 4
  %28 = add i32 %26, %27
  %29 = urem i32 %28, 1024
  %30 = load %struct.tpool*, %struct.tpool** %5, align 8
  %31 = getelementptr inbounds %struct.tpool, %struct.tpool* %30, i32 0, i32 1
  store i32 %29, i32* %31, align 8
  store i32 0, i32* %9, align 4
  br label %32

; <label>:32:                                     ; preds = %63, %4
  %33 = load i32, i32* %9, align 4
  %34 = load i32, i32* %8, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %66

; <label>:36:                                     ; preds = %32
  %37 = load %struct.tpool*, %struct.tpool** %5, align 8
  %38 = getelementptr inbounds %struct.tpool, %struct.tpool* %37, i32 0, i32 0
  %39 = load %struct.tnode*, %struct.tnode** %6, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 0
  %41 = load i32, i32* %40, align 8
  %42 = load i32, i32* %9, align 4
  %43 = add i32 %41, %42
  %44 = zext i32 %43 to i64
  %45 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %38, i64 0, i64 %44
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 0
  store i8 1, i8* %46, align 8
  %47 = load i32*, i32** %7, align 8
  %48 = load i32, i32* %9, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds i32, i32* %47, i64 %49
  %51 = load i32, i32* %50, align 4
  %52 = load %struct.tpool*, %struct.tpool** %5, align 8
  %53 = getelementptr inbounds %struct.tpool, %struct.tpool* %52, i32 0, i32 0
  %54 = load %struct.tnode*, %struct.tnode** %6, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 0
  %56 = load i32, i32* %55, align 8
  %57 = load i32, i32* %9, align 4
  %58 = add i32 %56, %57
  %59 = zext i32 %58 to i64
  %60 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %53, i64 0, i64 %59
  %61 = getelementptr inbounds %struct.tdata, %struct.tdata* %60, i32 0, i32 1
  %62 = bitcast %union.data_type* %61 to i32*
  store i32 %51, i32* %62, align 8
  br label %63

; <label>:63:                                     ; preds = %36
  %64 = load i32, i32* %9, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, i32* %9, align 4
  br label %32

; <label>:66:                                     ; preds = %32
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

; <label>:26:                                     ; preds = %5
  %27 = load i32, i32* %9, align 4
  %28 = load i32, i32* %10, align 4
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.5, i32 0, i32 0), i32 %27, i32 %28)
  br label %40

; <label>:30:                                     ; preds = %5
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

; <label>:40:                                     ; preds = %30, %26
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_function_entry_hook() #0 {
  %1 = alloca [8 x i8], align 1
  %2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.6, i32 0, i32 0))
  %3 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %4 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8
  %5 = call i8* @fgets(i8* %3, i32 8, %struct.__sFILE* %4)
  ret void
}

declare i8* @fgets(i8*, i32, %struct.__sFILE*) #1

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

; Function Attrs: argmemonly nounwind
declare void @memcpy(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

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
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.7, i32 0, i32 0), i32 %24, i32 %27)
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
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.7, i32 0, i32 0), i32 %36, i32 %39)
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
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.7, i32 0, i32 0), i32 %48, i32 %51)
  br label %53

; <label>:53:                                     ; preds = %47, %41
  %54 = load %struct.tnode*, %struct.tnode** %9, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 2
  %56 = load %struct.tpool*, %struct.tpool** %55, align 8
  %57 = getelementptr inbounds %struct.tpool, %struct.tpool* %56, i32 0, i32 0
  %58 = load i32, i32* %10, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %57, i64 0, i64 %59
  %61 = bitcast %struct.tdata* %13 to i8*
  %62 = bitcast %struct.tdata* %60 to i8*
  call void @memcpy(i8* %61, i8* %62, i64 16, i32 8, i1 false)
  %63 = load %struct.tnode*, %struct.tnode** %11, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 2
  %65 = load %struct.tpool*, %struct.tpool** %64, align 8
  %66 = getelementptr inbounds %struct.tpool, %struct.tpool* %65, i32 0, i32 0
  %67 = load i32, i32* %12, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %66, i64 0, i64 %68
  %70 = bitcast %struct.tdata* %14 to i8*
  %71 = bitcast %struct.tdata* %69 to i8*
  call void @memcpy(i8* %70, i8* %71, i64 16, i32 8, i1 false)
  %72 = load %struct.tnode*, %struct.tnode** %7, align 8
  %73 = getelementptr inbounds %struct.tnode, %struct.tnode* %72, i32 0, i32 2
  %74 = load %struct.tpool*, %struct.tpool** %73, align 8
  %75 = getelementptr inbounds %struct.tpool, %struct.tpool* %74, i32 0, i32 0
  %76 = load i32, i32* %8, align 4
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %75, i64 0, i64 %77
  store %struct.tdata* %78, %struct.tdata** %15, align 8
  %79 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 0
  %80 = load i8, i8* %79, align 8
  store i8 %80, i8* %16, align 1
  %81 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %82 = load i8, i8* %81, align 8
  store i8 %82, i8* %17, align 1
  %83 = load i8, i8* %16, align 1
  %84 = zext i8 %83 to i32
  %85 = icmp eq i32 %84, 1
  br i1 %85, label %86, label %103

; <label>:86:                                     ; preds = %53
  %87 = load i8, i8* %17, align 1
  %88 = zext i8 %87 to i32
  %89 = icmp eq i32 %88, 1
  br i1 %89, label %90, label %103

; <label>:90:                                     ; preds = %86
  %91 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %92 = bitcast %union.data_type* %91 to i32*
  %93 = load i32, i32* %92, align 8
  %94 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %95 = bitcast %union.data_type* %94 to i32*
  %96 = load i32, i32* %95, align 8
  %97 = mul nsw i32 %93, %96
  %98 = load %struct.tdata*, %struct.tdata** %15, align 8
  %99 = getelementptr inbounds %struct.tdata, %struct.tdata* %98, i32 0, i32 1
  %100 = bitcast %union.data_type* %99 to i32*
  store i32 %97, i32* %100, align 8
  %101 = load %struct.tdata*, %struct.tdata** %15, align 8
  %102 = getelementptr inbounds %struct.tdata, %struct.tdata* %101, i32 0, i32 0
  store i8 1, i8* %102, align 8
  br label %175

; <label>:103:                                    ; preds = %86, %53
  %104 = load i8, i8* %16, align 1
  %105 = zext i8 %104 to i32
  %106 = icmp eq i32 %105, 2
  br i1 %106, label %107, label %124

; <label>:107:                                    ; preds = %103
  %108 = load i8, i8* %17, align 1
  %109 = zext i8 %108 to i32
  %110 = icmp eq i32 %109, 2
  br i1 %110, label %111, label %124

; <label>:111:                                    ; preds = %107
  %112 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %113 = bitcast %union.data_type* %112 to double*
  %114 = load double, double* %113, align 8
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %116 = bitcast %union.data_type* %115 to double*
  %117 = load double, double* %116, align 8
  %118 = fmul double %114, %117
  %119 = load %struct.tdata*, %struct.tdata** %15, align 8
  %120 = getelementptr inbounds %struct.tdata, %struct.tdata* %119, i32 0, i32 1
  %121 = bitcast %union.data_type* %120 to double*
  store double %118, double* %121, align 8
  %122 = load %struct.tdata*, %struct.tdata** %15, align 8
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %122, i32 0, i32 0
  store i8 2, i8* %123, align 8
  br label %174

; <label>:124:                                    ; preds = %107, %103
  %125 = load i8, i8* %16, align 1
  %126 = zext i8 %125 to i32
  %127 = icmp eq i32 %126, 2
  br i1 %127, label %128, label %146

; <label>:128:                                    ; preds = %124
  %129 = load i8, i8* %17, align 1
  %130 = zext i8 %129 to i32
  %131 = icmp eq i32 %130, 1
  br i1 %131, label %132, label %146

; <label>:132:                                    ; preds = %128
  %133 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %134 = bitcast %union.data_type* %133 to double*
  %135 = load double, double* %134, align 8
  %136 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %137 = bitcast %union.data_type* %136 to i32*
  %138 = load i32, i32* %137, align 8
  %139 = sitofp i32 %138 to double
  %140 = fmul double %135, %139
  %141 = load %struct.tdata*, %struct.tdata** %15, align 8
  %142 = getelementptr inbounds %struct.tdata, %struct.tdata* %141, i32 0, i32 1
  %143 = bitcast %union.data_type* %142 to double*
  store double %140, double* %143, align 8
  %144 = load %struct.tdata*, %struct.tdata** %15, align 8
  %145 = getelementptr inbounds %struct.tdata, %struct.tdata* %144, i32 0, i32 0
  store i8 2, i8* %145, align 8
  br label %173

; <label>:146:                                    ; preds = %128, %124
  %147 = load i8, i8* %16, align 1
  %148 = zext i8 %147 to i32
  %149 = icmp eq i32 %148, 1
  br i1 %149, label %150, label %168

; <label>:150:                                    ; preds = %146
  %151 = load i8, i8* %17, align 1
  %152 = zext i8 %151 to i32
  %153 = icmp eq i32 %152, 2
  br i1 %153, label %154, label %168

; <label>:154:                                    ; preds = %150
  %155 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %156 = bitcast %union.data_type* %155 to i32*
  %157 = load i32, i32* %156, align 8
  %158 = sitofp i32 %157 to double
  %159 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %160 = bitcast %union.data_type* %159 to double*
  %161 = load double, double* %160, align 8
  %162 = fmul double %158, %161
  %163 = load %struct.tdata*, %struct.tdata** %15, align 8
  %164 = getelementptr inbounds %struct.tdata, %struct.tdata* %163, i32 0, i32 1
  %165 = bitcast %union.data_type* %164 to double*
  store double %162, double* %165, align 8
  %166 = load %struct.tdata*, %struct.tdata** %15, align 8
  %167 = getelementptr inbounds %struct.tdata, %struct.tdata* %166, i32 0, i32 0
  store i8 2, i8* %167, align 8
  br label %172

; <label>:168:                                    ; preds = %150, %146
  %169 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.8, i32 0, i32 0))
  %170 = load %struct.tdata*, %struct.tdata** %15, align 8
  %171 = getelementptr inbounds %struct.tdata, %struct.tdata* %170, i32 0, i32 0
  store i8 0, i8* %171, align 8
  br label %172

; <label>:172:                                    ; preds = %168, %154
  br label %173

; <label>:173:                                    ; preds = %172, %132
  br label %174

; <label>:174:                                    ; preds = %173, %111
  br label %175

; <label>:175:                                    ; preds = %174, %90
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
  switch i32 %9, label %20 [
    i32 1, label %10
    i32 2, label %15
  ]

; <label>:10:                                     ; preds = %2
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %12 = bitcast %union.data_type* %11 to i32*
  %13 = load i32, i32* %12, align 8
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i32 0, i32 0), i32 %13)
  br label %25

; <label>:15:                                     ; preds = %2
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), double %18)
  br label %25

; <label>:20:                                     ; preds = %2
  %21 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 0
  %22 = load i8, i8* %21, align 8
  %23 = zext i8 %22 to i32
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.11, i32 0, i32 0), i32 %23)
  br label %25

; <label>:25:                                     ; preds = %20, %15, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_dimension(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.12, i32 0, i32 0))
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
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.13, i32 0, i32 0), i32 %19)
  br label %21

; <label>:21:                                     ; preds = %12
  %22 = load i32, i32* %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %3, align 4
  br label %5

; <label>:24:                                     ; preds = %5
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.14, i32 0, i32 0))
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
  br i1 %10, label %11, label %22

; <label>:11:                                     ; preds = %1
  %12 = load %struct.tnode*, %struct.tnode** %2, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 2
  %14 = load %struct.tpool*, %struct.tpool** %13, align 8
  %15 = getelementptr inbounds %struct.tpool, %struct.tpool* %14, i32 0, i32 0
  %16 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %15, i64 0, i64 0
  %17 = bitcast %struct.tdata* %16 to { i8, i64 }*
  %18 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %17, i32 0, i32 0
  %19 = load i8, i8* %18, align 8
  %20 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %17, i32 0, i32 1
  %21 = load i64, i64* %20, align 8
  call void @funk_print_scalar_element(i8 %19, i64 %21)
  br label %124

; <label>:22:                                     ; preds = %1
  %23 = load %struct.tnode*, %struct.tnode** %2, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 3
  %25 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = icmp eq i32 %26, 1
  br i1 %27, label %28, label %61

; <label>:28:                                     ; preds = %22
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.15, i32 0, i32 0))
  %30 = load %struct.tnode*, %struct.tnode** %2, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  store i32 %32, i32* %3, align 4
  br label %33

; <label>:33:                                     ; preds = %56, %28
  %34 = load i32, i32* %3, align 4
  %35 = load %struct.tnode*, %struct.tnode** %2, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 0
  %37 = load i32, i32* %36, align 8
  %38 = load %struct.tnode*, %struct.tnode** %2, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = load i32, i32* %39, align 4
  %41 = add i32 %37, %40
  %42 = icmp ult i32 %34, %41
  br i1 %42, label %43, label %59

; <label>:43:                                     ; preds = %33
  %44 = load %struct.tnode*, %struct.tnode** %2, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 2
  %46 = load %struct.tpool*, %struct.tpool** %45, align 8
  %47 = getelementptr inbounds %struct.tpool, %struct.tpool* %46, i32 0, i32 0
  %48 = load i32, i32* %3, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %47, i64 0, i64 %49
  %51 = bitcast %struct.tdata* %50 to { i8, i64 }*
  %52 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %51, i32 0, i32 0
  %53 = load i8, i8* %52, align 8
  %54 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %51, i32 0, i32 1
  %55 = load i64, i64* %54, align 8
  call void @funk_print_scalar_element(i8 %53, i64 %55)
  br label %56

; <label>:56:                                     ; preds = %43
  %57 = load i32, i32* %3, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, i32* %3, align 4
  br label %33

; <label>:59:                                     ; preds = %33
  %60 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.16, i32 0, i32 0))
  br label %123

; <label>:61:                                     ; preds = %22
  %62 = load %struct.tnode*, %struct.tnode** %2, align 8
  %63 = getelementptr inbounds %struct.tnode, %struct.tnode* %62, i32 0, i32 3
  %64 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %63, i32 0, i32 0
  %65 = load i32, i32* %64, align 8
  %66 = icmp eq i32 %65, 2
  br i1 %66, label %67, label %120

; <label>:67:                                     ; preds = %61
  %68 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.17, i32 0, i32 0))
  store i32 0, i32* %4, align 4
  br label %69

; <label>:69:                                     ; preds = %116, %67
  %70 = load i32, i32* %4, align 4
  %71 = load %struct.tnode*, %struct.tnode** %2, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 3
  %73 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %72, i32 0, i32 1
  %74 = getelementptr inbounds [2 x i32], [2 x i32]* %73, i64 0, i64 0
  %75 = load i32, i32* %74, align 4
  %76 = icmp ult i32 %70, %75
  br i1 %76, label %77, label %119

; <label>:77:                                     ; preds = %69
  store i32 0, i32* %5, align 4
  br label %78

; <label>:78:                                     ; preds = %111, %77
  %79 = load i32, i32* %5, align 4
  %80 = load %struct.tnode*, %struct.tnode** %2, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 3
  %82 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %81, i32 0, i32 1
  %83 = getelementptr inbounds [2 x i32], [2 x i32]* %82, i64 0, i64 1
  %84 = load i32, i32* %83, align 4
  %85 = icmp ult i32 %79, %84
  br i1 %85, label %86, label %114

; <label>:86:                                     ; preds = %78
  %87 = load %struct.tnode*, %struct.tnode** %2, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 2
  %89 = load %struct.tpool*, %struct.tpool** %88, align 8
  %90 = getelementptr inbounds %struct.tpool, %struct.tpool* %89, i32 0, i32 0
  %91 = load %struct.tnode*, %struct.tnode** %2, align 8
  %92 = getelementptr inbounds %struct.tnode, %struct.tnode* %91, i32 0, i32 0
  %93 = load i32, i32* %92, align 8
  %94 = load i32, i32* %4, align 4
  %95 = load %struct.tnode*, %struct.tnode** %2, align 8
  %96 = getelementptr inbounds %struct.tnode, %struct.tnode* %95, i32 0, i32 3
  %97 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %96, i32 0, i32 1
  %98 = getelementptr inbounds [2 x i32], [2 x i32]* %97, i64 0, i64 0
  %99 = load i32, i32* %98, align 4
  %100 = mul i32 %94, %99
  %101 = add i32 %93, %100
  %102 = load i32, i32* %5, align 4
  %103 = add i32 %101, %102
  %104 = zext i32 %103 to i64
  %105 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %90, i64 0, i64 %104
  %106 = bitcast %struct.tdata* %105 to { i8, i64 }*
  %107 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %106, i32 0, i32 0
  %108 = load i8, i8* %107, align 8
  %109 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %106, i32 0, i32 1
  %110 = load i64, i64* %109, align 8
  call void @funk_print_scalar_element(i8 %108, i64 %110)
  br label %111

; <label>:111:                                    ; preds = %86
  %112 = load i32, i32* %5, align 4
  %113 = add nsw i32 %112, 1
  store i32 %113, i32* %5, align 4
  br label %78

; <label>:114:                                    ; preds = %78
  %115 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.17, i32 0, i32 0))
  br label %116

; <label>:116:                                    ; preds = %114
  %117 = load i32, i32* %4, align 4
  %118 = add nsw i32 %117, 1
  store i32 %118, i32* %4, align 4
  br label %69

; <label>:119:                                    ; preds = %69
  br label %122

; <label>:120:                                    ; preds = %61
  %121 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.18, i32 0, i32 0))
  br label %122

; <label>:122:                                    ; preds = %120, %119
  br label %123

; <label>:123:                                    ; preds = %122, %59
  br label %124

; <label>:124:                                    ; preds = %123, %11
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 6.0.1 (tags/RELEASE_601/final)"}
