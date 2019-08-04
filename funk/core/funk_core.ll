; ModuleID = 'funk/core/c_model/funk_c_model.c'
source_filename = "funk/core/c_model/funk_c_model.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

%struct.tnode = type { i8, %struct.tdata, %struct.tnode*, i32 }
%struct.tdata = type { i8, %union.data_type }
%union.data_type = type { double }
%struct.GC = type { %struct.gcNode*, %struct.gcNode* }
%struct.gcNode = type { %struct.tnode*, %struct.gcNode* }

@g_funk_print_array_max_elements = global i32 30, align 4
@g_funk_print_array_element_per_row = global i32 50, align 4
@g_funk_verbosity = global i32 0, align 4
@.str = private unnamed_addr constant [13 x i8] c"invalid_type\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"int\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"double\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"array\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"empty_array\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"scalar\00", align 1
@.str.6 = private unnamed_addr constant [9 x i8] c"function\00", align 1
@.str.7 = private unnamed_addr constant [8 x i8] c"unknown\00", align 1
@.str.8 = private unnamed_addr constant [16 x i8] c"Node = nullptr\0A\00", align 1
@.str.9 = private unnamed_addr constant [10 x i8] c"addr: %p \00", align 1
@.str.10 = private unnamed_addr constant [38 x i8] c"data_type 'invalid_type' node_type %s\00", align 1
@.str.11 = private unnamed_addr constant [38 x i8] c"data_type 'int' value %d node_type %s\00", align 1
@.str.12 = private unnamed_addr constant [41 x i8] c"data_type 'double' value %f node_type %s\00", align 1
@.str.13 = private unnamed_addr constant [30 x i8] c"data_type 'array'node_type %s\00", align 1
@.str.14 = private unnamed_addr constant [37 x i8] c"data_type 'empty_array' node_type %s\00", align 1
@.str.15 = private unnamed_addr constant [41 x i8] c"data_type 'scalar' value %d node_type %s\00", align 1
@.str.16 = private unnamed_addr constant [34 x i8] c"data_type 'function' node_type %s\00", align 1
@.str.17 = private unnamed_addr constant [27 x i8] c"data_type '?' node_type %s\00", align 1
@.str.18 = private unnamed_addr constant [26 x i8] c" [variable in the STACK]\0A\00", align 1
@.str.19 = private unnamed_addr constant [12 x i8] c"ref_cnt %d\0A\00", align 1
@gRenderLoopState = common global %struct.tnode zeroinitializer, align 8
@.str.20 = private unnamed_addr constant [27 x i8] c"get_s2d_user_global_state\0A\00", align 1
@.str.21 = private unnamed_addr constant [43 x i8] c"-I- Setting conf parameter %d to value %d\0A\00", align 1
@.str.22 = private unnamed_addr constant [31 x i8] c"funk_eq_ri: invalid types %d\0A \00", align 1
@.str.23 = private unnamed_addr constant [31 x i8] c"funk_eq_rr: invalid types %d\0A \00", align 1
@.str.24 = private unnamed_addr constant [35 x i8] c"funk_or_rr: invalid types %d, %d\0A \00", align 1
@.str.25 = private unnamed_addr constant [36 x i8] c"funk_and_rr: invalid types %d, %d\0A \00", align 1
@.str.26 = private unnamed_addr constant [40 x i8] c"-E- funk_mul_rr: invalid types %d, %d\0A \00", align 1
@.str.27 = private unnamed_addr constant [40 x i8] c"-E- funk_div_rr: invalid types %d, %d\0A \00", align 1
@.str.28 = private unnamed_addr constant [40 x i8] c"-E- funk_add_rr: invalid types %d, %d\0A \00", align 1
@.str.29 = private unnamed_addr constant [40 x i8] c"-E- funk_sub_rr: invalid types %d, %d\0A \00", align 1
@.str.30 = private unnamed_addr constant [36 x i8] c"-E- funk_mul_ri: invalid types %d\0A \00", align 1
@.str.31 = private unnamed_addr constant [36 x i8] c"-E- funk_div_ri: invalid types %d\0A \00", align 1
@.str.32 = private unnamed_addr constant [36 x i8] c"-E- funk_mul_rf: invalid types %d\0A \00", align 1
@.str.33 = private unnamed_addr constant [36 x i8] c"-E- funk_add_ri: invalid types %d\0A \00", align 1
@.str.34 = private unnamed_addr constant [36 x i8] c"-E- funk_sub_rf: invalid types %d\0A \00", align 1
@.str.35 = private unnamed_addr constant [36 x i8] c"-E- funk_sub_ri: invalid types %d\0A \00", align 1
@.str.36 = private unnamed_addr constant [36 x i8] c"-E- funk_mod_rr: invalid types %d\0A \00", align 1
@.str.37 = private unnamed_addr constant [5 x i8] c" %d \00", align 1
@.str.38 = private unnamed_addr constant [5 x i8] c" %f \00", align 1
@.str.39 = private unnamed_addr constant [26 x i8] c"-E- Cannot print type %d\0A\00", align 1
@.str.40 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@.str.41 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.42 = private unnamed_addr constant [6 x i8] c" ... \00", align 1
@.str.43 = private unnamed_addr constant [3 x i8] c" ]\00", align 1
@.str.44 = private unnamed_addr constant [2 x i8] c".\00", align 1
@gCollector = common global %struct.GC zeroinitializer, align 8
@.str.45 = private unnamed_addr constant [31 x i8] c"===== garbage collector =====\0A\00", align 1
@.str.46 = private unnamed_addr constant [30 x i8] c"%d: addr: %p ref_cnt: %d val:\00", align 1
@.str.47 = private unnamed_addr constant [13 x i8] c"<double> %f\0A\00", align 1
@.str.48 = private unnamed_addr constant [10 x i8] c"<int> %d\0A\00", align 1
@.str.49 = private unnamed_addr constant [21 x i8] c"<invalid_data_type>\0A\00", align 1
@.str.50 = private unnamed_addr constant [16 x i8] c"<unknown type>\0A\00", align 1
@.str.51 = private unnamed_addr constant [6 x i8] c"null\0A\00", align 1
@.str.52 = private unnamed_addr constant [13 x i8] c"-I- Exiting\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i8* @printNodeType(i32) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  %4 = load i32, i32* %3, align 4
  switch i32 %4, label %12 [
    i32 0, label %5
    i32 1, label %6
    i32 2, label %7
    i32 3, label %8
    i32 4, label %9
    i32 5, label %10
    i32 6, label %11
  ]

; <label>:5:                                      ; preds = %1
  store i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i32 0, i32 0), i8** %2, align 8
  br label %13

; <label>:6:                                      ; preds = %1
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i8** %2, align 8
  br label %13

; <label>:7:                                      ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i32 0, i32 0), i8** %2, align 8
  br label %13

; <label>:8:                                      ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i32 0, i32 0), i8** %2, align 8
  br label %13

; <label>:9:                                      ; preds = %1
  store i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0), i8** %2, align 8
  br label %13

; <label>:10:                                     ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.5, i32 0, i32 0), i8** %2, align 8
  br label %13

; <label>:11:                                     ; preds = %1
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.6, i32 0, i32 0), i8** %2, align 8
  br label %13

; <label>:12:                                     ; preds = %1
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.7, i32 0, i32 0), i8** %2, align 8
  br label %13

; <label>:13:                                     ; preds = %12, %11, %10, %9, %8, %7, %6, %5
  %14 = load i8*, i8** %2, align 8
  ret i8* %14
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_debug_printNode(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = icmp eq %struct.tnode* null, %3
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %1
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.8, i32 0, i32 0))
  br label %98

; <label>:7:                                      ; preds = %1
  %8 = load %struct.tnode*, %struct.tnode** %2, align 8
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.9, i32 0, i32 0), %struct.tnode* %8)
  %10 = load %struct.tnode*, %struct.tnode** %2, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 0
  %13 = load i8, i8* %12, align 8
  %14 = zext i8 %13 to i32
  switch i32 %14, label %79 [
    i32 0, label %15
    i32 1, label %22
    i32 2, label %34
    i32 3, label %46
    i32 4, label %53
    i32 5, label %60
    i32 6, label %72
  ]

; <label>:15:                                     ; preds = %7
  %16 = load %struct.tnode*, %struct.tnode** %2, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 0
  %18 = load i8, i8* %17, align 8
  %19 = zext i8 %18 to i32
  %20 = call i8* @printNodeType(i32 %19)
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.10, i32 0, i32 0), i8* %20)
  br label %86

; <label>:22:                                     ; preds = %7
  %23 = load %struct.tnode*, %struct.tnode** %2, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 1
  %26 = bitcast %union.data_type* %25 to i32*
  %27 = load i32, i32* %26, align 8
  %28 = load %struct.tnode*, %struct.tnode** %2, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 0
  %30 = load i8, i8* %29, align 8
  %31 = zext i8 %30 to i32
  %32 = call i8* @printNodeType(i32 %31)
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.11, i32 0, i32 0), i32 %27, i8* %32)
  br label %86

; <label>:34:                                     ; preds = %7
  %35 = load %struct.tnode*, %struct.tnode** %2, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 1
  %37 = getelementptr inbounds %struct.tdata, %struct.tdata* %36, i32 0, i32 1
  %38 = bitcast %union.data_type* %37 to double*
  %39 = load double, double* %38, align 8
  %40 = load %struct.tnode*, %struct.tnode** %2, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 0
  %42 = load i8, i8* %41, align 8
  %43 = zext i8 %42 to i32
  %44 = call i8* @printNodeType(i32 %43)
  %45 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.12, i32 0, i32 0), double %39, i8* %44)
  br label %86

; <label>:46:                                     ; preds = %7
  %47 = load %struct.tnode*, %struct.tnode** %2, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 0
  %49 = load i8, i8* %48, align 8
  %50 = zext i8 %49 to i32
  %51 = call i8* @printNodeType(i32 %50)
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.13, i32 0, i32 0), i8* %51)
  br label %86

; <label>:53:                                     ; preds = %7
  %54 = load %struct.tnode*, %struct.tnode** %2, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 0
  %56 = load i8, i8* %55, align 8
  %57 = zext i8 %56 to i32
  %58 = call i8* @printNodeType(i32 %57)
  %59 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.14, i32 0, i32 0), i8* %58)
  br label %86

; <label>:60:                                     ; preds = %7
  %61 = load %struct.tnode*, %struct.tnode** %2, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 1
  %63 = getelementptr inbounds %struct.tdata, %struct.tdata* %62, i32 0, i32 1
  %64 = bitcast %union.data_type* %63 to i32*
  %65 = load i32, i32* %64, align 8
  %66 = load %struct.tnode*, %struct.tnode** %2, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 0
  %68 = load i8, i8* %67, align 8
  %69 = zext i8 %68 to i32
  %70 = call i8* @printNodeType(i32 %69)
  %71 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.15, i32 0, i32 0), i32 %65, i8* %70)
  br label %86

; <label>:72:                                     ; preds = %7
  %73 = load %struct.tnode*, %struct.tnode** %2, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 0
  %75 = load i8, i8* %74, align 8
  %76 = zext i8 %75 to i32
  %77 = call i8* @printNodeType(i32 %76)
  %78 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.16, i32 0, i32 0), i8* %77)
  br label %86

; <label>:79:                                     ; preds = %7
  %80 = load %struct.tnode*, %struct.tnode** %2, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 0
  %82 = load i8, i8* %81, align 8
  %83 = zext i8 %82 to i32
  %84 = call i8* @printNodeType(i32 %83)
  %85 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.17, i32 0, i32 0), i8* %84)
  br label %86

; <label>:86:                                     ; preds = %79, %72, %60, %53, %46, %34, %22, %15
  %87 = load %struct.tnode*, %struct.tnode** %2, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 3
  %89 = load i32, i32* %88, align 8
  %90 = icmp eq i32 %89, -1
  br i1 %90, label %91, label %93

; <label>:91:                                     ; preds = %86
  %92 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.18, i32 0, i32 0))
  br label %98

; <label>:93:                                     ; preds = %86
  %94 = load %struct.tnode*, %struct.tnode** %2, align 8
  %95 = getelementptr inbounds %struct.tnode, %struct.tnode* %94, i32 0, i32 3
  %96 = load i32, i32* %95, align 8
  %97 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.19, i32 0, i32 0), i32 %96)
  br label %98

; <label>:98:                                     ; preds = %5, %93, %91
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_deep_shallow_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %5 = load %struct.tnode*, %struct.tnode** %4, align 8
  %6 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 0
  %7 = load i8, i8* %6, align 8
  %8 = load %struct.tnode*, %struct.tnode** %3, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 0
  store i8 %7, i8* %9, align 8
  %10 = load %struct.tnode*, %struct.tnode** %4, align 8
  %11 = getelementptr inbounds %struct.tnode, %struct.tnode* %10, i32 0, i32 1
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 0
  %13 = load i8, i8* %12, align 8
  %14 = load %struct.tnode*, %struct.tnode** %3, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  store i8 %13, i8* %16, align 8
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 1
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 1
  %20 = load %struct.tnode*, %struct.tnode** %4, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 1
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 1
  %23 = bitcast %union.data_type* %19 to i8*
  %24 = bitcast %union.data_type* %22 to i8*
  call void @memcpy(i8* align 8 %23, i8* align 8 %24, i64 8, i1 false)
  %25 = load %struct.tnode*, %struct.tnode** %3, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 2
  store %struct.tnode* null, %struct.tnode** %26, align 8
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @memcpy(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_deep_copy_node(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %7 = load %struct.tnode*, %struct.tnode** %3, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  call void @funk_deep_shallow_node(%struct.tnode* %7, %struct.tnode* %8)
  %9 = load %struct.tnode*, %struct.tnode** %4, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 2
  %11 = load %struct.tnode*, %struct.tnode** %10, align 8
  store %struct.tnode* %11, %struct.tnode** %5, align 8
  %12 = load %struct.tnode*, %struct.tnode** %3, align 8
  store %struct.tnode* %12, %struct.tnode** %6, align 8
  br label %13

; <label>:13:                                     ; preds = %26, %2
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = icmp ne %struct.tnode* %14, null
  br i1 %15, label %16, label %35

; <label>:16:                                     ; preds = %13
  %17 = load %struct.tnode*, %struct.tnode** %6, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 2
  %19 = load %struct.tnode*, %struct.tnode** %18, align 8
  %20 = icmp eq %struct.tnode* %19, null
  br i1 %20, label %21, label %26

; <label>:21:                                     ; preds = %16
  %22 = call i8* @malloc(i64 40) #5
  %23 = bitcast i8* %22 to %struct.tnode*
  %24 = load %struct.tnode*, %struct.tnode** %6, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 2
  store %struct.tnode* %23, %struct.tnode** %25, align 8
  br label %26

; <label>:26:                                     ; preds = %21, %16
  %27 = load %struct.tnode*, %struct.tnode** %6, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 2
  %29 = load %struct.tnode*, %struct.tnode** %28, align 8
  store %struct.tnode* %29, %struct.tnode** %6, align 8
  %30 = load %struct.tnode*, %struct.tnode** %6, align 8
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  call void @funk_deep_shallow_node(%struct.tnode* %30, %struct.tnode* %31)
  %32 = load %struct.tnode*, %struct.tnode** %5, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 2
  %34 = load %struct.tnode*, %struct.tnode** %33, align 8
  store %struct.tnode* %34, %struct.tnode** %5, align 8
  br label %13

; <label>:35:                                     ; preds = %13
  ret void
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @set_s2d_user_global_state(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_deep_copy_node(%struct.tnode* @gRenderLoopState, %struct.tnode* %3)
  %4 = load i32, i32* @g_funk_verbosity, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %8

; <label>:6:                                      ; preds = %1
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.20, i32 0, i32 0))
  call void @funk_debug_printNode(%struct.tnode* @gRenderLoopState)
  br label %8

; <label>:8:                                      ; preds = %6, %1
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @get_s2d_user_global_state(%struct.tnode* noalias sret) #0 {
  %2 = load i32, i32* @g_funk_verbosity, align 4
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %1
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.20, i32 0, i32 0))
  call void @funk_debug_printNode(%struct.tnode* @gRenderLoopState)
  br label %6

; <label>:6:                                      ; preds = %4, %1
  %7 = bitcast %struct.tnode* %0 to i8*
  call void @memcpy(i8* align 8 %7, i8* align 8 getelementptr inbounds (%struct.tnode, %struct.tnode* @gRenderLoopState, i32 0, i32 0), i64 40, i1 false)
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
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.21, i32 0, i32 0), i32 %5, i32 %6)
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

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_slt_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 1
  br i1 %12, label %13, label %30

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to i32*
  %18 = load i32, i32* %17, align 8
  %19 = load i32, i32* %6, align 4
  %20 = icmp slt i32 %18, %19
  %21 = zext i1 %20 to i64
  %22 = select i1 %20, i32 1, i32 0
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 1
  %26 = bitcast %union.data_type* %25 to i32*
  store i32 %22, i32* %26, align 8
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 0
  store i8 1, i8* %29, align 8
  br label %60

; <label>:30:                                     ; preds = %3
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 1
  %33 = getelementptr inbounds %struct.tdata, %struct.tdata* %32, i32 0, i32 0
  %34 = load i8, i8* %33, align 8
  %35 = zext i8 %34 to i32
  %36 = icmp eq i32 %35, 2
  br i1 %36, label %37, label %55

; <label>:37:                                     ; preds = %30
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 1
  %41 = bitcast %union.data_type* %40 to double*
  %42 = load double, double* %41, align 8
  %43 = fptosi double %42 to i32
  %44 = load i32, i32* %6, align 4
  %45 = icmp slt i32 %43, %44
  %46 = zext i1 %45 to i64
  %47 = select i1 %45, i32 1, i32 0
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 1
  %51 = bitcast %union.data_type* %50 to i32*
  store i32 %47, i32* %51, align 8
  %52 = load %struct.tnode*, %struct.tnode** %4, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  store i8 1, i8* %54, align 8
  br label %59

; <label>:55:                                     ; preds = %30
  %56 = load %struct.tnode*, %struct.tnode** %4, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 0
  store i8 0, i8* %58, align 8
  br label %59

; <label>:59:                                     ; preds = %55, %37
  br label %60

; <label>:60:                                     ; preds = %59, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sgt_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 1
  br i1 %12, label %13, label %30

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to i32*
  %18 = load i32, i32* %17, align 8
  %19 = load i32, i32* %6, align 4
  %20 = icmp sgt i32 %18, %19
  %21 = zext i1 %20 to i64
  %22 = select i1 %20, i32 1, i32 0
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 1
  %26 = bitcast %union.data_type* %25 to i32*
  store i32 %22, i32* %26, align 8
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 0
  store i8 1, i8* %29, align 8
  br label %60

; <label>:30:                                     ; preds = %3
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 1
  %33 = getelementptr inbounds %struct.tdata, %struct.tdata* %32, i32 0, i32 0
  %34 = load i8, i8* %33, align 8
  %35 = zext i8 %34 to i32
  %36 = icmp eq i32 %35, 2
  br i1 %36, label %37, label %55

; <label>:37:                                     ; preds = %30
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 1
  %41 = bitcast %union.data_type* %40 to double*
  %42 = load double, double* %41, align 8
  %43 = fptosi double %42 to i32
  %44 = load i32, i32* %6, align 4
  %45 = icmp sgt i32 %43, %44
  %46 = zext i1 %45 to i64
  %47 = select i1 %45, i32 1, i32 0
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 1
  %51 = bitcast %union.data_type* %50 to i32*
  store i32 %47, i32* %51, align 8
  %52 = load %struct.tnode*, %struct.tnode** %4, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  store i8 1, i8* %54, align 8
  br label %59

; <label>:55:                                     ; preds = %30
  %56 = load %struct.tnode*, %struct.tnode** %4, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 0
  store i8 0, i8* %58, align 8
  br label %59

; <label>:59:                                     ; preds = %55, %37
  br label %60

; <label>:60:                                     ; preds = %59, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_flt_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %30

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = load double, double* %6, align 8
  %20 = fcmp olt double %18, %19
  %21 = zext i1 %20 to i64
  %22 = select i1 %20, i32 1, i32 0
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 1
  %26 = bitcast %union.data_type* %25 to i32*
  store i32 %22, i32* %26, align 8
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 0
  store i8 1, i8* %29, align 8
  br label %61

; <label>:30:                                     ; preds = %3
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 1
  %33 = getelementptr inbounds %struct.tdata, %struct.tdata* %32, i32 0, i32 0
  %34 = load i8, i8* %33, align 8
  %35 = zext i8 %34 to i32
  %36 = icmp eq i32 %35, 1
  br i1 %36, label %37, label %56

; <label>:37:                                     ; preds = %30
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 1
  %41 = bitcast %union.data_type* %40 to i32*
  %42 = load i32, i32* %41, align 8
  %43 = sitofp i32 %42 to double
  %44 = load double, double* %6, align 8
  %45 = fcmp olt double %43, %44
  %46 = zext i1 %45 to i64
  %47 = select i1 %45, i32 1, i32 0
  %48 = sitofp i32 %47 to double
  %49 = load %struct.tnode*, %struct.tnode** %4, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 1
  %52 = bitcast %union.data_type* %51 to double*
  store double %48, double* %52, align 8
  %53 = load %struct.tnode*, %struct.tnode** %4, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 1
  %55 = getelementptr inbounds %struct.tdata, %struct.tdata* %54, i32 0, i32 0
  store i8 1, i8* %55, align 8
  br label %60

; <label>:56:                                     ; preds = %30
  %57 = load %struct.tnode*, %struct.tnode** %4, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 1
  %59 = getelementptr inbounds %struct.tdata, %struct.tdata* %58, i32 0, i32 0
  store i8 0, i8* %59, align 8
  br label %60

; <label>:60:                                     ; preds = %56, %37
  br label %61

; <label>:61:                                     ; preds = %60, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mod_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %30

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = fptosi double %18 to i32
  %20 = load i32, i32* %6, align 4
  %21 = srem i32 %19, %20
  %22 = sitofp i32 %21 to double
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 1
  %26 = bitcast %union.data_type* %25 to double*
  store double %22, double* %26, align 8
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 0
  store i8 1, i8* %29, align 8
  br label %57

; <label>:30:                                     ; preds = %3
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 1
  %33 = getelementptr inbounds %struct.tdata, %struct.tdata* %32, i32 0, i32 0
  %34 = load i8, i8* %33, align 8
  %35 = zext i8 %34 to i32
  %36 = icmp eq i32 %35, 1
  br i1 %36, label %37, label %52

; <label>:37:                                     ; preds = %30
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 1
  %41 = bitcast %union.data_type* %40 to i32*
  %42 = load i32, i32* %41, align 8
  %43 = load i32, i32* %6, align 4
  %44 = srem i32 %42, %43
  %45 = load %struct.tnode*, %struct.tnode** %4, align 8
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %45, i32 0, i32 1
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 1
  %48 = bitcast %union.data_type* %47 to i32*
  store i32 %44, i32* %48, align 8
  %49 = load %struct.tnode*, %struct.tnode** %4, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 0
  store i8 1, i8* %51, align 8
  br label %56

; <label>:52:                                     ; preds = %30
  %53 = load %struct.tnode*, %struct.tnode** %4, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 1
  %55 = getelementptr inbounds %struct.tdata, %struct.tdata* %54, i32 0, i32 0
  store i8 0, i8* %55, align 8
  br label %56

; <label>:56:                                     ; preds = %52, %37
  br label %57

; <label>:57:                                     ; preds = %56, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_eq_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %31

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = fptosi double %18 to i32
  %20 = load i32, i32* %6, align 4
  %21 = icmp eq i32 %19, %20
  %22 = zext i1 %21 to i64
  %23 = select i1 %21, i32 1, i32 0
  %24 = load %struct.tnode*, %struct.tnode** %4, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 1
  %26 = getelementptr inbounds %struct.tdata, %struct.tdata* %25, i32 0, i32 1
  %27 = bitcast %union.data_type* %26 to i32*
  store i32 %23, i32* %27, align 8
  %28 = load %struct.tnode*, %struct.tnode** %4, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 1
  %30 = getelementptr inbounds %struct.tdata, %struct.tdata* %29, i32 0, i32 0
  store i8 1, i8* %30, align 8
  br label %66

; <label>:31:                                     ; preds = %3
  %32 = load %struct.tnode*, %struct.tnode** %5, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 0
  %35 = load i8, i8* %34, align 8
  %36 = zext i8 %35 to i32
  %37 = icmp eq i32 %36, 1
  br i1 %37, label %38, label %55

; <label>:38:                                     ; preds = %31
  %39 = load %struct.tnode*, %struct.tnode** %5, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 1
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 1
  %42 = bitcast %union.data_type* %41 to i32*
  %43 = load i32, i32* %42, align 8
  %44 = load i32, i32* %6, align 4
  %45 = icmp eq i32 %43, %44
  %46 = zext i1 %45 to i64
  %47 = select i1 %45, i32 1, i32 0
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 1
  %51 = bitcast %union.data_type* %50 to i32*
  store i32 %47, i32* %51, align 8
  %52 = load %struct.tnode*, %struct.tnode** %4, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  store i8 1, i8* %54, align 8
  br label %65

; <label>:55:                                     ; preds = %31
  %56 = load %struct.tnode*, %struct.tnode** %5, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 0
  %59 = load i8, i8* %58, align 8
  %60 = zext i8 %59 to i32
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.22, i32 0, i32 0), i32 %60)
  %62 = load %struct.tnode*, %struct.tnode** %4, align 8
  %63 = getelementptr inbounds %struct.tnode, %struct.tnode* %62, i32 0, i32 1
  %64 = getelementptr inbounds %struct.tdata, %struct.tdata* %63, i32 0, i32 0
  store i8 0, i8* %64, align 8
  br label %65

; <label>:65:                                     ; preds = %55, %38
  br label %66

; <label>:66:                                     ; preds = %65, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_eq_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %41

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 2
  br i1 %19, label %20, label %41

; <label>:20:                                     ; preds = %13
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to double*
  %25 = load double, double* %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 1
  %29 = bitcast %union.data_type* %28 to double*
  %30 = load double, double* %29, align 8
  %31 = fcmp oeq double %25, %30
  %32 = zext i1 %31 to i64
  %33 = select i1 %31, i32 1, i32 0
  %34 = load %struct.tnode*, %struct.tnode** %4, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 1
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %35, i32 0, i32 1
  %37 = bitcast %union.data_type* %36 to i32*
  store i32 %33, i32* %37, align 8
  %38 = load %struct.tnode*, %struct.tnode** %4, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 0
  store i8 1, i8* %40, align 8
  br label %87

; <label>:41:                                     ; preds = %13, %3
  %42 = load %struct.tnode*, %struct.tnode** %5, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 1
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 0
  %45 = load i8, i8* %44, align 8
  %46 = zext i8 %45 to i32
  %47 = icmp eq i32 %46, 1
  br i1 %47, label %48, label %76

; <label>:48:                                     ; preds = %41
  %49 = load %struct.tnode*, %struct.tnode** %6, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 0
  %52 = load i8, i8* %51, align 8
  %53 = zext i8 %52 to i32
  %54 = icmp eq i32 %53, 1
  br i1 %54, label %55, label %76

; <label>:55:                                     ; preds = %48
  %56 = load %struct.tnode*, %struct.tnode** %5, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 1
  %59 = bitcast %union.data_type* %58 to i32*
  %60 = load i32, i32* %59, align 8
  %61 = load %struct.tnode*, %struct.tnode** %6, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 1
  %63 = getelementptr inbounds %struct.tdata, %struct.tdata* %62, i32 0, i32 1
  %64 = bitcast %union.data_type* %63 to i32*
  %65 = load i32, i32* %64, align 8
  %66 = icmp eq i32 %60, %65
  %67 = zext i1 %66 to i64
  %68 = select i1 %66, i32 1, i32 0
  %69 = load %struct.tnode*, %struct.tnode** %4, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 1
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %70, i32 0, i32 1
  %72 = bitcast %union.data_type* %71 to i32*
  store i32 %68, i32* %72, align 8
  %73 = load %struct.tnode*, %struct.tnode** %4, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 1
  %75 = getelementptr inbounds %struct.tdata, %struct.tdata* %74, i32 0, i32 0
  store i8 1, i8* %75, align 8
  br label %86

; <label>:76:                                     ; preds = %48, %41
  %77 = load %struct.tnode*, %struct.tnode** %5, align 8
  %78 = getelementptr inbounds %struct.tnode, %struct.tnode* %77, i32 0, i32 1
  %79 = getelementptr inbounds %struct.tdata, %struct.tdata* %78, i32 0, i32 0
  %80 = load i8, i8* %79, align 8
  %81 = zext i8 %80 to i32
  %82 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.23, i32 0, i32 0), i32 %81)
  %83 = load %struct.tnode*, %struct.tnode** %4, align 8
  %84 = getelementptr inbounds %struct.tnode, %struct.tnode* %83, i32 0, i32 1
  %85 = getelementptr inbounds %struct.tdata, %struct.tdata* %84, i32 0, i32 0
  store i8 0, i8* %85, align 8
  br label %86

; <label>:86:                                     ; preds = %76, %55
  br label %87

; <label>:87:                                     ; preds = %86, %20
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_or_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 1
  br i1 %12, label %13, label %45

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 1
  br i1 %19, label %20, label %45

; <label>:20:                                     ; preds = %13
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to i32*
  %25 = load i32, i32* %24, align 8
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %34, label %27

; <label>:27:                                     ; preds = %20
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 1
  %30 = getelementptr inbounds %struct.tdata, %struct.tdata* %29, i32 0, i32 1
  %31 = bitcast %union.data_type* %30 to i32*
  %32 = load i32, i32* %31, align 8
  %33 = icmp ne i32 %32, 0
  br label %34

; <label>:34:                                     ; preds = %27, %20
  %35 = phi i1 [ true, %20 ], [ %33, %27 ]
  %36 = zext i1 %35 to i64
  %37 = select i1 %35, i32 1, i32 0
  %38 = load %struct.tnode*, %struct.tnode** %4, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 1
  %41 = bitcast %union.data_type* %40 to i32*
  store i32 %37, i32* %41, align 8
  %42 = load %struct.tnode*, %struct.tnode** %4, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 1
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 0
  store i8 1, i8* %44, align 8
  br label %118

; <label>:45:                                     ; preds = %13, %3
  %46 = load %struct.tnode*, %struct.tnode** %5, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 1
  %48 = getelementptr inbounds %struct.tdata, %struct.tdata* %47, i32 0, i32 0
  %49 = load i8, i8* %48, align 8
  %50 = zext i8 %49 to i32
  %51 = icmp eq i32 %50, 2
  br i1 %51, label %52, label %85

; <label>:52:                                     ; preds = %45
  %53 = load %struct.tnode*, %struct.tnode** %6, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 1
  %55 = getelementptr inbounds %struct.tdata, %struct.tdata* %54, i32 0, i32 0
  %56 = load i8, i8* %55, align 8
  %57 = zext i8 %56 to i32
  %58 = icmp eq i32 %57, 2
  br i1 %58, label %59, label %85

; <label>:59:                                     ; preds = %52
  %60 = load %struct.tnode*, %struct.tnode** %5, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 1
  %62 = getelementptr inbounds %struct.tdata, %struct.tdata* %61, i32 0, i32 1
  %63 = bitcast %union.data_type* %62 to double*
  %64 = load double, double* %63, align 8
  %65 = fcmp une double %64, 0.000000e+00
  br i1 %65, label %73, label %66

; <label>:66:                                     ; preds = %59
  %67 = load %struct.tnode*, %struct.tnode** %6, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 1
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 1
  %70 = bitcast %union.data_type* %69 to double*
  %71 = load double, double* %70, align 8
  %72 = fcmp une double %71, 0.000000e+00
  br label %73

; <label>:73:                                     ; preds = %66, %59
  %74 = phi i1 [ true, %59 ], [ %72, %66 ]
  %75 = zext i1 %74 to i64
  %76 = select i1 %74, float 1.000000e+00, float 0.000000e+00
  %77 = fpext float %76 to double
  %78 = load %struct.tnode*, %struct.tnode** %4, align 8
  %79 = getelementptr inbounds %struct.tnode, %struct.tnode* %78, i32 0, i32 1
  %80 = getelementptr inbounds %struct.tdata, %struct.tdata* %79, i32 0, i32 1
  %81 = bitcast %union.data_type* %80 to double*
  store double %77, double* %81, align 8
  %82 = load %struct.tnode*, %struct.tnode** %4, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 1
  %84 = getelementptr inbounds %struct.tdata, %struct.tdata* %83, i32 0, i32 0
  store i8 2, i8* %84, align 8
  br label %117

; <label>:85:                                     ; preds = %52, %45
  %86 = load %struct.tnode*, %struct.tnode** %5, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 1
  %88 = getelementptr inbounds %struct.tdata, %struct.tdata* %87, i32 0, i32 0
  %89 = load i8, i8* %88, align 8
  %90 = zext i8 %89 to i32
  %91 = load %struct.tnode*, %struct.tnode** %6, align 8
  %92 = getelementptr inbounds %struct.tnode, %struct.tnode* %91, i32 0, i32 1
  %93 = getelementptr inbounds %struct.tdata, %struct.tdata* %92, i32 0, i32 0
  %94 = load i8, i8* %93, align 8
  %95 = zext i8 %94 to i32
  %96 = icmp ne i32 %90, %95
  br i1 %96, label %97, label %112

; <label>:97:                                     ; preds = %85
  %98 = load %struct.tnode*, %struct.tnode** %5, align 8
  %99 = getelementptr inbounds %struct.tnode, %struct.tnode* %98, i32 0, i32 1
  %100 = getelementptr inbounds %struct.tdata, %struct.tdata* %99, i32 0, i32 0
  %101 = load i8, i8* %100, align 8
  %102 = zext i8 %101 to i32
  %103 = load %struct.tnode*, %struct.tnode** %6, align 8
  %104 = getelementptr inbounds %struct.tnode, %struct.tnode* %103, i32 0, i32 1
  %105 = getelementptr inbounds %struct.tdata, %struct.tdata* %104, i32 0, i32 0
  %106 = load i8, i8* %105, align 8
  %107 = zext i8 %106 to i32
  %108 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.24, i32 0, i32 0), i32 %102, i32 %107)
  %109 = load %struct.tnode*, %struct.tnode** %4, align 8
  %110 = getelementptr inbounds %struct.tnode, %struct.tnode* %109, i32 0, i32 1
  %111 = getelementptr inbounds %struct.tdata, %struct.tdata* %110, i32 0, i32 0
  store i8 0, i8* %111, align 8
  br label %116

; <label>:112:                                    ; preds = %85
  %113 = load %struct.tnode*, %struct.tnode** %4, align 8
  %114 = getelementptr inbounds %struct.tnode, %struct.tnode* %113, i32 0, i32 1
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 0
  store i8 0, i8* %115, align 8
  br label %116

; <label>:116:                                    ; preds = %112, %97
  br label %117

; <label>:117:                                    ; preds = %116, %73
  br label %118

; <label>:118:                                    ; preds = %117, %34
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_and_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 1
  br i1 %12, label %13, label %45

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 1
  br i1 %19, label %20, label %45

; <label>:20:                                     ; preds = %13
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to i32*
  %25 = load i32, i32* %24, align 8
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %34

; <label>:27:                                     ; preds = %20
  %28 = load %struct.tnode*, %struct.tnode** %6, align 8
  %29 = getelementptr inbounds %struct.tnode, %struct.tnode* %28, i32 0, i32 1
  %30 = getelementptr inbounds %struct.tdata, %struct.tdata* %29, i32 0, i32 1
  %31 = bitcast %union.data_type* %30 to i32*
  %32 = load i32, i32* %31, align 8
  %33 = icmp ne i32 %32, 0
  br label %34

; <label>:34:                                     ; preds = %27, %20
  %35 = phi i1 [ false, %20 ], [ %33, %27 ]
  %36 = zext i1 %35 to i64
  %37 = select i1 %35, i32 1, i32 0
  %38 = load %struct.tnode*, %struct.tnode** %4, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 1
  %41 = bitcast %union.data_type* %40 to i32*
  store i32 %37, i32* %41, align 8
  %42 = load %struct.tnode*, %struct.tnode** %4, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 1
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 0
  store i8 1, i8* %44, align 8
  br label %118

; <label>:45:                                     ; preds = %13, %3
  %46 = load %struct.tnode*, %struct.tnode** %5, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 1
  %48 = getelementptr inbounds %struct.tdata, %struct.tdata* %47, i32 0, i32 0
  %49 = load i8, i8* %48, align 8
  %50 = zext i8 %49 to i32
  %51 = icmp eq i32 %50, 2
  br i1 %51, label %52, label %85

; <label>:52:                                     ; preds = %45
  %53 = load %struct.tnode*, %struct.tnode** %6, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 1
  %55 = getelementptr inbounds %struct.tdata, %struct.tdata* %54, i32 0, i32 0
  %56 = load i8, i8* %55, align 8
  %57 = zext i8 %56 to i32
  %58 = icmp eq i32 %57, 2
  br i1 %58, label %59, label %85

; <label>:59:                                     ; preds = %52
  %60 = load %struct.tnode*, %struct.tnode** %5, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 1
  %62 = getelementptr inbounds %struct.tdata, %struct.tdata* %61, i32 0, i32 1
  %63 = bitcast %union.data_type* %62 to double*
  %64 = load double, double* %63, align 8
  %65 = fcmp une double %64, 0.000000e+00
  br i1 %65, label %66, label %73

; <label>:66:                                     ; preds = %59
  %67 = load %struct.tnode*, %struct.tnode** %6, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 1
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 1
  %70 = bitcast %union.data_type* %69 to double*
  %71 = load double, double* %70, align 8
  %72 = fcmp une double %71, 0.000000e+00
  br label %73

; <label>:73:                                     ; preds = %66, %59
  %74 = phi i1 [ false, %59 ], [ %72, %66 ]
  %75 = zext i1 %74 to i64
  %76 = select i1 %74, float 1.000000e+00, float 0.000000e+00
  %77 = fpext float %76 to double
  %78 = load %struct.tnode*, %struct.tnode** %4, align 8
  %79 = getelementptr inbounds %struct.tnode, %struct.tnode* %78, i32 0, i32 1
  %80 = getelementptr inbounds %struct.tdata, %struct.tdata* %79, i32 0, i32 1
  %81 = bitcast %union.data_type* %80 to double*
  store double %77, double* %81, align 8
  %82 = load %struct.tnode*, %struct.tnode** %4, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 1
  %84 = getelementptr inbounds %struct.tdata, %struct.tdata* %83, i32 0, i32 0
  store i8 2, i8* %84, align 8
  br label %117

; <label>:85:                                     ; preds = %52, %45
  %86 = load %struct.tnode*, %struct.tnode** %5, align 8
  %87 = getelementptr inbounds %struct.tnode, %struct.tnode* %86, i32 0, i32 1
  %88 = getelementptr inbounds %struct.tdata, %struct.tdata* %87, i32 0, i32 0
  %89 = load i8, i8* %88, align 8
  %90 = zext i8 %89 to i32
  %91 = load %struct.tnode*, %struct.tnode** %6, align 8
  %92 = getelementptr inbounds %struct.tnode, %struct.tnode* %91, i32 0, i32 1
  %93 = getelementptr inbounds %struct.tdata, %struct.tdata* %92, i32 0, i32 0
  %94 = load i8, i8* %93, align 8
  %95 = zext i8 %94 to i32
  %96 = icmp ne i32 %90, %95
  br i1 %96, label %97, label %112

; <label>:97:                                     ; preds = %85
  %98 = load %struct.tnode*, %struct.tnode** %5, align 8
  %99 = getelementptr inbounds %struct.tnode, %struct.tnode* %98, i32 0, i32 1
  %100 = getelementptr inbounds %struct.tdata, %struct.tdata* %99, i32 0, i32 0
  %101 = load i8, i8* %100, align 8
  %102 = zext i8 %101 to i32
  %103 = load %struct.tnode*, %struct.tnode** %6, align 8
  %104 = getelementptr inbounds %struct.tnode, %struct.tnode* %103, i32 0, i32 1
  %105 = getelementptr inbounds %struct.tdata, %struct.tdata* %104, i32 0, i32 0
  %106 = load i8, i8* %105, align 8
  %107 = zext i8 %106 to i32
  %108 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.25, i32 0, i32 0), i32 %102, i32 %107)
  %109 = load %struct.tnode*, %struct.tnode** %4, align 8
  %110 = getelementptr inbounds %struct.tnode, %struct.tnode* %109, i32 0, i32 1
  %111 = getelementptr inbounds %struct.tdata, %struct.tdata* %110, i32 0, i32 0
  store i8 0, i8* %111, align 8
  br label %116

; <label>:112:                                    ; preds = %85
  %113 = load %struct.tnode*, %struct.tnode** %4, align 8
  %114 = getelementptr inbounds %struct.tnode, %struct.tnode* %113, i32 0, i32 1
  %115 = getelementptr inbounds %struct.tdata, %struct.tdata* %114, i32 0, i32 0
  store i8 0, i8* %115, align 8
  br label %116

; <label>:116:                                    ; preds = %112, %97
  br label %117

; <label>:117:                                    ; preds = %116, %73
  br label %118

; <label>:118:                                    ; preds = %117, %34
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %39

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 2
  br i1 %19, label %20, label %39

; <label>:20:                                     ; preds = %13
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to double*
  %25 = load double, double* %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 1
  %29 = bitcast %union.data_type* %28 to double*
  %30 = load double, double* %29, align 8
  %31 = fmul double %25, %30
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 1
  %35 = bitcast %union.data_type* %34 to double*
  store double %31, double* %35, align 8
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 0
  store i8 2, i8* %38, align 8
  br label %158

; <label>:39:                                     ; preds = %13, %3
  %40 = load %struct.tnode*, %struct.tnode** %5, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 1
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  %43 = load i8, i8* %42, align 8
  %44 = zext i8 %43 to i32
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %72

; <label>:46:                                     ; preds = %39
  %47 = load %struct.tnode*, %struct.tnode** %6, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 1
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 0
  %50 = load i8, i8* %49, align 8
  %51 = zext i8 %50 to i32
  %52 = icmp eq i32 %51, 1
  br i1 %52, label %53, label %72

; <label>:53:                                     ; preds = %46
  %54 = load %struct.tnode*, %struct.tnode** %5, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 1
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 1
  %57 = bitcast %union.data_type* %56 to i32*
  %58 = load i32, i32* %57, align 8
  %59 = load %struct.tnode*, %struct.tnode** %6, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 1
  %61 = getelementptr inbounds %struct.tdata, %struct.tdata* %60, i32 0, i32 1
  %62 = bitcast %union.data_type* %61 to i32*
  %63 = load i32, i32* %62, align 8
  %64 = mul nsw i32 %58, %63
  %65 = load %struct.tnode*, %struct.tnode** %4, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 1
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 1
  %68 = bitcast %union.data_type* %67 to i32*
  store i32 %64, i32* %68, align 8
  %69 = load %struct.tnode*, %struct.tnode** %4, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 1
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %70, i32 0, i32 0
  store i8 1, i8* %71, align 8
  br label %157

; <label>:72:                                     ; preds = %46, %39
  %73 = load %struct.tnode*, %struct.tnode** %5, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 1
  %75 = getelementptr inbounds %struct.tdata, %struct.tdata* %74, i32 0, i32 0
  %76 = load i8, i8* %75, align 8
  %77 = zext i8 %76 to i32
  %78 = icmp eq i32 %77, 2
  br i1 %78, label %79, label %106

; <label>:79:                                     ; preds = %72
  %80 = load %struct.tnode*, %struct.tnode** %6, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 1
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  %83 = load i8, i8* %82, align 8
  %84 = zext i8 %83 to i32
  %85 = icmp eq i32 %84, 1
  br i1 %85, label %86, label %106

; <label>:86:                                     ; preds = %79
  %87 = load %struct.tnode*, %struct.tnode** %5, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 1
  %89 = getelementptr inbounds %struct.tdata, %struct.tdata* %88, i32 0, i32 1
  %90 = bitcast %union.data_type* %89 to double*
  %91 = load double, double* %90, align 8
  %92 = load %struct.tnode*, %struct.tnode** %6, align 8
  %93 = getelementptr inbounds %struct.tnode, %struct.tnode* %92, i32 0, i32 1
  %94 = getelementptr inbounds %struct.tdata, %struct.tdata* %93, i32 0, i32 1
  %95 = bitcast %union.data_type* %94 to i32*
  %96 = load i32, i32* %95, align 8
  %97 = sitofp i32 %96 to double
  %98 = fmul double %91, %97
  %99 = load %struct.tnode*, %struct.tnode** %4, align 8
  %100 = getelementptr inbounds %struct.tnode, %struct.tnode* %99, i32 0, i32 1
  %101 = getelementptr inbounds %struct.tdata, %struct.tdata* %100, i32 0, i32 1
  %102 = bitcast %union.data_type* %101 to double*
  store double %98, double* %102, align 8
  %103 = load %struct.tnode*, %struct.tnode** %4, align 8
  %104 = getelementptr inbounds %struct.tnode, %struct.tnode* %103, i32 0, i32 1
  %105 = getelementptr inbounds %struct.tdata, %struct.tdata* %104, i32 0, i32 0
  store i8 2, i8* %105, align 8
  br label %156

; <label>:106:                                    ; preds = %79, %72
  %107 = load %struct.tnode*, %struct.tnode** %5, align 8
  %108 = getelementptr inbounds %struct.tnode, %struct.tnode* %107, i32 0, i32 1
  %109 = getelementptr inbounds %struct.tdata, %struct.tdata* %108, i32 0, i32 0
  %110 = load i8, i8* %109, align 8
  %111 = zext i8 %110 to i32
  %112 = icmp eq i32 %111, 1
  br i1 %112, label %113, label %140

; <label>:113:                                    ; preds = %106
  %114 = load %struct.tnode*, %struct.tnode** %6, align 8
  %115 = getelementptr inbounds %struct.tnode, %struct.tnode* %114, i32 0, i32 1
  %116 = getelementptr inbounds %struct.tdata, %struct.tdata* %115, i32 0, i32 0
  %117 = load i8, i8* %116, align 8
  %118 = zext i8 %117 to i32
  %119 = icmp eq i32 %118, 2
  br i1 %119, label %120, label %140

; <label>:120:                                    ; preds = %113
  %121 = load %struct.tnode*, %struct.tnode** %5, align 8
  %122 = getelementptr inbounds %struct.tnode, %struct.tnode* %121, i32 0, i32 1
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %122, i32 0, i32 1
  %124 = bitcast %union.data_type* %123 to i32*
  %125 = load i32, i32* %124, align 8
  %126 = sitofp i32 %125 to double
  %127 = load %struct.tnode*, %struct.tnode** %6, align 8
  %128 = getelementptr inbounds %struct.tnode, %struct.tnode* %127, i32 0, i32 1
  %129 = getelementptr inbounds %struct.tdata, %struct.tdata* %128, i32 0, i32 1
  %130 = bitcast %union.data_type* %129 to double*
  %131 = load double, double* %130, align 8
  %132 = fmul double %126, %131
  %133 = load %struct.tnode*, %struct.tnode** %4, align 8
  %134 = getelementptr inbounds %struct.tnode, %struct.tnode* %133, i32 0, i32 1
  %135 = getelementptr inbounds %struct.tdata, %struct.tdata* %134, i32 0, i32 1
  %136 = bitcast %union.data_type* %135 to double*
  store double %132, double* %136, align 8
  %137 = load %struct.tnode*, %struct.tnode** %4, align 8
  %138 = getelementptr inbounds %struct.tnode, %struct.tnode* %137, i32 0, i32 1
  %139 = getelementptr inbounds %struct.tdata, %struct.tdata* %138, i32 0, i32 0
  store i8 2, i8* %139, align 8
  br label %155

; <label>:140:                                    ; preds = %113, %106
  %141 = load %struct.tnode*, %struct.tnode** %5, align 8
  %142 = getelementptr inbounds %struct.tnode, %struct.tnode* %141, i32 0, i32 1
  %143 = getelementptr inbounds %struct.tdata, %struct.tdata* %142, i32 0, i32 0
  %144 = load i8, i8* %143, align 8
  %145 = zext i8 %144 to i32
  %146 = load %struct.tnode*, %struct.tnode** %6, align 8
  %147 = getelementptr inbounds %struct.tnode, %struct.tnode* %146, i32 0, i32 1
  %148 = getelementptr inbounds %struct.tdata, %struct.tdata* %147, i32 0, i32 0
  %149 = load i8, i8* %148, align 8
  %150 = zext i8 %149 to i32
  %151 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.26, i32 0, i32 0), i32 %145, i32 %150)
  %152 = load %struct.tnode*, %struct.tnode** %4, align 8
  %153 = getelementptr inbounds %struct.tnode, %struct.tnode* %152, i32 0, i32 1
  %154 = getelementptr inbounds %struct.tdata, %struct.tdata* %153, i32 0, i32 0
  store i8 0, i8* %154, align 8
  br label %155

; <label>:155:                                    ; preds = %140, %120
  br label %156

; <label>:156:                                    ; preds = %155, %86
  br label %157

; <label>:157:                                    ; preds = %156, %53
  br label %158

; <label>:158:                                    ; preds = %157, %20
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %39

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 2
  br i1 %19, label %20, label %39

; <label>:20:                                     ; preds = %13
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to double*
  %25 = load double, double* %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 1
  %29 = bitcast %union.data_type* %28 to double*
  %30 = load double, double* %29, align 8
  %31 = fdiv double %25, %30
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 1
  %35 = bitcast %union.data_type* %34 to double*
  store double %31, double* %35, align 8
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 0
  store i8 2, i8* %38, align 8
  br label %158

; <label>:39:                                     ; preds = %13, %3
  %40 = load %struct.tnode*, %struct.tnode** %5, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 1
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  %43 = load i8, i8* %42, align 8
  %44 = zext i8 %43 to i32
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %72

; <label>:46:                                     ; preds = %39
  %47 = load %struct.tnode*, %struct.tnode** %6, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 1
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 0
  %50 = load i8, i8* %49, align 8
  %51 = zext i8 %50 to i32
  %52 = icmp eq i32 %51, 1
  br i1 %52, label %53, label %72

; <label>:53:                                     ; preds = %46
  %54 = load %struct.tnode*, %struct.tnode** %5, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 1
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 1
  %57 = bitcast %union.data_type* %56 to i32*
  %58 = load i32, i32* %57, align 8
  %59 = load %struct.tnode*, %struct.tnode** %6, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 1
  %61 = getelementptr inbounds %struct.tdata, %struct.tdata* %60, i32 0, i32 1
  %62 = bitcast %union.data_type* %61 to i32*
  %63 = load i32, i32* %62, align 8
  %64 = sdiv i32 %58, %63
  %65 = load %struct.tnode*, %struct.tnode** %4, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 1
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 1
  %68 = bitcast %union.data_type* %67 to i32*
  store i32 %64, i32* %68, align 8
  %69 = load %struct.tnode*, %struct.tnode** %4, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 1
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %70, i32 0, i32 0
  store i8 1, i8* %71, align 8
  br label %157

; <label>:72:                                     ; preds = %46, %39
  %73 = load %struct.tnode*, %struct.tnode** %5, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 1
  %75 = getelementptr inbounds %struct.tdata, %struct.tdata* %74, i32 0, i32 0
  %76 = load i8, i8* %75, align 8
  %77 = zext i8 %76 to i32
  %78 = icmp eq i32 %77, 2
  br i1 %78, label %79, label %106

; <label>:79:                                     ; preds = %72
  %80 = load %struct.tnode*, %struct.tnode** %6, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 1
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  %83 = load i8, i8* %82, align 8
  %84 = zext i8 %83 to i32
  %85 = icmp eq i32 %84, 1
  br i1 %85, label %86, label %106

; <label>:86:                                     ; preds = %79
  %87 = load %struct.tnode*, %struct.tnode** %5, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 1
  %89 = getelementptr inbounds %struct.tdata, %struct.tdata* %88, i32 0, i32 1
  %90 = bitcast %union.data_type* %89 to double*
  %91 = load double, double* %90, align 8
  %92 = load %struct.tnode*, %struct.tnode** %6, align 8
  %93 = getelementptr inbounds %struct.tnode, %struct.tnode* %92, i32 0, i32 1
  %94 = getelementptr inbounds %struct.tdata, %struct.tdata* %93, i32 0, i32 1
  %95 = bitcast %union.data_type* %94 to i32*
  %96 = load i32, i32* %95, align 8
  %97 = sitofp i32 %96 to double
  %98 = fdiv double %91, %97
  %99 = load %struct.tnode*, %struct.tnode** %4, align 8
  %100 = getelementptr inbounds %struct.tnode, %struct.tnode* %99, i32 0, i32 1
  %101 = getelementptr inbounds %struct.tdata, %struct.tdata* %100, i32 0, i32 1
  %102 = bitcast %union.data_type* %101 to double*
  store double %98, double* %102, align 8
  %103 = load %struct.tnode*, %struct.tnode** %4, align 8
  %104 = getelementptr inbounds %struct.tnode, %struct.tnode* %103, i32 0, i32 1
  %105 = getelementptr inbounds %struct.tdata, %struct.tdata* %104, i32 0, i32 0
  store i8 2, i8* %105, align 8
  br label %156

; <label>:106:                                    ; preds = %79, %72
  %107 = load %struct.tnode*, %struct.tnode** %5, align 8
  %108 = getelementptr inbounds %struct.tnode, %struct.tnode* %107, i32 0, i32 1
  %109 = getelementptr inbounds %struct.tdata, %struct.tdata* %108, i32 0, i32 0
  %110 = load i8, i8* %109, align 8
  %111 = zext i8 %110 to i32
  %112 = icmp eq i32 %111, 1
  br i1 %112, label %113, label %140

; <label>:113:                                    ; preds = %106
  %114 = load %struct.tnode*, %struct.tnode** %6, align 8
  %115 = getelementptr inbounds %struct.tnode, %struct.tnode* %114, i32 0, i32 1
  %116 = getelementptr inbounds %struct.tdata, %struct.tdata* %115, i32 0, i32 0
  %117 = load i8, i8* %116, align 8
  %118 = zext i8 %117 to i32
  %119 = icmp eq i32 %118, 2
  br i1 %119, label %120, label %140

; <label>:120:                                    ; preds = %113
  %121 = load %struct.tnode*, %struct.tnode** %5, align 8
  %122 = getelementptr inbounds %struct.tnode, %struct.tnode* %121, i32 0, i32 1
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %122, i32 0, i32 1
  %124 = bitcast %union.data_type* %123 to i32*
  %125 = load i32, i32* %124, align 8
  %126 = sitofp i32 %125 to double
  %127 = load %struct.tnode*, %struct.tnode** %6, align 8
  %128 = getelementptr inbounds %struct.tnode, %struct.tnode* %127, i32 0, i32 1
  %129 = getelementptr inbounds %struct.tdata, %struct.tdata* %128, i32 0, i32 1
  %130 = bitcast %union.data_type* %129 to double*
  %131 = load double, double* %130, align 8
  %132 = fdiv double %126, %131
  %133 = load %struct.tnode*, %struct.tnode** %4, align 8
  %134 = getelementptr inbounds %struct.tnode, %struct.tnode* %133, i32 0, i32 1
  %135 = getelementptr inbounds %struct.tdata, %struct.tdata* %134, i32 0, i32 1
  %136 = bitcast %union.data_type* %135 to double*
  store double %132, double* %136, align 8
  %137 = load %struct.tnode*, %struct.tnode** %4, align 8
  %138 = getelementptr inbounds %struct.tnode, %struct.tnode* %137, i32 0, i32 1
  %139 = getelementptr inbounds %struct.tdata, %struct.tdata* %138, i32 0, i32 0
  store i8 2, i8* %139, align 8
  br label %155

; <label>:140:                                    ; preds = %113, %106
  %141 = load %struct.tnode*, %struct.tnode** %5, align 8
  %142 = getelementptr inbounds %struct.tnode, %struct.tnode* %141, i32 0, i32 1
  %143 = getelementptr inbounds %struct.tdata, %struct.tdata* %142, i32 0, i32 0
  %144 = load i8, i8* %143, align 8
  %145 = zext i8 %144 to i32
  %146 = load %struct.tnode*, %struct.tnode** %6, align 8
  %147 = getelementptr inbounds %struct.tnode, %struct.tnode* %146, i32 0, i32 1
  %148 = getelementptr inbounds %struct.tdata, %struct.tdata* %147, i32 0, i32 0
  %149 = load i8, i8* %148, align 8
  %150 = zext i8 %149 to i32
  %151 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.27, i32 0, i32 0), i32 %145, i32 %150)
  %152 = load %struct.tnode*, %struct.tnode** %4, align 8
  %153 = getelementptr inbounds %struct.tnode, %struct.tnode* %152, i32 0, i32 1
  %154 = getelementptr inbounds %struct.tdata, %struct.tdata* %153, i32 0, i32 0
  store i8 0, i8* %154, align 8
  br label %155

; <label>:155:                                    ; preds = %140, %120
  br label %156

; <label>:156:                                    ; preds = %155, %86
  br label %157

; <label>:157:                                    ; preds = %156, %53
  br label %158

; <label>:158:                                    ; preds = %157, %20
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %39

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 2
  br i1 %19, label %20, label %39

; <label>:20:                                     ; preds = %13
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to double*
  %25 = load double, double* %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 1
  %29 = bitcast %union.data_type* %28 to double*
  %30 = load double, double* %29, align 8
  %31 = fadd double %25, %30
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 1
  %35 = bitcast %union.data_type* %34 to double*
  store double %31, double* %35, align 8
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 0
  store i8 2, i8* %38, align 8
  br label %158

; <label>:39:                                     ; preds = %13, %3
  %40 = load %struct.tnode*, %struct.tnode** %5, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 1
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  %43 = load i8, i8* %42, align 8
  %44 = zext i8 %43 to i32
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %72

; <label>:46:                                     ; preds = %39
  %47 = load %struct.tnode*, %struct.tnode** %6, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 1
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 0
  %50 = load i8, i8* %49, align 8
  %51 = zext i8 %50 to i32
  %52 = icmp eq i32 %51, 1
  br i1 %52, label %53, label %72

; <label>:53:                                     ; preds = %46
  %54 = load %struct.tnode*, %struct.tnode** %5, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 1
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 1
  %57 = bitcast %union.data_type* %56 to i32*
  %58 = load i32, i32* %57, align 8
  %59 = load %struct.tnode*, %struct.tnode** %6, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 1
  %61 = getelementptr inbounds %struct.tdata, %struct.tdata* %60, i32 0, i32 1
  %62 = bitcast %union.data_type* %61 to i32*
  %63 = load i32, i32* %62, align 8
  %64 = add nsw i32 %58, %63
  %65 = load %struct.tnode*, %struct.tnode** %4, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 1
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 1
  %68 = bitcast %union.data_type* %67 to i32*
  store i32 %64, i32* %68, align 8
  %69 = load %struct.tnode*, %struct.tnode** %4, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 1
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %70, i32 0, i32 0
  store i8 1, i8* %71, align 8
  br label %157

; <label>:72:                                     ; preds = %46, %39
  %73 = load %struct.tnode*, %struct.tnode** %5, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 1
  %75 = getelementptr inbounds %struct.tdata, %struct.tdata* %74, i32 0, i32 0
  %76 = load i8, i8* %75, align 8
  %77 = zext i8 %76 to i32
  %78 = icmp eq i32 %77, 2
  br i1 %78, label %79, label %106

; <label>:79:                                     ; preds = %72
  %80 = load %struct.tnode*, %struct.tnode** %6, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 1
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  %83 = load i8, i8* %82, align 8
  %84 = zext i8 %83 to i32
  %85 = icmp eq i32 %84, 1
  br i1 %85, label %86, label %106

; <label>:86:                                     ; preds = %79
  %87 = load %struct.tnode*, %struct.tnode** %5, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 1
  %89 = getelementptr inbounds %struct.tdata, %struct.tdata* %88, i32 0, i32 1
  %90 = bitcast %union.data_type* %89 to double*
  %91 = load double, double* %90, align 8
  %92 = load %struct.tnode*, %struct.tnode** %6, align 8
  %93 = getelementptr inbounds %struct.tnode, %struct.tnode* %92, i32 0, i32 1
  %94 = getelementptr inbounds %struct.tdata, %struct.tdata* %93, i32 0, i32 1
  %95 = bitcast %union.data_type* %94 to i32*
  %96 = load i32, i32* %95, align 8
  %97 = sitofp i32 %96 to double
  %98 = fadd double %91, %97
  %99 = load %struct.tnode*, %struct.tnode** %4, align 8
  %100 = getelementptr inbounds %struct.tnode, %struct.tnode* %99, i32 0, i32 1
  %101 = getelementptr inbounds %struct.tdata, %struct.tdata* %100, i32 0, i32 1
  %102 = bitcast %union.data_type* %101 to double*
  store double %98, double* %102, align 8
  %103 = load %struct.tnode*, %struct.tnode** %4, align 8
  %104 = getelementptr inbounds %struct.tnode, %struct.tnode* %103, i32 0, i32 1
  %105 = getelementptr inbounds %struct.tdata, %struct.tdata* %104, i32 0, i32 0
  store i8 2, i8* %105, align 8
  br label %156

; <label>:106:                                    ; preds = %79, %72
  %107 = load %struct.tnode*, %struct.tnode** %5, align 8
  %108 = getelementptr inbounds %struct.tnode, %struct.tnode* %107, i32 0, i32 1
  %109 = getelementptr inbounds %struct.tdata, %struct.tdata* %108, i32 0, i32 0
  %110 = load i8, i8* %109, align 8
  %111 = zext i8 %110 to i32
  %112 = icmp eq i32 %111, 1
  br i1 %112, label %113, label %140

; <label>:113:                                    ; preds = %106
  %114 = load %struct.tnode*, %struct.tnode** %6, align 8
  %115 = getelementptr inbounds %struct.tnode, %struct.tnode* %114, i32 0, i32 1
  %116 = getelementptr inbounds %struct.tdata, %struct.tdata* %115, i32 0, i32 0
  %117 = load i8, i8* %116, align 8
  %118 = zext i8 %117 to i32
  %119 = icmp eq i32 %118, 2
  br i1 %119, label %120, label %140

; <label>:120:                                    ; preds = %113
  %121 = load %struct.tnode*, %struct.tnode** %5, align 8
  %122 = getelementptr inbounds %struct.tnode, %struct.tnode* %121, i32 0, i32 1
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %122, i32 0, i32 1
  %124 = bitcast %union.data_type* %123 to i32*
  %125 = load i32, i32* %124, align 8
  %126 = sitofp i32 %125 to double
  %127 = load %struct.tnode*, %struct.tnode** %6, align 8
  %128 = getelementptr inbounds %struct.tnode, %struct.tnode* %127, i32 0, i32 1
  %129 = getelementptr inbounds %struct.tdata, %struct.tdata* %128, i32 0, i32 1
  %130 = bitcast %union.data_type* %129 to double*
  %131 = load double, double* %130, align 8
  %132 = fadd double %126, %131
  %133 = load %struct.tnode*, %struct.tnode** %4, align 8
  %134 = getelementptr inbounds %struct.tnode, %struct.tnode* %133, i32 0, i32 1
  %135 = getelementptr inbounds %struct.tdata, %struct.tdata* %134, i32 0, i32 1
  %136 = bitcast %union.data_type* %135 to double*
  store double %132, double* %136, align 8
  %137 = load %struct.tnode*, %struct.tnode** %4, align 8
  %138 = getelementptr inbounds %struct.tnode, %struct.tnode* %137, i32 0, i32 1
  %139 = getelementptr inbounds %struct.tdata, %struct.tdata* %138, i32 0, i32 0
  store i8 2, i8* %139, align 8
  br label %155

; <label>:140:                                    ; preds = %113, %106
  %141 = load %struct.tnode*, %struct.tnode** %5, align 8
  %142 = getelementptr inbounds %struct.tnode, %struct.tnode* %141, i32 0, i32 1
  %143 = getelementptr inbounds %struct.tdata, %struct.tdata* %142, i32 0, i32 0
  %144 = load i8, i8* %143, align 8
  %145 = zext i8 %144 to i32
  %146 = load %struct.tnode*, %struct.tnode** %6, align 8
  %147 = getelementptr inbounds %struct.tnode, %struct.tnode* %146, i32 0, i32 1
  %148 = getelementptr inbounds %struct.tdata, %struct.tdata* %147, i32 0, i32 0
  %149 = load i8, i8* %148, align 8
  %150 = zext i8 %149 to i32
  %151 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.28, i32 0, i32 0), i32 %145, i32 %150)
  %152 = load %struct.tnode*, %struct.tnode** %4, align 8
  %153 = getelementptr inbounds %struct.tnode, %struct.tnode* %152, i32 0, i32 1
  %154 = getelementptr inbounds %struct.tdata, %struct.tdata* %153, i32 0, i32 0
  store i8 0, i8* %154, align 8
  br label %155

; <label>:155:                                    ; preds = %140, %120
  br label %156

; <label>:156:                                    ; preds = %155, %86
  br label %157

; <label>:157:                                    ; preds = %156, %53
  br label %158

; <label>:158:                                    ; preds = %157, %20
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %39

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 2
  br i1 %19, label %20, label %39

; <label>:20:                                     ; preds = %13
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to double*
  %25 = load double, double* %24, align 8
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 1
  %29 = bitcast %union.data_type* %28 to double*
  %30 = load double, double* %29, align 8
  %31 = fsub double %25, %30
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 1
  %35 = bitcast %union.data_type* %34 to double*
  store double %31, double* %35, align 8
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 0
  store i8 2, i8* %38, align 8
  br label %158

; <label>:39:                                     ; preds = %13, %3
  %40 = load %struct.tnode*, %struct.tnode** %5, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 1
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  %43 = load i8, i8* %42, align 8
  %44 = zext i8 %43 to i32
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %72

; <label>:46:                                     ; preds = %39
  %47 = load %struct.tnode*, %struct.tnode** %6, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 1
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 0
  %50 = load i8, i8* %49, align 8
  %51 = zext i8 %50 to i32
  %52 = icmp eq i32 %51, 1
  br i1 %52, label %53, label %72

; <label>:53:                                     ; preds = %46
  %54 = load %struct.tnode*, %struct.tnode** %5, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 1
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 1
  %57 = bitcast %union.data_type* %56 to i32*
  %58 = load i32, i32* %57, align 8
  %59 = load %struct.tnode*, %struct.tnode** %6, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 1
  %61 = getelementptr inbounds %struct.tdata, %struct.tdata* %60, i32 0, i32 1
  %62 = bitcast %union.data_type* %61 to i32*
  %63 = load i32, i32* %62, align 8
  %64 = sub nsw i32 %58, %63
  %65 = load %struct.tnode*, %struct.tnode** %4, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 1
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 1
  %68 = bitcast %union.data_type* %67 to i32*
  store i32 %64, i32* %68, align 8
  %69 = load %struct.tnode*, %struct.tnode** %4, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 1
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %70, i32 0, i32 0
  store i8 1, i8* %71, align 8
  br label %157

; <label>:72:                                     ; preds = %46, %39
  %73 = load %struct.tnode*, %struct.tnode** %5, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 1
  %75 = getelementptr inbounds %struct.tdata, %struct.tdata* %74, i32 0, i32 0
  %76 = load i8, i8* %75, align 8
  %77 = zext i8 %76 to i32
  %78 = icmp eq i32 %77, 2
  br i1 %78, label %79, label %106

; <label>:79:                                     ; preds = %72
  %80 = load %struct.tnode*, %struct.tnode** %6, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 1
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  %83 = load i8, i8* %82, align 8
  %84 = zext i8 %83 to i32
  %85 = icmp eq i32 %84, 1
  br i1 %85, label %86, label %106

; <label>:86:                                     ; preds = %79
  %87 = load %struct.tnode*, %struct.tnode** %5, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 1
  %89 = getelementptr inbounds %struct.tdata, %struct.tdata* %88, i32 0, i32 1
  %90 = bitcast %union.data_type* %89 to double*
  %91 = load double, double* %90, align 8
  %92 = load %struct.tnode*, %struct.tnode** %6, align 8
  %93 = getelementptr inbounds %struct.tnode, %struct.tnode* %92, i32 0, i32 1
  %94 = getelementptr inbounds %struct.tdata, %struct.tdata* %93, i32 0, i32 1
  %95 = bitcast %union.data_type* %94 to i32*
  %96 = load i32, i32* %95, align 8
  %97 = sitofp i32 %96 to double
  %98 = fsub double %91, %97
  %99 = load %struct.tnode*, %struct.tnode** %4, align 8
  %100 = getelementptr inbounds %struct.tnode, %struct.tnode* %99, i32 0, i32 1
  %101 = getelementptr inbounds %struct.tdata, %struct.tdata* %100, i32 0, i32 1
  %102 = bitcast %union.data_type* %101 to double*
  store double %98, double* %102, align 8
  %103 = load %struct.tnode*, %struct.tnode** %4, align 8
  %104 = getelementptr inbounds %struct.tnode, %struct.tnode* %103, i32 0, i32 1
  %105 = getelementptr inbounds %struct.tdata, %struct.tdata* %104, i32 0, i32 0
  store i8 2, i8* %105, align 8
  br label %156

; <label>:106:                                    ; preds = %79, %72
  %107 = load %struct.tnode*, %struct.tnode** %5, align 8
  %108 = getelementptr inbounds %struct.tnode, %struct.tnode* %107, i32 0, i32 1
  %109 = getelementptr inbounds %struct.tdata, %struct.tdata* %108, i32 0, i32 0
  %110 = load i8, i8* %109, align 8
  %111 = zext i8 %110 to i32
  %112 = icmp eq i32 %111, 1
  br i1 %112, label %113, label %140

; <label>:113:                                    ; preds = %106
  %114 = load %struct.tnode*, %struct.tnode** %6, align 8
  %115 = getelementptr inbounds %struct.tnode, %struct.tnode* %114, i32 0, i32 1
  %116 = getelementptr inbounds %struct.tdata, %struct.tdata* %115, i32 0, i32 0
  %117 = load i8, i8* %116, align 8
  %118 = zext i8 %117 to i32
  %119 = icmp eq i32 %118, 2
  br i1 %119, label %120, label %140

; <label>:120:                                    ; preds = %113
  %121 = load %struct.tnode*, %struct.tnode** %5, align 8
  %122 = getelementptr inbounds %struct.tnode, %struct.tnode* %121, i32 0, i32 1
  %123 = getelementptr inbounds %struct.tdata, %struct.tdata* %122, i32 0, i32 1
  %124 = bitcast %union.data_type* %123 to i32*
  %125 = load i32, i32* %124, align 8
  %126 = sitofp i32 %125 to double
  %127 = load %struct.tnode*, %struct.tnode** %6, align 8
  %128 = getelementptr inbounds %struct.tnode, %struct.tnode* %127, i32 0, i32 1
  %129 = getelementptr inbounds %struct.tdata, %struct.tdata* %128, i32 0, i32 1
  %130 = bitcast %union.data_type* %129 to double*
  %131 = load double, double* %130, align 8
  %132 = fsub double %126, %131
  %133 = load %struct.tnode*, %struct.tnode** %4, align 8
  %134 = getelementptr inbounds %struct.tnode, %struct.tnode* %133, i32 0, i32 1
  %135 = getelementptr inbounds %struct.tdata, %struct.tdata* %134, i32 0, i32 1
  %136 = bitcast %union.data_type* %135 to double*
  store double %132, double* %136, align 8
  %137 = load %struct.tnode*, %struct.tnode** %4, align 8
  %138 = getelementptr inbounds %struct.tnode, %struct.tnode* %137, i32 0, i32 1
  %139 = getelementptr inbounds %struct.tdata, %struct.tdata* %138, i32 0, i32 0
  store i8 2, i8* %139, align 8
  br label %155

; <label>:140:                                    ; preds = %113, %106
  %141 = load %struct.tnode*, %struct.tnode** %5, align 8
  %142 = getelementptr inbounds %struct.tnode, %struct.tnode* %141, i32 0, i32 1
  %143 = getelementptr inbounds %struct.tdata, %struct.tdata* %142, i32 0, i32 0
  %144 = load i8, i8* %143, align 8
  %145 = zext i8 %144 to i32
  %146 = load %struct.tnode*, %struct.tnode** %6, align 8
  %147 = getelementptr inbounds %struct.tnode, %struct.tnode* %146, i32 0, i32 1
  %148 = getelementptr inbounds %struct.tdata, %struct.tdata* %147, i32 0, i32 0
  %149 = load i8, i8* %148, align 8
  %150 = zext i8 %149 to i32
  %151 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.29, i32 0, i32 0), i32 %145, i32 %150)
  %152 = load %struct.tnode*, %struct.tnode** %4, align 8
  %153 = getelementptr inbounds %struct.tnode, %struct.tnode* %152, i32 0, i32 1
  %154 = getelementptr inbounds %struct.tdata, %struct.tdata* %153, i32 0, i32 0
  store i8 0, i8* %154, align 8
  br label %155

; <label>:155:                                    ; preds = %140, %120
  br label %156

; <label>:156:                                    ; preds = %155, %86
  br label %157

; <label>:157:                                    ; preds = %156, %53
  br label %158

; <label>:158:                                    ; preds = %157, %20
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %28

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = load double, double* %6, align 8
  %20 = fadd double %18, %19
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to double*
  store double %20, double* %24, align 8
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  store i8 2, i8* %27, align 8
  br label %56

; <label>:28:                                     ; preds = %3
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i8, i8* %31, align 8
  %33 = zext i8 %32 to i32
  %34 = icmp eq i32 %33, 1
  br i1 %34, label %35, label %51

; <label>:35:                                     ; preds = %28
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 1
  %39 = bitcast %union.data_type* %38 to i32*
  %40 = load i32, i32* %39, align 8
  %41 = sitofp i32 %40 to double
  %42 = load double, double* %6, align 8
  %43 = fadd double %41, %42
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to double*
  store double %43, double* %47, align 8
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 0
  store i8 2, i8* %50, align 8
  br label %55

; <label>:51:                                     ; preds = %28
  %52 = load %struct.tnode*, %struct.tnode** %4, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  store i8 0, i8* %54, align 8
  br label %55

; <label>:55:                                     ; preds = %51, %35
  br label %56

; <label>:56:                                     ; preds = %55, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 1
  br i1 %12, label %13, label %28

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to i32*
  %18 = load i32, i32* %17, align 8
  %19 = load i32, i32* %6, align 4
  %20 = mul nsw i32 %18, %19
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to i32*
  store i32 %20, i32* %24, align 8
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  store i8 1, i8* %27, align 8
  br label %62

; <label>:28:                                     ; preds = %3
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i8, i8* %31, align 8
  %33 = zext i8 %32 to i32
  %34 = icmp eq i32 %33, 2
  br i1 %34, label %35, label %51

; <label>:35:                                     ; preds = %28
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 1
  %39 = bitcast %union.data_type* %38 to double*
  %40 = load double, double* %39, align 8
  %41 = load i32, i32* %6, align 4
  %42 = sitofp i32 %41 to double
  %43 = fmul double %40, %42
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to double*
  store double %43, double* %47, align 8
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 0
  store i8 2, i8* %50, align 8
  br label %61

; <label>:51:                                     ; preds = %28
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  %55 = load i8, i8* %54, align 8
  %56 = zext i8 %55 to i32
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.30, i32 0, i32 0), i32 %56)
  %58 = load %struct.tnode*, %struct.tnode** %4, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 1
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  store i8 0, i8* %60, align 8
  br label %61

; <label>:61:                                     ; preds = %51, %35
  br label %62

; <label>:62:                                     ; preds = %61, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_div_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 1
  br i1 %12, label %13, label %28

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to i32*
  %18 = load i32, i32* %17, align 8
  %19 = load i32, i32* %6, align 4
  %20 = sdiv i32 %18, %19
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to i32*
  store i32 %20, i32* %24, align 8
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  store i8 1, i8* %27, align 8
  br label %62

; <label>:28:                                     ; preds = %3
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i8, i8* %31, align 8
  %33 = zext i8 %32 to i32
  %34 = icmp eq i32 %33, 2
  br i1 %34, label %35, label %51

; <label>:35:                                     ; preds = %28
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 1
  %39 = bitcast %union.data_type* %38 to double*
  %40 = load double, double* %39, align 8
  %41 = load i32, i32* %6, align 4
  %42 = sitofp i32 %41 to double
  %43 = fdiv double %40, %42
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to double*
  store double %43, double* %47, align 8
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 0
  store i8 2, i8* %50, align 8
  br label %61

; <label>:51:                                     ; preds = %28
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  %55 = load i8, i8* %54, align 8
  %56 = zext i8 %55 to i32
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.31, i32 0, i32 0), i32 %56)
  %58 = load %struct.tnode*, %struct.tnode** %4, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 1
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  store i8 0, i8* %60, align 8
  br label %61

; <label>:61:                                     ; preds = %51, %35
  br label %62

; <label>:62:                                     ; preds = %61, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mul_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 1
  br i1 %12, label %13, label %29

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to i32*
  %18 = load i32, i32* %17, align 8
  %19 = sitofp i32 %18 to double
  %20 = load double, double* %6, align 8
  %21 = fmul double %19, %20
  %22 = load %struct.tnode*, %struct.tnode** %4, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 1
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 1
  %25 = bitcast %union.data_type* %24 to double*
  store double %21, double* %25, align 8
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 0
  store i8 2, i8* %28, align 8
  br label %62

; <label>:29:                                     ; preds = %3
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 1
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  %33 = load i8, i8* %32, align 8
  %34 = zext i8 %33 to i32
  %35 = icmp eq i32 %34, 2
  br i1 %35, label %36, label %51

; <label>:36:                                     ; preds = %29
  %37 = load %struct.tnode*, %struct.tnode** %5, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 1
  %39 = getelementptr inbounds %struct.tdata, %struct.tdata* %38, i32 0, i32 1
  %40 = bitcast %union.data_type* %39 to double*
  %41 = load double, double* %40, align 8
  %42 = load double, double* %6, align 8
  %43 = fmul double %41, %42
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to double*
  store double %43, double* %47, align 8
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 0
  store i8 2, i8* %50, align 8
  br label %61

; <label>:51:                                     ; preds = %29
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  %55 = load i8, i8* %54, align 8
  %56 = zext i8 %55 to i32
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.32, i32 0, i32 0), i32 %56)
  %58 = load %struct.tnode*, %struct.tnode** %4, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 1
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  store i8 0, i8* %60, align 8
  br label %61

; <label>:61:                                     ; preds = %51, %36
  br label %62

; <label>:62:                                     ; preds = %61, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 1
  br i1 %12, label %13, label %28

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to i32*
  %18 = load i32, i32* %17, align 8
  %19 = load i32, i32* %6, align 4
  %20 = add nsw i32 %18, %19
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to i32*
  store i32 %20, i32* %24, align 8
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  store i8 1, i8* %27, align 8
  br label %62

; <label>:28:                                     ; preds = %3
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i8, i8* %31, align 8
  %33 = zext i8 %32 to i32
  %34 = icmp eq i32 %33, 2
  br i1 %34, label %35, label %51

; <label>:35:                                     ; preds = %28
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 1
  %39 = bitcast %union.data_type* %38 to double*
  %40 = load double, double* %39, align 8
  %41 = load i32, i32* %6, align 4
  %42 = sitofp i32 %41 to double
  %43 = fadd double %40, %42
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to double*
  store double %43, double* %47, align 8
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 0
  store i8 2, i8* %50, align 8
  br label %61

; <label>:51:                                     ; preds = %28
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  %55 = load i8, i8* %54, align 8
  %56 = zext i8 %55 to i32
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.33, i32 0, i32 0), i32 %56)
  %58 = load %struct.tnode*, %struct.tnode** %4, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 1
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  store i8 0, i8* %60, align 8
  br label %61

; <label>:61:                                     ; preds = %51, %35
  br label %62

; <label>:62:                                     ; preds = %61, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %28

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = load double, double* %6, align 8
  %20 = fsub double %18, %19
  %21 = load %struct.tnode*, %struct.tnode** %4, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to double*
  store double %20, double* %24, align 8
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 0
  store i8 2, i8* %27, align 8
  br label %62

; <label>:28:                                     ; preds = %3
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i8, i8* %31, align 8
  %33 = zext i8 %32 to i32
  %34 = icmp eq i32 %33, 1
  br i1 %34, label %35, label %51

; <label>:35:                                     ; preds = %28
  %36 = load %struct.tnode*, %struct.tnode** %5, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 1
  %39 = bitcast %union.data_type* %38 to i32*
  %40 = load i32, i32* %39, align 8
  %41 = sitofp i32 %40 to double
  %42 = load double, double* %6, align 8
  %43 = fsub double %41, %42
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to double*
  store double %43, double* %47, align 8
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 0
  store i8 2, i8* %50, align 8
  br label %61

; <label>:51:                                     ; preds = %28
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  %55 = load i8, i8* %54, align 8
  %56 = zext i8 %55 to i32
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.34, i32 0, i32 0), i32 %56)
  %58 = load %struct.tnode*, %struct.tnode** %4, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 1
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  store i8 0, i8* %60, align 8
  br label %61

; <label>:61:                                     ; preds = %51, %35
  br label %62

; <label>:62:                                     ; preds = %61, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %29

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = load i32, i32* %6, align 4
  %20 = sitofp i32 %19 to double
  %21 = fsub double %18, %20
  %22 = load %struct.tnode*, %struct.tnode** %4, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 1
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 1
  %25 = bitcast %union.data_type* %24 to double*
  store double %21, double* %25, align 8
  %26 = load %struct.tnode*, %struct.tnode** %4, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 0
  store i8 2, i8* %28, align 8
  br label %62

; <label>:29:                                     ; preds = %3
  %30 = load %struct.tnode*, %struct.tnode** %5, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 1
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 0
  %33 = load i8, i8* %32, align 8
  %34 = zext i8 %33 to i32
  %35 = icmp eq i32 %34, 1
  br i1 %35, label %36, label %51

; <label>:36:                                     ; preds = %29
  %37 = load %struct.tnode*, %struct.tnode** %5, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 1
  %39 = getelementptr inbounds %struct.tdata, %struct.tdata* %38, i32 0, i32 1
  %40 = bitcast %union.data_type* %39 to i32*
  %41 = load i32, i32* %40, align 8
  %42 = load i32, i32* %6, align 4
  %43 = sub nsw i32 %41, %42
  %44 = load %struct.tnode*, %struct.tnode** %4, align 8
  %45 = getelementptr inbounds %struct.tnode, %struct.tnode* %44, i32 0, i32 1
  %46 = getelementptr inbounds %struct.tdata, %struct.tdata* %45, i32 0, i32 1
  %47 = bitcast %union.data_type* %46 to i32*
  store i32 %43, i32* %47, align 8
  %48 = load %struct.tnode*, %struct.tnode** %4, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 1
  %50 = getelementptr inbounds %struct.tdata, %struct.tdata* %49, i32 0, i32 0
  store i8 1, i8* %50, align 8
  br label %61

; <label>:51:                                     ; preds = %29
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 0
  %55 = load i8, i8* %54, align 8
  %56 = zext i8 %55 to i32
  %57 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.35, i32 0, i32 0), i32 %56)
  %58 = load %struct.tnode*, %struct.tnode** %4, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 1
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  store i8 0, i8* %60, align 8
  br label %61

; <label>:61:                                     ; preds = %51, %36
  br label %62

; <label>:62:                                     ; preds = %61, %13
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_mod_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.tnode*, %struct.tnode** %5, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.tdata, %struct.tdata* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %41

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 2
  br i1 %19, label %20, label %41

; <label>:20:                                     ; preds = %13
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to double*
  %25 = load double, double* %24, align 8
  %26 = fptosi double %25 to i32
  %27 = load %struct.tnode*, %struct.tnode** %6, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 1
  %30 = bitcast %union.data_type* %29 to double*
  %31 = load double, double* %30, align 8
  %32 = fptosi double %31 to i32
  %33 = srem i32 %26, %32
  %34 = load %struct.tnode*, %struct.tnode** %4, align 8
  %35 = getelementptr inbounds %struct.tnode, %struct.tnode* %34, i32 0, i32 1
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %35, i32 0, i32 1
  %37 = bitcast %union.data_type* %36 to i32*
  store i32 %33, i32* %37, align 8
  %38 = load %struct.tnode*, %struct.tnode** %4, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 0
  store i8 1, i8* %40, align 8
  br label %156

; <label>:41:                                     ; preds = %13, %3
  %42 = load %struct.tnode*, %struct.tnode** %5, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 1
  %44 = getelementptr inbounds %struct.tdata, %struct.tdata* %43, i32 0, i32 0
  %45 = load i8, i8* %44, align 8
  %46 = zext i8 %45 to i32
  %47 = icmp eq i32 %46, 1
  br i1 %47, label %48, label %74

; <label>:48:                                     ; preds = %41
  %49 = load %struct.tnode*, %struct.tnode** %6, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 0
  %52 = load i8, i8* %51, align 8
  %53 = zext i8 %52 to i32
  %54 = icmp eq i32 %53, 1
  br i1 %54, label %55, label %74

; <label>:55:                                     ; preds = %48
  %56 = load %struct.tnode*, %struct.tnode** %5, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 1
  %59 = bitcast %union.data_type* %58 to i32*
  %60 = load i32, i32* %59, align 8
  %61 = load %struct.tnode*, %struct.tnode** %6, align 8
  %62 = getelementptr inbounds %struct.tnode, %struct.tnode* %61, i32 0, i32 1
  %63 = getelementptr inbounds %struct.tdata, %struct.tdata* %62, i32 0, i32 1
  %64 = bitcast %union.data_type* %63 to i32*
  %65 = load i32, i32* %64, align 8
  %66 = srem i32 %60, %65
  %67 = load %struct.tnode*, %struct.tnode** %4, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 1
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 1
  %70 = bitcast %union.data_type* %69 to i32*
  store i32 %66, i32* %70, align 8
  %71 = load %struct.tnode*, %struct.tnode** %4, align 8
  %72 = getelementptr inbounds %struct.tnode, %struct.tnode* %71, i32 0, i32 1
  %73 = getelementptr inbounds %struct.tdata, %struct.tdata* %72, i32 0, i32 0
  store i8 1, i8* %73, align 8
  br label %155

; <label>:74:                                     ; preds = %48, %41
  %75 = load %struct.tnode*, %struct.tnode** %5, align 8
  %76 = getelementptr inbounds %struct.tnode, %struct.tnode* %75, i32 0, i32 1
  %77 = getelementptr inbounds %struct.tdata, %struct.tdata* %76, i32 0, i32 0
  %78 = load i8, i8* %77, align 8
  %79 = zext i8 %78 to i32
  %80 = icmp eq i32 %79, 2
  br i1 %80, label %81, label %108

; <label>:81:                                     ; preds = %74
  %82 = load %struct.tnode*, %struct.tnode** %6, align 8
  %83 = getelementptr inbounds %struct.tnode, %struct.tnode* %82, i32 0, i32 1
  %84 = getelementptr inbounds %struct.tdata, %struct.tdata* %83, i32 0, i32 0
  %85 = load i8, i8* %84, align 8
  %86 = zext i8 %85 to i32
  %87 = icmp eq i32 %86, 1
  br i1 %87, label %88, label %108

; <label>:88:                                     ; preds = %81
  %89 = load %struct.tnode*, %struct.tnode** %5, align 8
  %90 = getelementptr inbounds %struct.tnode, %struct.tnode* %89, i32 0, i32 1
  %91 = getelementptr inbounds %struct.tdata, %struct.tdata* %90, i32 0, i32 1
  %92 = bitcast %union.data_type* %91 to double*
  %93 = load double, double* %92, align 8
  %94 = fptosi double %93 to i32
  %95 = load %struct.tnode*, %struct.tnode** %6, align 8
  %96 = getelementptr inbounds %struct.tnode, %struct.tnode* %95, i32 0, i32 1
  %97 = getelementptr inbounds %struct.tdata, %struct.tdata* %96, i32 0, i32 1
  %98 = bitcast %union.data_type* %97 to i32*
  %99 = load i32, i32* %98, align 8
  %100 = srem i32 %94, %99
  %101 = load %struct.tnode*, %struct.tnode** %4, align 8
  %102 = getelementptr inbounds %struct.tnode, %struct.tnode* %101, i32 0, i32 1
  %103 = getelementptr inbounds %struct.tdata, %struct.tdata* %102, i32 0, i32 1
  %104 = bitcast %union.data_type* %103 to i32*
  store i32 %100, i32* %104, align 8
  %105 = load %struct.tnode*, %struct.tnode** %4, align 8
  %106 = getelementptr inbounds %struct.tnode, %struct.tnode* %105, i32 0, i32 1
  %107 = getelementptr inbounds %struct.tdata, %struct.tdata* %106, i32 0, i32 0
  store i8 1, i8* %107, align 8
  br label %154

; <label>:108:                                    ; preds = %81, %74
  %109 = load %struct.tnode*, %struct.tnode** %5, align 8
  %110 = getelementptr inbounds %struct.tnode, %struct.tnode* %109, i32 0, i32 1
  %111 = getelementptr inbounds %struct.tdata, %struct.tdata* %110, i32 0, i32 0
  %112 = load i8, i8* %111, align 8
  %113 = zext i8 %112 to i32
  %114 = icmp eq i32 %113, 1
  br i1 %114, label %115, label %143

; <label>:115:                                    ; preds = %108
  %116 = load %struct.tnode*, %struct.tnode** %6, align 8
  %117 = getelementptr inbounds %struct.tnode, %struct.tnode* %116, i32 0, i32 1
  %118 = getelementptr inbounds %struct.tdata, %struct.tdata* %117, i32 0, i32 0
  %119 = load i8, i8* %118, align 8
  %120 = zext i8 %119 to i32
  %121 = icmp eq i32 %120, 2
  br i1 %121, label %122, label %143

; <label>:122:                                    ; preds = %115
  %123 = load %struct.tnode*, %struct.tnode** %5, align 8
  %124 = getelementptr inbounds %struct.tnode, %struct.tnode* %123, i32 0, i32 1
  %125 = getelementptr inbounds %struct.tdata, %struct.tdata* %124, i32 0, i32 1
  %126 = bitcast %union.data_type* %125 to i32*
  %127 = load i32, i32* %126, align 8
  %128 = load %struct.tnode*, %struct.tnode** %6, align 8
  %129 = getelementptr inbounds %struct.tnode, %struct.tnode* %128, i32 0, i32 1
  %130 = getelementptr inbounds %struct.tdata, %struct.tdata* %129, i32 0, i32 1
  %131 = bitcast %union.data_type* %130 to double*
  %132 = load double, double* %131, align 8
  %133 = fptosi double %132 to i32
  %134 = srem i32 %127, %133
  %135 = sitofp i32 %134 to double
  %136 = load %struct.tnode*, %struct.tnode** %4, align 8
  %137 = getelementptr inbounds %struct.tnode, %struct.tnode* %136, i32 0, i32 1
  %138 = getelementptr inbounds %struct.tdata, %struct.tdata* %137, i32 0, i32 1
  %139 = bitcast %union.data_type* %138 to double*
  store double %135, double* %139, align 8
  %140 = load %struct.tnode*, %struct.tnode** %4, align 8
  %141 = getelementptr inbounds %struct.tnode, %struct.tnode* %140, i32 0, i32 1
  %142 = getelementptr inbounds %struct.tdata, %struct.tdata* %141, i32 0, i32 0
  store i8 1, i8* %142, align 8
  br label %153

; <label>:143:                                    ; preds = %115, %108
  %144 = load %struct.tnode*, %struct.tnode** %5, align 8
  %145 = getelementptr inbounds %struct.tnode, %struct.tnode* %144, i32 0, i32 1
  %146 = getelementptr inbounds %struct.tdata, %struct.tdata* %145, i32 0, i32 0
  %147 = load i8, i8* %146, align 8
  %148 = zext i8 %147 to i32
  %149 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.36, i32 0, i32 0), i32 %148)
  %150 = load %struct.tnode*, %struct.tnode** %4, align 8
  %151 = getelementptr inbounds %struct.tnode, %struct.tnode* %150, i32 0, i32 1
  %152 = getelementptr inbounds %struct.tdata, %struct.tdata* %151, i32 0, i32 0
  store i8 0, i8* %152, align 8
  br label %153

; <label>:153:                                    ; preds = %143, %122
  br label %154

; <label>:154:                                    ; preds = %153, %88
  br label %155

; <label>:155:                                    ; preds = %154, %55
  br label %156

; <label>:156:                                    ; preds = %155, %20
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @rand_range(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = call i32 @rand()
  %6 = load i32, i32* %4, align 4
  %7 = load i32, i32* %3, align 4
  %8 = sub nsw i32 %6, %7
  %9 = add nsw i32 %8, 1
  %10 = srem i32 %5, %9
  %11 = load i32, i32* %3, align 4
  %12 = add nsw i32 %10, %11
  ret i32 %12
}

declare i32 @rand() #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @init_random_seed() #0 {
  %1 = alloca i32, align 4
  %2 = call i64 @time(i64* null)
  %3 = trunc i64 %2 to i32
  store i32 %3, i32* %1, align 4
  %4 = load i32, i32* %1, align 4
  call void @srand(i32 %4)
  ret void
}

declare i64 @time(i64*) #1

declare void @srand(i32) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_print_scalar_element(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = getelementptr inbounds %struct.tnode, %struct.tnode* %3, i32 0, i32 1
  %5 = getelementptr inbounds %struct.tdata, %struct.tdata* %4, i32 0, i32 0
  %6 = load i8, i8* %5, align 8
  %7 = zext i8 %6 to i32
  switch i32 %7, label %22 [
    i32 1, label %8
    i32 2, label %15
  ]

; <label>:8:                                      ; preds = %1
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 1
  %12 = bitcast %union.data_type* %11 to i32*
  %13 = load i32, i32* %12, align 8
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.37, i32 0, i32 0), i32 %13)
  br label %29

; <label>:15:                                     ; preds = %1
  %16 = load %struct.tnode*, %struct.tnode** %2, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 1
  %18 = getelementptr inbounds %struct.tdata, %struct.tdata* %17, i32 0, i32 1
  %19 = bitcast %union.data_type* %18 to double*
  %20 = load double, double* %19, align 8
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.38, i32 0, i32 0), double %20)
  br label %29

; <label>:22:                                     ; preds = %1
  %23 = load %struct.tnode*, %struct.tnode** %2, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 0
  %26 = load i8, i8* %25, align 8
  %27 = zext i8 %26 to i32
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.39, i32 0, i32 0), i32 %27)
  br label %29

; <label>:29:                                     ; preds = %22, %15, %8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_scalar(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %5 = load %struct.tnode*, %struct.tnode** %2, align 8
  %6 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 0
  %7 = load i8, i8* %6, align 8
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %8, 3
  br i1 %9, label %10, label %50

; <label>:10:                                     ; preds = %1
  %11 = load %struct.tnode*, %struct.tnode** %2, align 8
  store %struct.tnode* %11, %struct.tnode** %3, align 8
  store i32 0, i32* %4, align 4
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.40, i32 0, i32 0))
  br label %13

; <label>:13:                                     ; preds = %35, %10
  %14 = load %struct.tnode*, %struct.tnode** %3, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 2
  %16 = load %struct.tnode*, %struct.tnode** %15, align 8
  %17 = icmp ne %struct.tnode* %16, null
  br i1 %17, label %18, label %22

; <label>:18:                                     ; preds = %13
  %19 = load i32, i32* %4, align 4
  %20 = load i32, i32* @g_funk_print_array_max_elements, align 4
  %21 = icmp slt i32 %19, %20
  br label %22

; <label>:22:                                     ; preds = %18, %13
  %23 = phi i1 [ false, %13 ], [ %21, %18 ]
  br i1 %23, label %24, label %41

; <label>:24:                                     ; preds = %22
  %25 = load %struct.tnode*, %struct.tnode** %3, align 8
  call void @funk_print_scalar_element(%struct.tnode* %25)
  %26 = load i32, i32* %4, align 4
  %27 = icmp sgt i32 %26, 0
  br i1 %27, label %28, label %35

; <label>:28:                                     ; preds = %24
  %29 = load i32, i32* %4, align 4
  %30 = load i32, i32* @g_funk_print_array_element_per_row, align 4
  %31 = srem i32 %29, %30
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %35

; <label>:33:                                     ; preds = %28
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.41, i32 0, i32 0))
  br label %35

; <label>:35:                                     ; preds = %33, %28, %24
  %36 = load %struct.tnode*, %struct.tnode** %3, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 2
  %38 = load %struct.tnode*, %struct.tnode** %37, align 8
  store %struct.tnode* %38, %struct.tnode** %3, align 8
  %39 = load i32, i32* %4, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, i32* %4, align 4
  br label %13

; <label>:41:                                     ; preds = %22
  %42 = load %struct.tnode*, %struct.tnode** %3, align 8
  %43 = getelementptr inbounds %struct.tnode, %struct.tnode* %42, i32 0, i32 2
  %44 = load %struct.tnode*, %struct.tnode** %43, align 8
  %45 = icmp ne %struct.tnode* %44, null
  br i1 %45, label %46, label %48

; <label>:46:                                     ; preds = %41
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.42, i32 0, i32 0))
  br label %48

; <label>:48:                                     ; preds = %46, %41
  %49 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.43, i32 0, i32 0))
  br label %52

; <label>:50:                                     ; preds = %1
  %51 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_print_scalar_element(%struct.tnode* %51)
  br label %52

; <label>:52:                                     ; preds = %50, %48
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tnode* @funk_concatenate_lists(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  store i32 0, i32* %5, align 4
  %7 = load %struct.tnode*, %struct.tnode** %3, align 8
  store %struct.tnode* %7, %struct.tnode** %6, align 8
  br label %8

; <label>:8:                                      ; preds = %21, %2
  %9 = load %struct.tnode*, %struct.tnode** %6, align 8
  %10 = icmp ne %struct.tnode* %9, null
  br i1 %10, label %11, label %19

; <label>:11:                                     ; preds = %8
  %12 = load %struct.tnode*, %struct.tnode** %6, align 8
  %13 = getelementptr inbounds %struct.tnode, %struct.tnode* %12, i32 0, i32 2
  %14 = load %struct.tnode*, %struct.tnode** %13, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = zext i8 %16 to i32
  %18 = icmp ne i32 %17, 4
  br label %19

; <label>:19:                                     ; preds = %11, %8
  %20 = phi i1 [ false, %8 ], [ %18, %11 ]
  br i1 %20, label %21, label %29

; <label>:21:                                     ; preds = %19
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.44, i32 0, i32 0))
  %23 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_debug_printNode(%struct.tnode* %23)
  %24 = load %struct.tnode*, %struct.tnode** %6, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 2
  %26 = load %struct.tnode*, %struct.tnode** %25, align 8
  store %struct.tnode* %26, %struct.tnode** %6, align 8
  %27 = load i32, i32* %5, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, i32* %5, align 4
  br label %8

; <label>:29:                                     ; preds = %19
  %30 = load %struct.tnode*, %struct.tnode** %6, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 2
  %32 = load %struct.tnode*, %struct.tnode** %31, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 3
  store i32 0, i32* %33, align 8
  %34 = load %struct.tnode*, %struct.tnode** %4, align 8
  %35 = load %struct.tnode*, %struct.tnode** %6, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 2
  store %struct.tnode* %34, %struct.tnode** %36, align 8
  %37 = load %struct.tnode*, %struct.tnode** %3, align 8
  call void @print_scalar(%struct.tnode* %37)
  %38 = load %struct.tnode*, %struct.tnode** %3, align 8
  ret %struct.tnode* %38
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define double @rand_double(double, double) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, double* %3, align 8
  store double %1, double* %4, align 8
  %5 = call i32 @rand()
  %6 = sitofp i32 %5 to double
  %7 = fdiv double %6, 0x41DFFFFFFFC00000
  %8 = load double, double* %4, align 8
  %9 = load double, double* %3, align 8
  %10 = fsub double %8, %9
  %11 = fmul double %7, %10
  %12 = load double, double* %3, align 8
  %13 = fadd double %11, %12
  ret double %13
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @initGarbageCollector() #0 {
  %1 = call i8* @malloc(i64 16) #5
  %2 = bitcast i8* %1 to %struct.gcNode*
  store %struct.gcNode* %2, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 0), align 8
  %3 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 0), align 8
  %4 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %3, i32 0, i32 0
  store %struct.tnode* null, %struct.tnode** %4, align 8
  %5 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 0), align 8
  %6 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %5, i32 0, i32 1
  store %struct.gcNode* null, %struct.gcNode** %6, align 8
  %7 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 0), align 8
  store %struct.gcNode* %7, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 1), align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @collectGarbage() #0 {
  %1 = alloca %struct.gcNode*, align 8
  %2 = alloca %struct.gcNode*, align 8
  %3 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 0), align 8
  store %struct.gcNode* %3, %struct.gcNode** %1, align 8
  %4 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 0), align 8
  %5 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %4, i32 0, i32 1
  %6 = load %struct.gcNode*, %struct.gcNode** %5, align 8
  store %struct.gcNode* %6, %struct.gcNode** %2, align 8
  br label %7

; <label>:7:                                      ; preds = %49, %0
  %8 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %9 = icmp ne %struct.gcNode* %8, null
  br i1 %9, label %10, label %15

; <label>:10:                                     ; preds = %7
  %11 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %12 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %11, i32 0, i32 1
  %13 = load %struct.gcNode*, %struct.gcNode** %12, align 8
  %14 = icmp ne %struct.gcNode* %13, null
  br label %15

; <label>:15:                                     ; preds = %10, %7
  %16 = phi i1 [ false, %7 ], [ %14, %10 ]
  br i1 %16, label %17, label %50

; <label>:17:                                     ; preds = %15
  %18 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %19 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %18, i32 0, i32 0
  %20 = load %struct.tnode*, %struct.tnode** %19, align 8
  %21 = icmp ne %struct.tnode* %20, null
  br i1 %21, label %22, label %44

; <label>:22:                                     ; preds = %17
  %23 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %24 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %23, i32 0, i32 0
  %25 = load %struct.tnode*, %struct.tnode** %24, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 3
  %27 = load i32, i32* %26, align 8
  %28 = icmp sle i32 %27, 0
  br i1 %28, label %29, label %44

; <label>:29:                                     ; preds = %22
  %30 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %31 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %30, i32 0, i32 0
  %32 = load %struct.tnode*, %struct.tnode** %31, align 8
  %33 = bitcast %struct.tnode* %32 to i8*
  call void @free(i8* %33)
  %34 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %35 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %34, i32 0, i32 1
  %36 = load %struct.gcNode*, %struct.gcNode** %35, align 8
  %37 = load %struct.gcNode*, %struct.gcNode** %1, align 8
  %38 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %37, i32 0, i32 1
  store %struct.gcNode* %36, %struct.gcNode** %38, align 8
  %39 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %40 = bitcast %struct.gcNode* %39 to i8*
  call void @free(i8* %40)
  %41 = load %struct.gcNode*, %struct.gcNode** %1, align 8
  %42 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %41, i32 0, i32 1
  %43 = load %struct.gcNode*, %struct.gcNode** %42, align 8
  store %struct.gcNode* %43, %struct.gcNode** %2, align 8
  br label %49

; <label>:44:                                     ; preds = %22, %17
  %45 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  store %struct.gcNode* %45, %struct.gcNode** %1, align 8
  %46 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %47 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %46, i32 0, i32 1
  %48 = load %struct.gcNode*, %struct.gcNode** %47, align 8
  store %struct.gcNode* %48, %struct.gcNode** %2, align 8
  br label %49

; <label>:49:                                     ; preds = %44, %29
  br label %7

; <label>:50:                                     ; preds = %15
  ret void
}

declare void @free(i8*) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @printCollectorStatus() #0 {
  %1 = alloca %struct.gcNode*, align 8
  %2 = alloca %struct.gcNode*, align 8
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.45, i32 0, i32 0))
  %5 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 0), align 8
  store %struct.gcNode* %5, %struct.gcNode** %1, align 8
  %6 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 0), align 8
  %7 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %6, i32 0, i32 1
  %8 = load %struct.gcNode*, %struct.gcNode** %7, align 8
  store %struct.gcNode* %8, %struct.gcNode** %2, align 8
  store i32 0, i32* %3, align 4
  br label %9

; <label>:9:                                      ; preds = %67, %0
  %10 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %11 = icmp ne %struct.gcNode* %10, null
  br i1 %11, label %12, label %17

; <label>:12:                                     ; preds = %9
  %13 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %14 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %13, i32 0, i32 1
  %15 = load %struct.gcNode*, %struct.gcNode** %14, align 8
  %16 = icmp ne %struct.gcNode* %15, null
  br label %17

; <label>:17:                                     ; preds = %12, %9
  %18 = phi i1 [ false, %9 ], [ %16, %12 ]
  br i1 %18, label %19, label %73

; <label>:19:                                     ; preds = %17
  %20 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %21 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %20, i32 0, i32 0
  %22 = load %struct.tnode*, %struct.tnode** %21, align 8
  %23 = icmp ne %struct.tnode* %22, null
  br i1 %23, label %24, label %65

; <label>:24:                                     ; preds = %19
  %25 = load i32, i32* %3, align 4
  %26 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %27 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %26, i32 0, i32 0
  %28 = load %struct.tnode*, %struct.tnode** %27, align 8
  %29 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %30 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %29, i32 0, i32 0
  %31 = load %struct.tnode*, %struct.tnode** %30, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 3
  %33 = load i32, i32* %32, align 8
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.46, i32 0, i32 0), i32 %25, %struct.tnode* %28, i32 %33)
  %35 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %36 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %35, i32 0, i32 0
  %37 = load %struct.tnode*, %struct.tnode** %36, align 8
  %38 = getelementptr inbounds %struct.tnode, %struct.tnode* %37, i32 0, i32 1
  %39 = getelementptr inbounds %struct.tdata, %struct.tdata* %38, i32 0, i32 0
  %40 = load i8, i8* %39, align 8
  %41 = zext i8 %40 to i32
  switch i32 %41, label %62 [
    i32 2, label %42
    i32 1, label %51
    i32 0, label %60
  ]

; <label>:42:                                     ; preds = %24
  %43 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %44 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %43, i32 0, i32 0
  %45 = load %struct.tnode*, %struct.tnode** %44, align 8
  %46 = getelementptr inbounds %struct.tnode, %struct.tnode* %45, i32 0, i32 1
  %47 = getelementptr inbounds %struct.tdata, %struct.tdata* %46, i32 0, i32 1
  %48 = bitcast %union.data_type* %47 to double*
  %49 = load double, double* %48, align 8
  %50 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.47, i32 0, i32 0), double %49)
  br label %64

; <label>:51:                                     ; preds = %24
  %52 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %53 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %52, i32 0, i32 0
  %54 = load %struct.tnode*, %struct.tnode** %53, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 1
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 1
  %57 = bitcast %union.data_type* %56 to i32*
  %58 = load i32, i32* %57, align 8
  %59 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.48, i32 0, i32 0), i32 %58)
  br label %64

; <label>:60:                                     ; preds = %24
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.49, i32 0, i32 0))
  br label %64

; <label>:62:                                     ; preds = %24
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.50, i32 0, i32 0))
  br label %64

; <label>:64:                                     ; preds = %62, %60, %51, %42
  br label %67

; <label>:65:                                     ; preds = %19
  %66 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.51, i32 0, i32 0))
  br label %67

; <label>:67:                                     ; preds = %65, %64
  %68 = load i32, i32* %3, align 4
  %69 = add nsw i32 %68, 1
  store i32 %69, i32* %3, align 4
  %70 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %71 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %70, i32 0, i32 1
  %72 = load %struct.gcNode*, %struct.gcNode** %71, align 8
  store %struct.gcNode* %72, %struct.gcNode** %2, align 8
  br label %9

; <label>:73:                                     ; preds = %17
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_exit() #0 {
  call void @collectGarbage()
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.52, i32 0, i32 0))
  call void @exit(i32 0) #6
  unreachable
                                                  ; No predecessors!
  ret void
}

; Function Attrs: noreturn
declare void @exit(i32) #4

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @createLhsStackVar(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = getelementptr inbounds %struct.tnode, %struct.tnode* %3, i32 0, i32 2
  store %struct.tnode* null, %struct.tnode** %4, align 8
  %5 = load %struct.tnode*, %struct.tnode** %2, align 8
  %6 = getelementptr inbounds %struct.tnode, %struct.tnode* %5, i32 0, i32 3
  store i32 0, i32* %6, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @markNodeForGarbageCollection(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  br label %3

; <label>:3:                                      ; preds = %6, %1
  %4 = load %struct.tnode*, %struct.tnode** %2, align 8
  %5 = icmp ne %struct.tnode* %4, null
  br i1 %5, label %6, label %12

; <label>:6:                                      ; preds = %3
  %7 = load %struct.tnode*, %struct.tnode** %2, align 8
  %8 = getelementptr inbounds %struct.tnode, %struct.tnode* %7, i32 0, i32 3
  store i32 0, i32* %8, align 8
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 2
  %11 = load %struct.tnode*, %struct.tnode** %10, align 8
  store %struct.tnode* %11, %struct.tnode** %2, align 8
  br label %3

; <label>:12:                                     ; preds = %3
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @registerHeapAllocation(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = getelementptr inbounds %struct.tnode, %struct.tnode* %3, i32 0, i32 3
  store i32 1, i32* %4, align 8
  %5 = call i8* @malloc(i64 16) #5
  %6 = bitcast i8* %5 to %struct.gcNode*
  %7 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 1), align 8
  %8 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %7, i32 0, i32 1
  store %struct.gcNode* %6, %struct.gcNode** %8, align 8
  %9 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 1), align 8
  %10 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %9, i32 0, i32 1
  %11 = load %struct.gcNode*, %struct.gcNode** %10, align 8
  store %struct.gcNode* %11, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 1), align 8
  %12 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 1), align 8
  %13 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %12, i32 0, i32 1
  store %struct.gcNode* null, %struct.gcNode** %13, align 8
  %14 = load %struct.tnode*, %struct.tnode** %2, align 8
  %15 = load %struct.gcNode*, %struct.gcNode** getelementptr inbounds (%struct.GC, %struct.GC* @gCollector, i32 0, i32 1), align 8
  %16 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %15, i32 0, i32 0
  store %struct.tnode* %14, %struct.tnode** %16, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tnode* @funk_mallocNodeRight(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  %3 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %4 = call i8* @malloc(i64 40) #5
  %5 = bitcast i8* %4 to %struct.tnode*
  store %struct.tnode* %5, %struct.tnode** %3, align 8
  %6 = load %struct.tnode*, %struct.tnode** %3, align 8
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %6, i32 0, i32 2
  store %struct.tnode* null, %struct.tnode** %7, align 8
  %8 = load %struct.tnode*, %struct.tnode** %3, align 8
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 2
  store %struct.tnode* %8, %struct.tnode** %10, align 8
  %11 = load %struct.tnode*, %struct.tnode** %2, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 0
  store i8 3, i8* %12, align 8
  %13 = load %struct.tnode*, %struct.tnode** %2, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = load %struct.tnode*, %struct.tnode** %3, align 8
  %18 = getelementptr inbounds %struct.tnode, %struct.tnode* %17, i32 0, i32 1
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 0
  store i8 %16, i8* %19, align 8
  %20 = load %struct.tnode*, %struct.tnode** %3, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 1
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 1
  %23 = bitcast %union.data_type* %22 to i32*
  store i32 -1, i32* %23, align 8
  %24 = load %struct.tnode*, %struct.tnode** %3, align 8
  %25 = getelementptr inbounds %struct.tnode, %struct.tnode* %24, i32 0, i32 0
  store i8 3, i8* %25, align 8
  %26 = load %struct.tnode*, %struct.tnode** %3, align 8
  ret %struct.tnode* %26
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_listFillerIota(%struct.tnode* noalias sret, i32) #0 {
  %3 = alloca i32, align 4
  store i32 %1, i32* %3, align 4
  %4 = getelementptr inbounds %struct.tnode, %struct.tnode* %0, i32 0, i32 1
  %5 = getelementptr inbounds %struct.tdata, %struct.tdata* %4, i32 0, i32 0
  store i8 1, i8* %5, align 8
  %6 = load i32, i32* %3, align 4
  %7 = getelementptr inbounds %struct.tnode, %struct.tnode* %0, i32 0, i32 1
  %8 = getelementptr inbounds %struct.tdata, %struct.tdata* %7, i32 0, i32 1
  %9 = bitcast %union.data_type* %8 to i32*
  store i32 %6, i32* %9, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tnode* @funk_CreateLinkedListConstInt(i32, i32, i32) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  store %struct.tnode* null, %struct.tnode** %7, align 8
  store %struct.tnode* null, %struct.tnode** %8, align 8
  store %struct.tnode* null, %struct.tnode** %9, align 8
  store i32 0, i32* %10, align 4
  %12 = load i32, i32* %4, align 4
  store i32 %12, i32* %10, align 4
  br label %13

; <label>:13:                                     ; preds = %41, %3
  %14 = load i32, i32* %10, align 4
  %15 = load i32, i32* %5, align 4
  %16 = icmp sle i32 %14, %15
  br i1 %16, label %17, label %44

; <label>:17:                                     ; preds = %13
  %18 = call i8* @malloc(i64 40) #5
  %19 = bitcast i8* %18 to %struct.tnode*
  store %struct.tnode* %19, %struct.tnode** %9, align 8
  %20 = load %struct.tnode*, %struct.tnode** %9, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 0
  store i8 3, i8* %21, align 8
  %22 = load %struct.tnode*, %struct.tnode** %9, align 8
  %23 = getelementptr inbounds %struct.tnode, %struct.tnode* %22, i32 0, i32 1
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 0
  store i8 1, i8* %24, align 8
  %25 = load i32, i32* %6, align 4
  %26 = load %struct.tnode*, %struct.tnode** %9, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 1
  %29 = bitcast %union.data_type* %28 to i32*
  store i32 %25, i32* %29, align 8
  %30 = load %struct.tnode*, %struct.tnode** %9, align 8
  call void @registerHeapAllocation(%struct.tnode* %30)
  %31 = load %struct.tnode*, %struct.tnode** %8, align 8
  %32 = icmp ne %struct.tnode* %31, null
  br i1 %32, label %33, label %37

; <label>:33:                                     ; preds = %17
  %34 = load %struct.tnode*, %struct.tnode** %9, align 8
  %35 = load %struct.tnode*, %struct.tnode** %8, align 8
  %36 = getelementptr inbounds %struct.tnode, %struct.tnode* %35, i32 0, i32 2
  store %struct.tnode* %34, %struct.tnode** %36, align 8
  br label %39

; <label>:37:                                     ; preds = %17
  %38 = load %struct.tnode*, %struct.tnode** %9, align 8
  store %struct.tnode* %38, %struct.tnode** %7, align 8
  br label %39

; <label>:39:                                     ; preds = %37, %33
  %40 = load %struct.tnode*, %struct.tnode** %9, align 8
  store %struct.tnode* %40, %struct.tnode** %8, align 8
  br label %41

; <label>:41:                                     ; preds = %39
  %42 = load i32, i32* %10, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, i32* %10, align 4
  br label %13

; <label>:44:                                     ; preds = %13
  %45 = call i8* @malloc(i64 40) #5
  %46 = bitcast i8* %45 to %struct.tnode*
  store %struct.tnode* %46, %struct.tnode** %11, align 8
  %47 = load %struct.tnode*, %struct.tnode** %11, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 0
  store i8 4, i8* %48, align 8
  %49 = load %struct.tnode*, %struct.tnode** %11, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 0
  store i8 4, i8* %51, align 8
  %52 = load %struct.tnode*, %struct.tnode** %9, align 8
  %53 = icmp ne %struct.tnode* %52, null
  br i1 %53, label %54, label %58

; <label>:54:                                     ; preds = %44
  %55 = load %struct.tnode*, %struct.tnode** %11, align 8
  %56 = load %struct.tnode*, %struct.tnode** %9, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 2
  store %struct.tnode* %55, %struct.tnode** %57, align 8
  br label %58

; <label>:58:                                     ; preds = %54, %44
  %59 = load %struct.tnode*, %struct.tnode** %7, align 8
  %60 = icmp eq %struct.tnode* %59, null
  br i1 %60, label %61, label %63

; <label>:61:                                     ; preds = %58
  %62 = load %struct.tnode*, %struct.tnode** %11, align 8
  store %struct.tnode* %62, %struct.tnode** %7, align 8
  br label %63

; <label>:63:                                     ; preds = %61, %58
  %64 = load %struct.tnode*, %struct.tnode** %11, align 8
  %65 = getelementptr inbounds %struct.tnode, %struct.tnode* %64, i32 0, i32 2
  store %struct.tnode* null, %struct.tnode** %65, align 8
  %66 = load i32, i32* %10, align 4
  %67 = load %struct.tnode*, %struct.tnode** %11, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 1
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 1
  %70 = bitcast %union.data_type* %69 to i32*
  store i32 %66, i32* %70, align 8
  %71 = load %struct.tnode*, %struct.tnode** %7, align 8
  ret %struct.tnode* %71
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define %struct.tnode* @createLinkedList(i32, i32, i8 zeroext) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i8, align 1
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca %struct.tnode*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tnode*, align 8
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store i8 %2, i8* %6, align 1
  store %struct.tnode* null, %struct.tnode** %7, align 8
  store %struct.tnode* null, %struct.tnode** %8, align 8
  store %struct.tnode* null, %struct.tnode** %9, align 8
  store i32 0, i32* %10, align 4
  %12 = load i32, i32* %4, align 4
  store i32 %12, i32* %10, align 4
  br label %13

; <label>:13:                                     ; preds = %42, %3
  %14 = load i32, i32* %10, align 4
  %15 = load i32, i32* %5, align 4
  %16 = icmp sle i32 %14, %15
  br i1 %16, label %17, label %45

; <label>:17:                                     ; preds = %13
  %18 = call i8* @malloc(i64 40) #5
  %19 = bitcast i8* %18 to %struct.tnode*
  store %struct.tnode* %19, %struct.tnode** %9, align 8
  %20 = load %struct.tnode*, %struct.tnode** %9, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 0
  store i8 3, i8* %21, align 8
  %22 = load i8, i8* %6, align 1
  %23 = load %struct.tnode*, %struct.tnode** %9, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 0
  store i8 %22, i8* %25, align 8
  %26 = load i32, i32* %10, align 4
  %27 = load %struct.tnode*, %struct.tnode** %9, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 1
  %30 = bitcast %union.data_type* %29 to i32*
  store i32 %26, i32* %30, align 8
  %31 = load %struct.tnode*, %struct.tnode** %9, align 8
  call void @registerHeapAllocation(%struct.tnode* %31)
  %32 = load %struct.tnode*, %struct.tnode** %8, align 8
  %33 = icmp ne %struct.tnode* %32, null
  br i1 %33, label %34, label %38

; <label>:34:                                     ; preds = %17
  %35 = load %struct.tnode*, %struct.tnode** %9, align 8
  %36 = load %struct.tnode*, %struct.tnode** %8, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 2
  store %struct.tnode* %35, %struct.tnode** %37, align 8
  br label %40

; <label>:38:                                     ; preds = %17
  %39 = load %struct.tnode*, %struct.tnode** %9, align 8
  store %struct.tnode* %39, %struct.tnode** %7, align 8
  br label %40

; <label>:40:                                     ; preds = %38, %34
  %41 = load %struct.tnode*, %struct.tnode** %9, align 8
  store %struct.tnode* %41, %struct.tnode** %8, align 8
  br label %42

; <label>:42:                                     ; preds = %40
  %43 = load i32, i32* %10, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, i32* %10, align 4
  br label %13

; <label>:45:                                     ; preds = %13
  %46 = call i8* @malloc(i64 40) #5
  %47 = bitcast i8* %46 to %struct.tnode*
  store %struct.tnode* %47, %struct.tnode** %11, align 8
  %48 = load %struct.tnode*, %struct.tnode** %11, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 0
  store i8 4, i8* %49, align 8
  %50 = load i8, i8* %6, align 1
  %51 = load %struct.tnode*, %struct.tnode** %11, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 1
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 0
  store i8 %50, i8* %53, align 8
  %54 = load %struct.tnode*, %struct.tnode** %9, align 8
  %55 = icmp ne %struct.tnode* %54, null
  br i1 %55, label %56, label %60

; <label>:56:                                     ; preds = %45
  %57 = load %struct.tnode*, %struct.tnode** %11, align 8
  %58 = load %struct.tnode*, %struct.tnode** %9, align 8
  %59 = getelementptr inbounds %struct.tnode, %struct.tnode* %58, i32 0, i32 2
  store %struct.tnode* %57, %struct.tnode** %59, align 8
  br label %60

; <label>:60:                                     ; preds = %56, %45
  %61 = load %struct.tnode*, %struct.tnode** %7, align 8
  %62 = icmp eq %struct.tnode* %61, null
  br i1 %62, label %63, label %65

; <label>:63:                                     ; preds = %60
  %64 = load %struct.tnode*, %struct.tnode** %11, align 8
  store %struct.tnode* %64, %struct.tnode** %7, align 8
  br label %65

; <label>:65:                                     ; preds = %63, %60
  %66 = load %struct.tnode*, %struct.tnode** %11, align 8
  %67 = getelementptr inbounds %struct.tnode, %struct.tnode* %66, i32 0, i32 2
  store %struct.tnode* null, %struct.tnode** %67, align 8
  %68 = load i32, i32* %10, align 4
  %69 = load %struct.tnode*, %struct.tnode** %11, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 1
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %70, i32 0, i32 1
  %72 = bitcast %union.data_type* %71 to i32*
  store i32 %68, i32* %72, align 8
  %73 = load %struct.tnode*, %struct.tnode** %7, align 8
  ret %struct.tnode* %73
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

; <label>:10:                                     ; preds = %35, %4
  %11 = load i32, i32* %9, align 4
  %12 = load i32, i32* %7, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %38

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
  call void @memcpy(i8* align 8 %23, i8* align 8 %24, i64 40, i1 false)
  %25 = load i8, i8* %8, align 1
  %26 = zext i8 %25 to i32
  %27 = icmp eq i32 %26, 1
  br i1 %27, label %28, label %34

; <label>:28:                                     ; preds = %14
  %29 = load %struct.tnode*, %struct.tnode** %5, align 8
  %30 = load i32, i32* %9, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i64 %31
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 3
  store i32 -1, i32* %33, align 8
  br label %34

; <label>:34:                                     ; preds = %28, %14
  br label %35

; <label>:35:                                     ; preds = %34
  %36 = load i32, i32* %9, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %9, align 4
  br label %10

; <label>:38:                                     ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define float @funk_ToFloat(%struct.tnode*) #0 {
  %2 = alloca float, align 4
  %3 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  %4 = load %struct.tnode*, %struct.tnode** %3, align 8
  %5 = getelementptr inbounds %struct.tnode, %struct.tnode* %4, i32 0, i32 1
  %6 = getelementptr inbounds %struct.tdata, %struct.tdata* %5, i32 0, i32 0
  %7 = load i8, i8* %6, align 8
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %17

; <label>:10:                                     ; preds = %1
  %11 = load %struct.tnode*, %struct.tnode** %3, align 8
  %12 = getelementptr inbounds %struct.tnode, %struct.tnode* %11, i32 0, i32 1
  %13 = getelementptr inbounds %struct.tdata, %struct.tdata* %12, i32 0, i32 1
  %14 = bitcast %union.data_type* %13 to i32*
  %15 = load i32, i32* %14, align 8
  %16 = sitofp i32 %15 to float
  store float %16, float* %2, align 4
  br label %35

; <label>:17:                                     ; preds = %1
  %18 = load %struct.tnode*, %struct.tnode** %3, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 1
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = zext i8 %21 to i32
  %23 = icmp eq i32 %22, 2
  br i1 %23, label %24, label %31

; <label>:24:                                     ; preds = %17
  %25 = load %struct.tnode*, %struct.tnode** %3, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
  %28 = bitcast %union.data_type* %27 to double*
  %29 = load double, double* %28, align 8
  %30 = fptrunc double %29 to float
  store float %30, float* %2, align 4
  br label %35

; <label>:31:                                     ; preds = %17
  %32 = load %struct.tnode*, %struct.tnode** %3, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 0
  store i8 0, i8* %34, align 8
  store float 0.000000e+00, float* %2, align 4
  br label %35

; <label>:35:                                     ; preds = %31, %24, %10
  %36 = load float, float* %2, align 4
  ret float %36
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { allocsize(0) }
attributes #6 = { noreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 14]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"Apple LLVM version 10.0.1 (clang-1001.0.46.4)"}
