
;; =============================================================== ;;
;; Main data type representation

;; Since Funk supports runtime types, then a union is used
;; to store the types. Recall that there are really no unions
;; in LLVM, rather the size of the biggest data type is used and
;; then the appropiate bitcast is used to inform the compiler about
;; the corresponding data type for a given symbol

%union.data_type = type { {}* }

;; This a primitive data type. It contains a type tag (i8) followed by
;; the actual data represented as a union

%struct.tdata = type { i8, %union.data_type }

;; These are nodes of a linked list. These are used to present lists
;; as well are function arguments (which are essentially lists)

%struct.tnode = type { i8, %struct.tdata, %struct.tnode* }

;; ===  Global Funk definitions ===

@.str_DISP_INT = private unnamed_addr constant [3 x i8] c"%i ", align 1
@.str_DISP_FLOAT = private unnamed_addr constant [3 x i8] c"%f ", align 1
@.str_DISP_EOL = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

@.str_ERR_ARITH_TYPE = private unnamed_addr constant [36 x i8] c"-E- Unsupported Arithmetic Type %i\0A\00", align 1
@.str_ERR_PRINT_TYPE = private unnamed_addr constant [33 x i8] c"-E- Unsupported Print Type   %i\0A\00", align 1


; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; declare stardard printf binding
declare i32 @printf(i8*, ...) #1

; declare standard C rand binding
declare i32 @rand() #1

declare void @srand(i32) #1
declare i64 @time(i64*) #1

;; ==== Funk internal functions =======

;;===== printing ====
; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_scalar(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = getelementptr inbounds %struct.tnode, %struct.tnode* %3, i32 0, i32 1
  %5 = getelementptr inbounds %struct.tdata, %struct.tdata* %4, i32 0, i32 0
  %6 = load i8, i8* %5, align 8
  %7 = zext i8 %6 to i32
  switch i32 %7, label %23 [
    i32 1, label %8
    i32 2, label %15
  ]

; <label>:8:                                      ; preds = %1
  %9 = load %struct.tnode*, %struct.tnode** %2, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 1
  %12 = bitcast %union.data_type* %11 to i32*
  %13 = load i32, i32* %12, align 8
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str_DISP_INT, i32 0, i32 0), i32 %13)
  br label %25

; <label>:15:                                     ; preds = %1
  %16 = load %struct.tnode*, %struct.tnode** %2, align 8
  %17 = getelementptr inbounds %struct.tnode, %struct.tnode* %16, i32 0, i32 1
  %18 = getelementptr inbounds %struct.tdata, %struct.tdata* %17, i32 0, i32 1
  %19 = bitcast %union.data_type* %18 to double*
  %20 = load double, double* %19, align 8
  %21 = add i1 0, 0  ;; %21 = fpext double %20 to double
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str_DISP_FLOAT, i32 0, i32 0), double %20)
  br label %25

; <label>:23:                                     ; preds = %1
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str_ERR_PRINT_TYPE, i32 0, i32 0), i32 %7)
  br label %25

; <label>:25:                                     ; preds = %23, %15, %8
  ret void
}


;;======== Arithmetic functions ====

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i8, align 1
  %8 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %9 = load %struct.tnode*, %struct.tnode** %5, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 0
  %12 = load i8, i8* %11, align 8
  store i8 %12, i8* %7, align 1
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  store i8 %16, i8* %8, align 1
  %17 = load i8, i8* %7, align 1
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 1
  br i1 %19, label %20, label %43

; <label>:20:                                     ; preds = %3
  %21 = load i8, i8* %8, align 1
  %22 = zext i8 %21 to i32
  %23 = icmp eq i32 %22, 1
  br i1 %23, label %24, label %43

; <label>:24:                                     ; preds = %20
  %25 = load %struct.tnode*, %struct.tnode** %5, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
  %28 = bitcast %union.data_type* %27 to i32*
  %29 = load i32, i32* %28, align 8
  %30 = load %struct.tnode*, %struct.tnode** %6, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 1
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 1
  %33 = bitcast %union.data_type* %32 to i32*
  %34 = load i32, i32* %33, align 8
  %35 = add i32 %29, %34
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 1
  %39 = bitcast %union.data_type* %38 to i32*
  store i32 %35, i32* %39, align 8
  %40 = load %struct.tnode*, %struct.tnode** %4, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 1
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  store i8 1, i8* %42, align 8
  br label %77

; <label>:43:                                     ; preds = %20, %3
  %44 = load i8, i8* %7, align 1
  %45 = zext i8 %44 to i32
  %46 = icmp eq i32 %45, 2
  br i1 %46, label %47, label %70

; <label>:47:                                     ; preds = %43
  %48 = load i8, i8* %8, align 1
  %49 = zext i8 %48 to i32
  %50 = icmp eq i32 %49, 2
  br i1 %50, label %51, label %70

; <label>:51:                                     ; preds = %47
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 1
  %55 = bitcast %union.data_type* %54 to double*
  %56 = load double, double* %55, align 8
  %57 = load %struct.tnode*, %struct.tnode** %6, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 1
  %59 = getelementptr inbounds %struct.tdata, %struct.tdata* %58, i32 0, i32 1
  %60 = bitcast %union.data_type* %59 to double*
  %61 = load double, double* %60, align 8
  %62 = fadd double %56, %61
  %63 = load %struct.tnode*, %struct.tnode** %4, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 1
  %65 = getelementptr inbounds %struct.tdata, %struct.tdata* %64, i32 0, i32 1
  %66 = bitcast %union.data_type* %65 to double*
  store double %62, double* %66, align 8
  %67 = load %struct.tnode*, %struct.tnode** %4, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 1
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 0
  store i8 2, i8* %69, align 8
  br label %76

; <label>:70:                                     ; preds = %47, %43
  %71 = load i8, i8* %7, align 1
  %72 = zext i8 %71 to i32
  %73 = load i8, i8* %8, align 1
  %74 = zext i8 %73 to i32
  %75 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str_ERR_ARITH_TYPE, i32 0, i32 0), i32 %72)
  br label %76

; <label>:76:                                     ; preds = %70, %51
  br label %77

; <label>:77:                                     ; preds = %76, %24
  ret void
}




; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca i8, align 1
  %8 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %9 = load %struct.tnode*, %struct.tnode** %5, align 8
  %10 = getelementptr inbounds %struct.tnode, %struct.tnode* %9, i32 0, i32 1
  %11 = getelementptr inbounds %struct.tdata, %struct.tdata* %10, i32 0, i32 0
  %12 = load i8, i8* %11, align 8
  store i8 %12, i8* %7, align 1
  %13 = load %struct.tnode*, %struct.tnode** %6, align 8
  %14 = getelementptr inbounds %struct.tnode, %struct.tnode* %13, i32 0, i32 1
  %15 = getelementptr inbounds %struct.tdata, %struct.tdata* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  store i8 %16, i8* %8, align 1
  %17 = load i8, i8* %7, align 1
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 1
  br i1 %19, label %20, label %43

; <label>:20:                                     ; preds = %3
  %21 = load i8, i8* %8, align 1
  %22 = zext i8 %21 to i32
  %23 = icmp eq i32 %22, 1
  br i1 %23, label %24, label %43

; <label>:24:                                     ; preds = %20
  %25 = load %struct.tnode*, %struct.tnode** %5, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
  %28 = bitcast %union.data_type* %27 to i32*
  %29 = load i32, i32* %28, align 8
  %30 = load %struct.tnode*, %struct.tnode** %6, align 8
  %31 = getelementptr inbounds %struct.tnode, %struct.tnode* %30, i32 0, i32 1
  %32 = getelementptr inbounds %struct.tdata, %struct.tdata* %31, i32 0, i32 1
  %33 = bitcast %union.data_type* %32 to i32*
  %34 = load i32, i32* %33, align 8
  %35 = sub i32 %29, %34
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 1
  %39 = bitcast %union.data_type* %38 to i32*
  store i32 %35, i32* %39, align 8
  %40 = load %struct.tnode*, %struct.tnode** %4, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 1
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  store i8 1, i8* %42, align 8
  br label %77

; <label>:43:                                     ; preds = %20, %3
  %44 = load i8, i8* %7, align 1
  %45 = zext i8 %44 to i32
  %46 = icmp eq i32 %45, 2
  br i1 %46, label %47, label %70

; <label>:47:                                     ; preds = %43
  %48 = load i8, i8* %8, align 1
  %49 = zext i8 %48 to i32
  %50 = icmp eq i32 %49, 2
  br i1 %50, label %51, label %70

; <label>:51:                                     ; preds = %47
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 1
  %55 = bitcast %union.data_type* %54 to double*
  %56 = load double, double* %55, align 8
  %57 = load %struct.tnode*, %struct.tnode** %6, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 1
  %59 = getelementptr inbounds %struct.tdata, %struct.tdata* %58, i32 0, i32 1
  %60 = bitcast %union.data_type* %59 to double*
  %61 = load double, double* %60, align 8
  %62 = fsub double %56, %61
  %63 = load %struct.tnode*, %struct.tnode** %4, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 1
  %65 = getelementptr inbounds %struct.tdata, %struct.tdata* %64, i32 0, i32 1
  %66 = bitcast %union.data_type* %65 to double*
  store double %62, double* %66, align 8
  %67 = load %struct.tnode*, %struct.tnode** %4, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 1
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 0
  store i8 2, i8* %69, align 8
  br label %76

; <label>:70:                                     ; preds = %47, %43
  %71 = load i8, i8* %7, align 1
  %72 = zext i8 %71 to i32
  %73 = load i8, i8* %8, align 1
  %74 = zext i8 %73 to i32
  %75 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str_ERR_ARITH_TYPE, i32 0, i32 0), i32 %72)
  br label %76

; <label>:76:                                     ; preds = %70, %51
  br label %77

; <label>:77:                                     ; preds = %76, %24
  ret void
}

define void @funk_mul_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 4
  %7 = load double, double* %6, align 4
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 1
  %11 = bitcast %union.data_type* %10 to double*
  %12 = load double, double* %11, align 4
  %13 = fmul double %7, %12
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  store double %13, double* %17, align 4
  %18 = load %struct.tnode*, %struct.tnode** %4, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 1
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 0
  store i8 2, i8* %20, align 4
  ret void
}


define void @funk_add_rf(%struct.tnode*, %struct.tnode*, double) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca double, align 4
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store double %2, double* %6, align 4
  %7 = load double, double* %6, align 4
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 1
  %11 = bitcast %union.data_type* %10 to double*
  %12 = load double, double* %11, align 4
  %13 = fadd double %7, %12
  %14 = load %struct.tnode*, %struct.tnode** %4, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  store double %13, double* %17, align 4
  %18 = load %struct.tnode*, %struct.tnode** %4, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 1
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 0
  store i8 2, i8* %20, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 0
  %11 = load i8, i8* %10, align 8
  store i8 %11, i8* %7, align 1
  %12 = load i8, i8* %7, align 1
  %13 = zext i8 %12 to i32
  %14 = icmp ne i32 %13, 1
  br i1 %14, label %15, label %17

; <label>:15:                                     ; preds = %3
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str_ERR_ARITH_TYPE, i32 0, i32 0), i32 %13, i32 1)
  br label %32

; <label>:17:                                     ; preds = %3
  %18 = load %struct.tnode*, %struct.tnode** %5, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 1
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 1
  %21 = bitcast %union.data_type* %20 to i32*
  %22 = load i32, i32* %21, align 8
  %23 = load i32, i32* %6, align 4
  %24 = add i32 %22, %23
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
  %28 = bitcast %union.data_type* %27 to i32*
  store i32 %24, i32* %28, align 8
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  store i8 1, i8* %31, align 8
  br label %32

; <label>:32:                                     ; preds = %17, %15
  ret void
}


; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_ri(%struct.tnode*, %struct.tnode*, i32) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store i32 %2, i32* %6, align 4
  %8 = load %struct.tnode*, %struct.tnode** %5, align 8
  %9 = getelementptr inbounds %struct.tnode, %struct.tnode* %8, i32 0, i32 1
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 0
  %11 = load i8, i8* %10, align 8
  store i8 %11, i8* %7, align 1
  %12 = load i8, i8* %7, align 1
  %13 = zext i8 %12 to i32
  %14 = icmp ne i32 %13, 1
  br i1 %14, label %15, label %17

; <label>:15:                                     ; preds = %3
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str_ERR_ARITH_TYPE, i32 0, i32 0), i32 %13, i32 1)
  br label %32

; <label>:17:                                     ; preds = %3
  %18 = load %struct.tnode*, %struct.tnode** %5, align 8
  %19 = getelementptr inbounds %struct.tnode, %struct.tnode* %18, i32 0, i32 1
  %20 = getelementptr inbounds %struct.tdata, %struct.tdata* %19, i32 0, i32 1
  %21 = bitcast %union.data_type* %20 to i32*
  %22 = load i32, i32* %21, align 8
  %23 = load i32, i32* %6, align 4
  %24 = sub i32 %22, %23
  %25 = load %struct.tnode*, %struct.tnode** %4, align 8
  %26 = getelementptr inbounds %struct.tnode, %struct.tnode* %25, i32 0, i32 1
  %27 = getelementptr inbounds %struct.tdata, %struct.tdata* %26, i32 0, i32 1
  %28 = bitcast %union.data_type* %27 to i32*
  store i32 %24, i32* %28, align 8
  %29 = load %struct.tnode*, %struct.tnode** %4, align 8
  %30 = getelementptr inbounds %struct.tnode, %struct.tnode* %29, i32 0, i32 1
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  store i8 1, i8* %31, align 8
  br label %32

; <label>:32:                                     ; preds = %17, %15
  ret void
}



; ===== simple random number generator

define i32 @rand_int(i32, i32) #0 {
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


; Function Attrs: noinline nounwind optnone ssp uwtable
define void @init_random_seed() #0 {
  %1 = call i64 @time(i64* null)
  %2 = trunc i64 %1 to i32
  call void @srand(i32 %2)
  ret void
}

define double @rand_double(double, double) #0 {
  %3 = alloca double, align 4
  %4 = alloca double, align 4
  store double %0, double* %3, align 4
  store double %1, double* %4, align 4
  %5 = call i32 @rand()
  %6 = sitofp i32 %5 to double
  %7 = fdiv double %6, 0x41E0000000000000
  %8 = load double, double* %4, align 4
  %9 = fmul double %7, %8
  %10 = load double, double* %3, align 4
  %11 = fadd double %9, %10
  ret double %11
}