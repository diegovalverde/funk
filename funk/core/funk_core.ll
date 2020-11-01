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
@g_funk_print_array_max_elements = global i32 30, align 4
@g_funk_print_array_element_per_row = global i32 50, align 4
@g_funk_verbosity = global i32 0, align 4
@.str = private unnamed_addr constant [43 x i8] c"-I- Setting conf parameter %d to value %d\0A\00", align 1
@funk_global_memory_pool = common global %struct.tpool zeroinitializer, align 8
@funk_functions_memory_pool = common global %struct.tpool zeroinitializer, align 8
@.str.1 = private unnamed_addr constant [39 x i8] c"===== FUNK Interactive debugger =====\0A\00", align 1
@.str.2 = private unnamed_addr constant [25 x i8] c"-I- Global pool size %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [26 x i8] c"-I- init_random_seed: %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [24 x i8] c"Press any key to start\0A\00", align 1
@.str.5 = private unnamed_addr constant [27 x i8] c">>>>> %d %d pool_tail: %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [38 x i8] c"-E- Indexes %d, %d are out of bounds\0A\00", align 1
@.str.7 = private unnamed_addr constant [5 x i8] c" %d \00", align 1
@.str.8 = private unnamed_addr constant [5 x i8] c" %f \00", align 1
@.str.9 = private unnamed_addr constant [4 x i8] c" ? \00", align 1
@.str.10 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.11 = private unnamed_addr constant [38 x i8] c"Stopped at the beginning of function\0A\00", align 1
@.str.12 = private unnamed_addr constant [2 x i8] c">\00", align 1
@__stdinp = external global %struct.__sFILE*, align 8
@.str.13 = private unnamed_addr constant [5 x i8] c"gmem\00", align 1
@.str.14 = private unnamed_addr constant [2 x i8] c"c\00", align 1
@.str.15 = private unnamed_addr constant [54 x i8] c"-E- Invalid index %d is greater than array size of %d\00", align 1
@.str.16 = private unnamed_addr constant [34 x i8] c"-E- funk_mul_rr: invalid types:\0A \00", align 1
@.str.17 = private unnamed_addr constant [14 x i8] c"funk_mul_rr( \00", align 1
@.str.18 = private unnamed_addr constant [7 x i8] c"%s[%d]\00", align 1
@.str.19 = private unnamed_addr constant [6 x i8] c"gpool\00", align 1
@.str.20 = private unnamed_addr constant [6 x i8] c"fpool\00", align 1
@.str.21 = private unnamed_addr constant [4 x i8] c" , \00", align 1
@.str.22 = private unnamed_addr constant [4 x i8] c" )\0A\00", align 1
@.str.23 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@.str.24 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.25 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.26 = private unnamed_addr constant [4 x i8] c" [ \00", align 1
@.str.27 = private unnamed_addr constant [5 x i8] c" ]  \00", align 1
@.str.28 = private unnamed_addr constant [9 x i8] c" [...] \0A\00", align 1

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
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 1), align 8
  store i32 0, i32* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_functions_memory_pool, i32 0, i32 1), align 8
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

; <label>:11:                                     ; preds = %2
  store i32 1, i32* %3, align 4
  br label %38

; <label>:12:                                     ; preds = %2
  %13 = load %struct.tnode*, %struct.tnode** %4, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i64 0
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  store i32 %16, i32* %6, align 4
  store i32 1, i32* %7, align 4
  br label %17

; <label>:17:                                     ; preds = %34, %12
  %18 = load i32, i32* %7, align 4
  %19 = load i32, i32* %5, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %37

; <label>:21:                                     ; preds = %17
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

; <label>:32:                                     ; preds = %21
  store i32 0, i32* %3, align 4
  br label %38

; <label>:33:                                     ; preds = %21
  br label %34

; <label>:34:                                     ; preds = %33
  %35 = load i32, i32* %7, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %7, align 4
  br label %17

; <label>:37:                                     ; preds = %17
  store i32 0, i32* %3, align 4
  br label %38

; <label>:38:                                     ; preds = %37, %32, %11
  %39 = load i32, i32* %3, align 4
  ret i32 %39
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

; <label>:20:                                     ; preds = %4
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
  br label %82

; <label>:30:                                     ; preds = %4
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
  %40 = getelementptr inbounds %struct.tpool, %struct.tpool* %39, i32 0, i32 1
  %41 = load i32, i32* %40, align 8
  %42 = load i32, i32* %8, align 4
  %43 = add i32 %41, %42
  %44 = urem i32 %43, 1024
  %45 = load %struct.tpool*, %struct.tpool** %5, align 8
  %46 = getelementptr inbounds %struct.tpool, %struct.tpool* %45, i32 0, i32 1
  store i32 %44, i32* %46, align 8
  store i32 0, i32* %9, align 4
  br label %47

; <label>:47:                                     ; preds = %78, %30
  %48 = load i32, i32* %9, align 4
  %49 = load i32, i32* %8, align 4
  %50 = icmp slt i32 %48, %49
  br i1 %50, label %51, label %81

; <label>:51:                                     ; preds = %47
  %52 = load %struct.tpool*, %struct.tpool** %5, align 8
  %53 = getelementptr inbounds %struct.tpool, %struct.tpool* %52, i32 0, i32 0
  %54 = load %struct.tnode*, %struct.tnode** %6, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 0
  %56 = load i32, i32* %55, align 8
  %57 = load i32, i32* %9, align 4
  %58 = add i32 %56, %57
  %59 = zext i32 %58 to i64
  %60 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %53, i64 0, i64 %59
  %61 = load %struct.tnode*, %struct.tnode** %7, align 8
  %62 = load i32, i32* %9, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i64 %63
  %65 = getelementptr inbounds %struct.tnode, %struct.tnode* %64, i32 0, i32 2
  %66 = load %struct.tpool*, %struct.tpool** %65, align 8
  %67 = getelementptr inbounds %struct.tpool, %struct.tpool* %66, i32 0, i32 0
  %68 = load %struct.tnode*, %struct.tnode** %7, align 8
  %69 = load i32, i32* %9, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i64 %70
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 0
  %73 = load i32, i32* %72, align 8
  %74 = zext i32 %73 to i64
  %75 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %67, i64 0, i64 %74
  %76 = bitcast %struct.tdata* %60 to i8*
  %77 = bitcast %struct.tdata* %75 to i8*
  call void @memcpy(i8* %76, i8* %77, i64 16, i32 8, i1 false)
  br label %78

; <label>:78:                                     ; preds = %51
  %79 = load i32, i32* %9, align 4
  %80 = add nsw i32 %79, 1
  store i32 %80, i32* %9, align 4
  br label %47

; <label>:81:                                     ; preds = %47
  br label %82

; <label>:82:                                     ; preds = %81, %20
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
  %30 = load %struct.tnode*, %struct.tnode** %7, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = load %struct.tnode*, %struct.tnode** %7, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = load %struct.tpool*, %struct.tpool** %6, align 8
  %37 = getelementptr inbounds %struct.tpool, %struct.tpool* %36, i32 0, i32 1
  %38 = load i32, i32* %37, align 8
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.5, i32 0, i32 0), i32 %32, i32 %35, i32 %38)
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
  %8 = getelementptr inbounds %struct.tpool, %struct.tpool* %7, i32 0, i32 1
  %9 = load i32, i32* %8, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 0
  store i32 %9, i32* %11, align 8
  %12 = load %struct.tnode*, %struct.tnode** %5, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 1
  store i32 1, i32* %13, align 4
  %14 = load %struct.tpool*, %struct.tpool** %4, align 8
  %15 = load %struct.tnode*, %struct.tnode** %5, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 2
  store %struct.tpool* %14, %struct.tpool** %16, align 8
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 3
  %19 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %18, i32 0, i32 0
  store i32 1, i32* %19, align 8
  %20 = load %struct.tpool*, %struct.tpool** %4, align 8
  %21 = getelementptr inbounds %struct.tpool, %struct.tpool* %20, i32 0, i32 1
  %22 = load i32, i32* %21, align 8
  %23 = add i32 %22, 1
  %24 = urem i32 %23, 1024
  %25 = load %struct.tpool*, %struct.tpool** %4, align 8
  %26 = getelementptr inbounds %struct.tpool, %struct.tpool* %25, i32 0, i32 1
  store i32 %24, i32* %26, align 8
  %27 = load %struct.tpool*, %struct.tpool** %4, align 8
  %28 = getelementptr inbounds %struct.tpool, %struct.tpool* %27, i32 0, i32 0
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 8
  %32 = zext i32 %31 to i64
  %33 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %28, i64 0, i64 %32
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 0
  store i8 1, i8* %34, align 8
  %35 = load i32, i32* %6, align 4
  %36 = load %struct.tpool*, %struct.tpool** %4, align 8
  %37 = getelementptr inbounds %struct.tpool, %struct.tpool* %36, i32 0, i32 0
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 0
  %40 = load i32, i32* %39, align 8
  %41 = zext i32 %40 to i64
  %42 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %37, i64 0, i64 %41
  %43 = getelementptr inbounds %struct.tdata, %struct.tdata* %42, i32 0, i32 1
  %44 = bitcast %union.data_type* %43 to i32*
  store i32 %35, i32* %44, align 8
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
  %30 = load %struct.tnode*, %struct.tnode** %7, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = load %struct.tnode*, %struct.tnode** %7, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = load %struct.tpool*, %struct.tpool** %6, align 8
  %37 = getelementptr inbounds %struct.tpool, %struct.tpool* %36, i32 0, i32 1
  %38 = load i32, i32* %37, align 8
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.5, i32 0, i32 0), i32 %32, i32 %35, i32 %38)
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
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.6, i32 0, i32 0), i32 %27, i32 %28)
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
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.7, i32 0, i32 0), i32 %13)
  br label %22

; <label>:15:                                     ; preds = %2
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %3, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.8, i32 0, i32 0), double %18)
  br label %22

; <label>:20:                                     ; preds = %2
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i32 0, i32 0))
  br label %22

; <label>:22:                                     ; preds = %20, %15, %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_global_memory() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  br label %2

; <label>:2:                                      ; preds = %23, %0
  %3 = load i32, i32* %1, align 4
  %4 = icmp slt i32 %3, 64
  br i1 %4, label %5, label %26

; <label>:5:                                      ; preds = %2
  %6 = load i32, i32* %1, align 4
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* getelementptr inbounds (%struct.tpool, %struct.tpool* @funk_global_memory_pool, i32 0, i32 0), i64 0, i64 %7
  %9 = bitcast %struct.tdata* %8 to { i8, i64 }*
  %10 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %9, i32 0, i32 0
  %11 = load i8, i8* %10, align 8
  %12 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %9, i32 0, i32 1
  %13 = load i64, i64* %12, align 8
  call void @funk_print_scalar_element(i8 %11, i64 %13)
  %14 = load i32, i32* %1, align 4
  %15 = icmp sgt i32 %14, 0
  br i1 %15, label %16, label %22

; <label>:16:                                     ; preds = %5
  %17 = load i32, i32* %1, align 4
  %18 = srem i32 %17, 16
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %22

; <label>:20:                                     ; preds = %16
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.10, i32 0, i32 0))
  br label %22

; <label>:22:                                     ; preds = %20, %16, %5
  br label %23

; <label>:23:                                     ; preds = %22
  %24 = load i32, i32* %1, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, i32* %1, align 4
  br label %2

; <label>:26:                                     ; preds = %2
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_function_entry_hook() #0 {
  %1 = alloca [8 x i8], align 1
  %2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.11, i32 0, i32 0))
  br label %3

; <label>:3:                                      ; preds = %13, %0
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.12, i32 0, i32 0))
  %5 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %6 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8
  %7 = call i8* @fgets(i8* %5, i32 8, %struct.__sFILE* %6)
  %8 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %9 = call i32 @strncmp(i8* %8, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.13, i32 0, i32 0), i64 4)
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %12, label %11

; <label>:11:                                     ; preds = %3
  call void @funk_print_global_memory()
  br label %12

; <label>:12:                                     ; preds = %11, %3
  br label %13

; <label>:13:                                     ; preds = %12
  %14 = getelementptr inbounds [8 x i8], [8 x i8]* %1, i32 0, i32 0
  %15 = call i32 @strncmp(i8* %14, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.14, i32 0, i32 0), i64 1)
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %3, label %17

; <label>:17:                                     ; preds = %13
  ret void
}

declare i8* @fgets(i8*, i32, %struct.__sFILE*) #1

declare i32 @strncmp(i8*, i8*, i64) #1

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
  %14 = load i32, i32* %9, align 4
  %15 = load %struct.tnode*, %struct.tnode** %8, align 8
  %16 = getelementptr inbounds %struct.tnode, %struct.tnode* %15, i32 0, i32 1
  %17 = load i32, i32* %16, align 4
  %18 = icmp ugt i32 %14, %17
  br i1 %18, label %19, label %25

; <label>:19:                                     ; preds = %5
  %20 = load i32, i32* %9, align 4
  %21 = load %struct.tnode*, %struct.tnode** %8, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = load i32, i32* %22, align 4
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.15, i32 0, i32 0), i32 %20, i32 %23)
  br label %25

; <label>:25:                                     ; preds = %19, %5
  %26 = load i32, i32* %7, align 4
  %27 = load %struct.tnode*, %struct.tnode** %6, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = load i32, i32* %28, align 4
  %30 = icmp ugt i32 %26, %29
  br i1 %30, label %31, label %37

; <label>:31:                                     ; preds = %25
  %32 = load i32, i32* %7, align 4
  %33 = load %struct.tnode*, %struct.tnode** %6, align 8
  %34 = getelementptr inbounds %struct.tnode, %struct.tnode* %33, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.15, i32 0, i32 0), i32 %32, i32 %35)
  br label %37

; <label>:37:                                     ; preds = %31, %25
  %38 = load %struct.tnode*, %struct.tnode** %8, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 2
  %40 = load %struct.tpool*, %struct.tpool** %39, align 8
  %41 = getelementptr inbounds %struct.tpool, %struct.tpool* %40, i32 0, i32 0
  %42 = load %struct.tnode*, %struct.tnode** %8, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 0
  %44 = load i32, i32* %43, align 8
  %45 = load i32, i32* %9, align 4
  %46 = add i32 %44, %45
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %41, i64 0, i64 %47
  %49 = bitcast %struct.tdata* %11 to i8*
  %50 = bitcast %struct.tdata* %48 to i8*
  call void @memcpy(i8* %49, i8* %50, i64 16, i32 8, i1 false)
  %51 = load %struct.tnode*, %struct.tnode** %6, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 2
  %53 = load %struct.tpool*, %struct.tpool** %52, align 8
  %54 = getelementptr inbounds %struct.tpool, %struct.tpool* %53, i32 0, i32 0
  %55 = load %struct.tnode*, %struct.tnode** %6, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 0
  %57 = load i32, i32* %56, align 8
  %58 = load i32, i32* %7, align 4
  %59 = add i32 %57, %58
  %60 = zext i32 %59 to i64
  %61 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %54, i64 0, i64 %60
  store %struct.tdata* %61, %struct.tdata** %12, align 8
  %62 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 0
  %63 = load i8, i8* %62, align 8
  store i8 %63, i8* %13, align 1
  %64 = load i8, i8* %13, align 1
  %65 = zext i8 %64 to i32
  %66 = icmp eq i32 %65, 1
  br i1 %66, label %67, label %78

; <label>:67:                                     ; preds = %37
  %68 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 1
  %69 = bitcast %union.data_type* %68 to i32*
  %70 = load i32, i32* %69, align 8
  %71 = load i32, i32* %10, align 4
  %72 = add nsw i32 %70, %71
  %73 = load %struct.tdata*, %struct.tdata** %12, align 8
  %74 = getelementptr inbounds %struct.tdata, %struct.tdata* %73, i32 0, i32 1
  %75 = bitcast %union.data_type* %74 to i32*
  store i32 %72, i32* %75, align 8
  %76 = load %struct.tdata*, %struct.tdata** %12, align 8
  %77 = getelementptr inbounds %struct.tdata, %struct.tdata* %76, i32 0, i32 0
  store i8 1, i8* %77, align 8
  br label %99

; <label>:78:                                     ; preds = %37
  %79 = load i8, i8* %13, align 1
  %80 = zext i8 %79 to i32
  %81 = icmp eq i32 %80, 2
  br i1 %81, label %82, label %94

; <label>:82:                                     ; preds = %78
  %83 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 1
  %84 = bitcast %union.data_type* %83 to double*
  %85 = load double, double* %84, align 8
  %86 = load i32, i32* %10, align 4
  %87 = sitofp i32 %86 to double
  %88 = fadd double %85, %87
  %89 = load %struct.tdata*, %struct.tdata** %12, align 8
  %90 = getelementptr inbounds %struct.tdata, %struct.tdata* %89, i32 0, i32 1
  %91 = bitcast %union.data_type* %90 to double*
  store double %88, double* %91, align 8
  %92 = load %struct.tdata*, %struct.tdata** %12, align 8
  %93 = getelementptr inbounds %struct.tdata, %struct.tdata* %92, i32 0, i32 0
  store i8 2, i8* %93, align 8
  br label %98

; <label>:94:                                     ; preds = %78
  %95 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.16, i32 0, i32 0))
  %96 = load %struct.tdata*, %struct.tdata** %12, align 8
  %97 = getelementptr inbounds %struct.tdata, %struct.tdata* %96, i32 0, i32 0
  store i8 0, i8* %97, align 8
  br label %98

; <label>:98:                                     ; preds = %94, %82
  br label %99

; <label>:99:                                     ; preds = %98, %67
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
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.15, i32 0, i32 0), i32 %24, i32 %27)
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
  %40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.15, i32 0, i32 0), i32 %36, i32 %39)
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
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.15, i32 0, i32 0), i32 %48, i32 %51)
  br label %53

; <label>:53:                                     ; preds = %47, %41
  %54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.17, i32 0, i32 0))
  %55 = load %struct.tnode*, %struct.tnode** %9, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 2
  %57 = load %struct.tpool*, %struct.tpool** %56, align 8
  %58 = icmp eq %struct.tpool* %57, @funk_global_memory_pool
  %59 = zext i1 %58 to i64
  %60 = select i1 %58, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.19, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.20, i32 0, i32 0)
  %61 = load %struct.tnode*, %struct.tnode** %9, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 0
  %63 = load i32, i32* %62, align 8
  %64 = load i32, i32* %10, align 4
  %65 = add i32 %63, %64
  %66 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.18, i32 0, i32 0), i8* %60, i32 %65)
  %67 = load %struct.tnode*, %struct.tnode** %9, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 2
  %69 = load %struct.tpool*, %struct.tpool** %68, align 8
  %70 = getelementptr inbounds %struct.tpool, %struct.tpool* %69, i32 0, i32 0
  %71 = load i32, i32* %10, align 4
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %70, i64 0, i64 %72
  %74 = bitcast %struct.tdata* %73 to { i8, i64 }*
  %75 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %74, i32 0, i32 0
  %76 = load i8, i8* %75, align 8
  %77 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %74, i32 0, i32 1
  %78 = load i64, i64* %77, align 8
  call void @funk_print_scalar_element(i8 %76, i64 %78)
  %79 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.21, i32 0, i32 0))
  %80 = load %struct.tnode*, %struct.tnode** %11, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 2
  %82 = load %struct.tpool*, %struct.tpool** %81, align 8
  %83 = icmp eq %struct.tpool* %82, @funk_global_memory_pool
  %84 = zext i1 %83 to i64
  %85 = select i1 %83, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.19, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.20, i32 0, i32 0)
  %86 = load %struct.tnode*, %struct.tnode** %11, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 0
  %88 = load i32, i32* %87, align 8
  %89 = load i32, i32* %12, align 4
  %90 = add i32 %88, %89
  %91 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.18, i32 0, i32 0), i8* %85, i32 %90)
  %92 = load %struct.tnode*, %struct.tnode** %11, align 8
  %93 = getelementptr inbounds %struct.tnode, %struct.tnode* %92, i32 0, i32 2
  %94 = load %struct.tpool*, %struct.tpool** %93, align 8
  %95 = getelementptr inbounds %struct.tpool, %struct.tpool* %94, i32 0, i32 0
  %96 = load i32, i32* %12, align 4
  %97 = sext i32 %96 to i64
  %98 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %95, i64 0, i64 %97
  %99 = bitcast %struct.tdata* %98 to { i8, i64 }*
  %100 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %99, i32 0, i32 0
  %101 = load i8, i8* %100, align 8
  %102 = getelementptr inbounds { i8, i64 }, { i8, i64 }* %99, i32 0, i32 1
  %103 = load i64, i64* %102, align 8
  call void @funk_print_scalar_element(i8 %101, i64 %103)
  %104 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.22, i32 0, i32 0))
  %105 = load %struct.tnode*, %struct.tnode** %9, align 8
  %106 = getelementptr inbounds %struct.tnode, %struct.tnode* %105, i32 0, i32 2
  %107 = load %struct.tpool*, %struct.tpool** %106, align 8
  %108 = getelementptr inbounds %struct.tpool, %struct.tpool* %107, i32 0, i32 0
  %109 = load %struct.tnode*, %struct.tnode** %9, align 8
  %110 = getelementptr inbounds %struct.tnode, %struct.tnode* %109, i32 0, i32 0
  %111 = load i32, i32* %110, align 8
  %112 = load i32, i32* %10, align 4
  %113 = add i32 %111, %112
  %114 = zext i32 %113 to i64
  %115 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %108, i64 0, i64 %114
  %116 = bitcast %struct.tdata* %13 to i8*
  %117 = bitcast %struct.tdata* %115 to i8*
  call void @memcpy(i8* %116, i8* %117, i64 16, i32 8, i1 false)
  %118 = load %struct.tnode*, %struct.tnode** %11, align 8
  %119 = getelementptr inbounds %struct.tnode, %struct.tnode* %118, i32 0, i32 2
  %120 = load %struct.tpool*, %struct.tpool** %119, align 8
  %121 = getelementptr inbounds %struct.tpool, %struct.tpool* %120, i32 0, i32 0
  %122 = load %struct.tnode*, %struct.tnode** %11, align 8
  %123 = getelementptr inbounds %struct.tnode, %struct.tnode* %122, i32 0, i32 0
  %124 = load i32, i32* %123, align 8
  %125 = load i32, i32* %12, align 4
  %126 = add i32 %124, %125
  %127 = zext i32 %126 to i64
  %128 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %121, i64 0, i64 %127
  %129 = bitcast %struct.tdata* %14 to i8*
  %130 = bitcast %struct.tdata* %128 to i8*
  call void @memcpy(i8* %129, i8* %130, i64 16, i32 8, i1 false)
  %131 = load %struct.tnode*, %struct.tnode** %7, align 8
  %132 = getelementptr inbounds %struct.tnode, %struct.tnode* %131, i32 0, i32 2
  %133 = load %struct.tpool*, %struct.tpool** %132, align 8
  %134 = getelementptr inbounds %struct.tpool, %struct.tpool* %133, i32 0, i32 0
  %135 = load %struct.tnode*, %struct.tnode** %7, align 8
  %136 = getelementptr inbounds %struct.tnode, %struct.tnode* %135, i32 0, i32 0
  %137 = load i32, i32* %136, align 8
  %138 = load i32, i32* %8, align 4
  %139 = add i32 %137, %138
  %140 = zext i32 %139 to i64
  %141 = getelementptr inbounds [1024 x %struct.tdata], [1024 x %struct.tdata]* %134, i64 0, i64 %140
  store %struct.tdata* %141, %struct.tdata** %15, align 8
  %142 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 0
  %143 = load i8, i8* %142, align 8
  store i8 %143, i8* %16, align 1
  %144 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %145 = load i8, i8* %144, align 8
  store i8 %145, i8* %17, align 1
  %146 = load i8, i8* %16, align 1
  %147 = zext i8 %146 to i32
  %148 = icmp eq i32 %147, 1
  br i1 %148, label %149, label %166

; <label>:149:                                    ; preds = %53
  %150 = load i8, i8* %17, align 1
  %151 = zext i8 %150 to i32
  %152 = icmp eq i32 %151, 1
  br i1 %152, label %153, label %166

; <label>:153:                                    ; preds = %149
  %154 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %155 = bitcast %union.data_type* %154 to i32*
  %156 = load i32, i32* %155, align 8
  %157 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %158 = bitcast %union.data_type* %157 to i32*
  %159 = load i32, i32* %158, align 8
  %160 = mul nsw i32 %156, %159
  %161 = load %struct.tdata*, %struct.tdata** %15, align 8
  %162 = getelementptr inbounds %struct.tdata, %struct.tdata* %161, i32 0, i32 1
  %163 = bitcast %union.data_type* %162 to i32*
  store i32 %160, i32* %163, align 8
  %164 = load %struct.tdata*, %struct.tdata** %15, align 8
  %165 = getelementptr inbounds %struct.tdata, %struct.tdata* %164, i32 0, i32 0
  store i8 1, i8* %165, align 8
  br label %238

; <label>:166:                                    ; preds = %149, %53
  %167 = load i8, i8* %16, align 1
  %168 = zext i8 %167 to i32
  %169 = icmp eq i32 %168, 2
  br i1 %169, label %170, label %187

; <label>:170:                                    ; preds = %166
  %171 = load i8, i8* %17, align 1
  %172 = zext i8 %171 to i32
  %173 = icmp eq i32 %172, 2
  br i1 %173, label %174, label %187

; <label>:174:                                    ; preds = %170
  %175 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %176 = bitcast %union.data_type* %175 to double*
  %177 = load double, double* %176, align 8
  %178 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %179 = bitcast %union.data_type* %178 to double*
  %180 = load double, double* %179, align 8
  %181 = fmul double %177, %180
  %182 = load %struct.tdata*, %struct.tdata** %15, align 8
  %183 = getelementptr inbounds %struct.tdata, %struct.tdata* %182, i32 0, i32 1
  %184 = bitcast %union.data_type* %183 to double*
  store double %181, double* %184, align 8
  %185 = load %struct.tdata*, %struct.tdata** %15, align 8
  %186 = getelementptr inbounds %struct.tdata, %struct.tdata* %185, i32 0, i32 0
  store i8 2, i8* %186, align 8
  br label %237

; <label>:187:                                    ; preds = %170, %166
  %188 = load i8, i8* %16, align 1
  %189 = zext i8 %188 to i32
  %190 = icmp eq i32 %189, 2
  br i1 %190, label %191, label %209

; <label>:191:                                    ; preds = %187
  %192 = load i8, i8* %17, align 1
  %193 = zext i8 %192 to i32
  %194 = icmp eq i32 %193, 1
  br i1 %194, label %195, label %209

; <label>:195:                                    ; preds = %191
  %196 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %197 = bitcast %union.data_type* %196 to double*
  %198 = load double, double* %197, align 8
  %199 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %200 = bitcast %union.data_type* %199 to i32*
  %201 = load i32, i32* %200, align 8
  %202 = sitofp i32 %201 to double
  %203 = fmul double %198, %202
  %204 = load %struct.tdata*, %struct.tdata** %15, align 8
  %205 = getelementptr inbounds %struct.tdata, %struct.tdata* %204, i32 0, i32 1
  %206 = bitcast %union.data_type* %205 to double*
  store double %203, double* %206, align 8
  %207 = load %struct.tdata*, %struct.tdata** %15, align 8
  %208 = getelementptr inbounds %struct.tdata, %struct.tdata* %207, i32 0, i32 0
  store i8 2, i8* %208, align 8
  br label %236

; <label>:209:                                    ; preds = %191, %187
  %210 = load i8, i8* %16, align 1
  %211 = zext i8 %210 to i32
  %212 = icmp eq i32 %211, 1
  br i1 %212, label %213, label %231

; <label>:213:                                    ; preds = %209
  %214 = load i8, i8* %17, align 1
  %215 = zext i8 %214 to i32
  %216 = icmp eq i32 %215, 2
  br i1 %216, label %217, label %231

; <label>:217:                                    ; preds = %213
  %218 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 1
  %219 = bitcast %union.data_type* %218 to i32*
  %220 = load i32, i32* %219, align 8
  %221 = sitofp i32 %220 to double
  %222 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 1
  %223 = bitcast %union.data_type* %222 to double*
  %224 = load double, double* %223, align 8
  %225 = fmul double %221, %224
  %226 = load %struct.tdata*, %struct.tdata** %15, align 8
  %227 = getelementptr inbounds %struct.tdata, %struct.tdata* %226, i32 0, i32 1
  %228 = bitcast %union.data_type* %227 to double*
  store double %225, double* %228, align 8
  %229 = load %struct.tdata*, %struct.tdata** %15, align 8
  %230 = getelementptr inbounds %struct.tdata, %struct.tdata* %229, i32 0, i32 0
  store i8 2, i8* %230, align 8
  br label %235

; <label>:231:                                    ; preds = %213, %209
  %232 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.16, i32 0, i32 0))
  %233 = load %struct.tdata*, %struct.tdata** %15, align 8
  %234 = getelementptr inbounds %struct.tdata, %struct.tdata* %233, i32 0, i32 0
  store i8 0, i8* %234, align 8
  br label %235

; <label>:235:                                    ; preds = %231, %217
  br label %236

; <label>:236:                                    ; preds = %235, %195
  br label %237

; <label>:237:                                    ; preds = %236, %174
  br label %238

; <label>:238:                                    ; preds = %237, %153
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_dimension(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.23, i32 0, i32 0))
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
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.24, i32 0, i32 0), i32 %19)
  br label %21

; <label>:21:                                     ; preds = %12
  %22 = load i32, i32* %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %3, align 4
  br label %5

; <label>:24:                                     ; preds = %5
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i32 0, i32 0))
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
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.26, i32 0, i32 0))
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
  %64 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.27, i32 0, i32 0))
  br label %127

; <label>:65:                                     ; preds = %26
  %66 = load %struct.tnode*, %struct.tnode** %2, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 3
  %68 = getelementptr inbounds %struct.tdimensions, %struct.tdimensions* %67, i32 0, i32 0
  %69 = load i32, i32* %68, align 8
  %70 = icmp eq i32 %69, 2
  br i1 %70, label %71, label %124

; <label>:71:                                     ; preds = %65
  %72 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.10, i32 0, i32 0))
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
  %119 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.10, i32 0, i32 0))
  br label %120

; <label>:120:                                    ; preds = %118
  %121 = load i32, i32* %4, align 4
  %122 = add nsw i32 %121, 1
  store i32 %122, i32* %4, align 4
  br label %73

; <label>:123:                                    ; preds = %73
  br label %126

; <label>:124:                                    ; preds = %65
  %125 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.28, i32 0, i32 0))
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

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 6.0.1 (tags/RELEASE_601/final)"}
