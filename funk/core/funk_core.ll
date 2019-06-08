
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
;; the last i32 is the reference count used when allocating objects
;; in the heap

%struct.tnode = type { i8, %struct.tdata, %struct.tnode*, i32 }


;; === Global Variables ===
;; The garbage collector global instance


%struct.GC = type { %struct.gcNode*, %struct.gcNode* }
%struct.gcNode = type { %struct.tnode*, %struct.gcNode* }
@gCollector = common global %struct.GC zeroinitializer, align 8

;; ===  Global Funk definitions ===

@.str_DISP_INT = private unnamed_addr constant [3 x i8] c"%i ", align 1
@.str_DISP_FLOAT = private unnamed_addr constant [3 x i8] c"%f ", align 1
@.str_DISP_EOL = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

@.str_ERR_ARITH_TYPE = private unnamed_addr constant [36 x i8] c"-E- Unsupported Arithmetic Type %i\0A\00", align 1
@.str_ERR_PRINT_TYPE = private unnamed_addr constant [33 x i8] c"-E- Unsupported Print Type   %i\0A\00", align 1
@.str.2 = private unnamed_addr constant [17 x i8] c"start %d end %d\0A\00", align 1
; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; declare stardard printf binding
declare i32 @printf(i8*, ...) #1

; declare standard C rand binding
declare i32 @rand() #1

declare void @srand(i32) #1
declare i64 @time(i64*) #1


; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2


declare void @free(i8*) #1



;; ==== Funk internal functions =======


;;===== Garbage collector Functions =====

; Function Attrs: noinline nounwind optnone ssp uwtable

;; void initGarbageCollector( void ){
;;  gCollector.head = (struct gcNode*)malloc(sizeof(struct gcNode));
;;  gCollector.head->ptr = NULL;
;;  gCollector.head->next = NULL;
;;  gCollector.tail = gCollector.head;
;; };

define void @initGarbageCollector() #0 {
  %1 = call i8* @malloc(i64 16) #3
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


; void collectGarbage( void ){
;
;
;  struct gcNode * prev = gCollector.head;
;  struct gcNode * p = gCollector.head->next;
;
;  while (p->next){
;    if (p->ptr && p->ptr->refCount <= 0){
;      free(p->ptr);
;      prev->next = p->next;
;      free(p);
;      p = prev->next;
;    } else {
;      prev = p;
;      p = p->next;
;    }
;  }
;}
;


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

; <label>:7:                                      ; preds = %44, %0
  %8 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %9 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %8, i32 0, i32 1
  %10 = load %struct.gcNode*, %struct.gcNode** %9, align 8
  %11 = icmp ne %struct.gcNode* %10, null
  br i1 %11, label %12, label %45

; <label>:12:                                     ; preds = %7
  %13 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %14 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %13, i32 0, i32 0
  %15 = load %struct.tnode*, %struct.tnode** %14, align 8
  %16 = icmp ne %struct.tnode* %15, null
  br i1 %16, label %17, label %39

; <label>:17:                                     ; preds = %12
  %18 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %19 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %18, i32 0, i32 0
  %20 = load %struct.tnode*, %struct.tnode** %19, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 3
  %22 = load i32, i32* %21, align 8
  %23 = icmp sle i32 %22, 0
  br i1 %23, label %24, label %39

; <label>:24:                                     ; preds = %17
  %25 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %26 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %25, i32 0, i32 0
  %27 = load %struct.tnode*, %struct.tnode** %26, align 8
  %28 = bitcast %struct.tnode* %27 to i8*
  call void @free(i8* %28)
  %29 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %30 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %29, i32 0, i32 1
  %31 = load %struct.gcNode*, %struct.gcNode** %30, align 8
  %32 = load %struct.gcNode*, %struct.gcNode** %1, align 8
  %33 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %32, i32 0, i32 1
  store %struct.gcNode* %31, %struct.gcNode** %33, align 8
  %34 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %35 = bitcast %struct.gcNode* %34 to i8*
  call void @free(i8* %35)
  %36 = load %struct.gcNode*, %struct.gcNode** %1, align 8
  %37 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %36, i32 0, i32 1
  %38 = load %struct.gcNode*, %struct.gcNode** %37, align 8
  store %struct.gcNode* %38, %struct.gcNode** %2, align 8
  br label %44

; <label>:39:                                     ; preds = %17, %12
  %40 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  store %struct.gcNode* %40, %struct.gcNode** %1, align 8
  %41 = load %struct.gcNode*, %struct.gcNode** %2, align 8
  %42 = getelementptr inbounds %struct.gcNode, %struct.gcNode* %41, i32 0, i32 1
  %43 = load %struct.gcNode*, %struct.gcNode** %42, align 8
  store %struct.gcNode* %43, %struct.gcNode** %2, align 8
  br label %44

; <label>:44:                                     ; preds = %39, %24
  br label %7

; <label>:45:                                     ; preds = %7
  ret void
}



;void registerHeapAllocation(struct tnode * n){
;  n->refCount = 1;
;  gCollector.tail->next = (struct gcNode*)malloc(sizeof(struct gcNode));
;  gCollector.tail = gCollector.tail->next;
;  gCollector.tail->next = NULL;
;  gCollector.tail->ptr = n;
;
;
;}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @registerHeapAllocation(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = getelementptr inbounds %struct.tnode, %struct.tnode* %3, i32 0, i32 3
  store i32 1, i32* %4, align 8
  %5 = call i8* @malloc(i64 16) #3
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


;
;void funk_mod_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
;  if (n1->pd.type == 2 && n2->pd.type == 2){
;      r->pd.data.f = n1->pd.data.f % n2->pd.data.f;
;      r->pd.type = 2;
;  } else if (n1->pd.type == 1 && n2->pd.type == 1){
;    r->pd.data.i = n1->pd.data.i % n2->pd.data.i;
;    r->pd.type = 1;
;  } else if (n1->pd.type == 2 && n2->pd.type == 1){
;    r->pd.data.f = n1->pd.data.f % ((double)(n2->pd.data.i));
;    r->pd.type = 2;
;  } else if (n1->pd.type == 1 && n2->pd.type == 2){
;    r->pd.data.f = ((double)n1->pd.data.i) % n2->pd.data.f;
;    r->pd.type = 2;
;  } else {
;    //Invalid data
;    r->pd.type = 0;
;  }
;
;}


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
  br label %150

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
  br label %149

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
  br label %148

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
  br label %147

; <label>:143:                                    ; preds = %115, %108
  %144 = load %struct.tnode*, %struct.tnode** %4, align 8
  %145 = getelementptr inbounds %struct.tnode, %struct.tnode* %144, i32 0, i32 1
  %146 = getelementptr inbounds %struct.tdata, %struct.tdata* %145, i32 0, i32 0
  store i8 0, i8* %146, align 8
  br label %147

; <label>:147:                                    ; preds = %143, %122
  br label %148

; <label>:148:                                    ; preds = %147, %88
  br label %149

; <label>:149:                                    ; preds = %148, %55
  br label %150

; <label>:150:                                    ; preds = %149, %20
  ret void
}

;
;void funk_div_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
;  if (n1->pd.type == 2 && n2->pd.type == 2){
;      r->pd.data.f = n1->pd.data.f / n2->pd.data.f;
;      r->pd.type = 2;
;  } else if (n1->pd.type == 1 && n2->pd.type == 1){
;    r->pd.data.i = n1->pd.data.i / n2->pd.data.i;
;    r->pd.type = 1;
;  } else if (n1->pd.type == 2 && n2->pd.type == 1){
;    r->pd.data.f = n1->pd.data.f / ((double)(n2->pd.data.i));
;    r->pd.type = 2;
;  } else if (n1->pd.type == 1 && n2->pd.type == 2){
;    r->pd.data.f = ((double)n1->pd.data.i) / n2->pd.data.f;
;    r->pd.type = 2;
;  } else {
;    //Invalid data
;    r->pd.type = 0;
;  }
;
;}

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
  br label %147

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
  br label %146

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
  br label %145

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
  br label %144

; <label>:140:                                    ; preds = %113, %106
  %141 = load %struct.tnode*, %struct.tnode** %4, align 8
  %142 = getelementptr inbounds %struct.tnode, %struct.tnode* %141, i32 0, i32 1
  %143 = getelementptr inbounds %struct.tdata, %struct.tdata* %142, i32 0, i32 0
  store i8 0, i8* %143, align 8
  br label %144

; <label>:144:                                    ; preds = %140, %120
  br label %145

; <label>:145:                                    ; preds = %144, %86
  br label %146

; <label>:146:                                    ; preds = %145, %53
  br label %147

; <label>:147:                                    ; preds = %146, %20
  ret void
}

;
;struct tnode * createLinkedList(int start, int end, unsigned char type ){
;   struct tnode * head = NULL;
;   struct tnode * prev = NULL;
;   struct tnode * node = NULL;
;
;  int i = 0;
;  for (i = start; i <= end; ++i){
;    node = (struct tnode*)malloc(sizeof(struct tnode));
;    node->type = 3; //List Node
;    node->pd.type = type;
;    node->pd.data.i = i;
;    registerHeapAllocation(node);
;
;    if (prev){
;        prev->next = node;
;    } else {
;      head = node;
;    }
;    prev = node;
;  }
;
;   struct tnode * tail = (struct tnode*)malloc(sizeof(struct tnode));
;   tail->type = 4; //empty_array
;   tail->pd.type = type;
;
;   if (node != NULL)
;      node->next = tail;
;
;   if (head == NULL)
;      head = tail;
;
;   tail->next = NULL;
;   tail->pd.data.i = i;
;   return head;
;}

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
  %18 = call i8* @malloc(i64 32) #3
  %19 = bitcast i8* %18 to %struct.tnode*
  store %struct.tnode* %19, %struct.tnode** %9, align 8
  %20 = load %struct.tnode*, %struct.tnode** %9, align 8
  %21 = getelementptr inbounds %struct.tnode, %struct.tnode* %20, i32 0, i32 0
  store i8 3, i8* %21, align 8
  %22 = load i8, i8* %6, align 1
  %23 = load %struct.tnode*, %struct.tnode** %9, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 0
  store i8 %22, i8* %25, align 4
  %26 = load i32, i32* %10, align 4
  %27 = load %struct.tnode*, %struct.tnode** %9, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 1
  %30 = bitcast %union.data_type* %29 to i32*
  store i32 %26, i32* %30, align 4
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
  %46 = call i8* @malloc(i64 32) #3
  %47 = bitcast i8* %46 to %struct.tnode*
  store %struct.tnode* %47, %struct.tnode** %11, align 8
  %48 = load %struct.tnode*, %struct.tnode** %11, align 8
  %49 = getelementptr inbounds %struct.tnode, %struct.tnode* %48, i32 0, i32 0
  store i8 4, i8* %49, align 8
  %50 = load i8, i8* %6, align 1
  %51 = load %struct.tnode*, %struct.tnode** %11, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 1
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 0
  store i8 %50, i8* %53, align 4
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
  store i32 %68, i32* %72, align 4
  %73 = load %struct.tnode*, %struct.tnode** %7, align 8
  ret %struct.tnode* %73
}


; void createLhsStackVar(struct tnode * p){
;  p->next = NULL;
;  p->refCount = 0;
;}


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
    i32 4, label %25
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
;void funk_add_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
;  if (n1->pd.type == 2 && n2->pd.type == 2){
;      r->pd.data.f = n1->pd.data.f + n2->pd.data.f;
;      r->pd.type = 2;
;  } else if (n1->pd.type == 1 && n2->pd.type == 1){
;    r->pd.data.i = n1->pd.data.i + n2->pd.data.i;
;    r->pd.type = 1;
;  } else if (n1->pd.type == 2 && n2->pd.type == 1){
;    r->pd.data.f = n1->pd.data.f + ((double)(n2->pd.data.i));
;    r->pd.type = 2;
;  } else if (n1->pd.type == 1 && n2->pd.type == 2){
;    r->pd.data.f = ((double)n1->pd.data.i) + n2->pd.data.f;
;    r->pd.type = 2;
;  } else {
;    //Invalid data
;    r->pd.type = 0;
;  }
;
;}


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
  br label %147

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
  br label %146

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
  br label %145

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
  br label %144

; <label>:140:                                    ; preds = %113, %106
  %141 = load %struct.tnode*, %struct.tnode** %4, align 8
  %142 = getelementptr inbounds %struct.tnode, %struct.tnode* %141, i32 0, i32 1
  %143 = getelementptr inbounds %struct.tdata, %struct.tdata* %142, i32 0, i32 0
  store i8 0, i8* %143, align 8
  br label %144

; <label>:144:                                    ; preds = %140, %120
  br label %145

; <label>:145:                                    ; preds = %144, %86
  br label %146

; <label>:146:                                    ; preds = %145, %53
  br label %147

; <label>:147:                                    ; preds = %146, %20
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



;
;void funk_flt_rf(struct tnode * r, struct tnode * n1, double lit){
;  if (n1->pd.type == 2){
;      r->pd.data.i = (n1->pd.data.f < lit) ? 1 : 0;
;      r->pd.type = 1;
;  } else if (n1->pd.type == 1 ){
;    r->pd.data.i = (((double)n1->pd.data.i) < lit) ? 1 : 0;;
;    r->pd.type = 1;
;  } else {
;    //Invalid data
;    r->pd.type = 0;
;  }
;
;}

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
  br label %60

; <label>:30:                                     ; preds = %3
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 1
  %33 = getelementptr inbounds %struct.tdata, %struct.tdata* %32, i32 0, i32 0
  %34 = load i8, i8* %33, align 8
  %35 = zext i8 %34 to i32
  %36 = icmp eq i32 %35, 1
  br i1 %36, label %37, label %55

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

;void funk_mod_ri(struct tnode * r, struct tnode * n1, int lit){
;  if (n1->pd.type == 2){
;      r->pd.data.f = (int)(n1->pd.data.f) % lit;
;      r->pd.type = 1;
;  } else if (n1->pd.type == 1 ){
;    r->pd.data.i = n1->pd.data.i % lit;
;    r->pd.type = 1;
;  } else {
;    //Invalid data
;    r->pd.type = 0;
;  }
;
;}

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

;void funk_eq_ri(struct tnode * r, struct tnode * n1, int lit){
;  if (n1->pd.type == 2){
;      r->pd.data.f = n1->pd.data.f * (float)lit;
;      r->pd.type = 2;
;  } else if (n1->pd.type == 1 ){
;    r->pd.data.i = (n1->pd.data.i == lit) ? 1 : 0;
;    r->pd.type = 1;
;  } else {
;    //Invalid data
;    r->pd.type = 0;
;  }
;
;}

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
  br i1 %12, label %13, label %30

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = load i32, i32* %6, align 4
  %20 = sitofp i32 %19 to float
  %21 = fpext float %20 to double
  %22 = fmul double %18, %21
  %23 = load %struct.tnode*, %struct.tnode** %4, align 8
  %24 = getelementptr inbounds %struct.tnode, %struct.tnode* %23, i32 0, i32 1
  %25 = getelementptr inbounds %struct.tdata, %struct.tdata* %24, i32 0, i32 1
  %26 = bitcast %union.data_type* %25 to double*
  store double %22, double* %26, align 8
  %27 = load %struct.tnode*, %struct.tnode** %4, align 8
  %28 = getelementptr inbounds %struct.tnode, %struct.tnode* %27, i32 0, i32 1
  %29 = getelementptr inbounds %struct.tdata, %struct.tdata* %28, i32 0, i32 0
  store i8 2, i8* %29, align 8
  br label %59

; <label>:30:                                     ; preds = %3
  %31 = load %struct.tnode*, %struct.tnode** %5, align 8
  %32 = getelementptr inbounds %struct.tnode, %struct.tnode* %31, i32 0, i32 1
  %33 = getelementptr inbounds %struct.tdata, %struct.tdata* %32, i32 0, i32 0
  %34 = load i8, i8* %33, align 8
  %35 = zext i8 %34 to i32
  %36 = icmp eq i32 %35, 1
  br i1 %36, label %37, label %54

; <label>:37:                                     ; preds = %30
  %38 = load %struct.tnode*, %struct.tnode** %5, align 8
  %39 = getelementptr inbounds %struct.tnode, %struct.tnode* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.tdata, %struct.tdata* %39, i32 0, i32 1
  %41 = bitcast %union.data_type* %40 to i32*
  %42 = load i32, i32* %41, align 8
  %43 = load i32, i32* %6, align 4
  %44 = icmp eq i32 %42, %43
  %45 = zext i1 %44 to i64
  %46 = select i1 %44, i32 1, i32 0
  %47 = load %struct.tnode*, %struct.tnode** %4, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 1
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 1
  %50 = bitcast %union.data_type* %49 to i32*
  store i32 %46, i32* %50, align 8
  %51 = load %struct.tnode*, %struct.tnode** %4, align 8
  %52 = getelementptr inbounds %struct.tnode, %struct.tnode* %51, i32 0, i32 1
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 0
  store i8 1, i8* %53, align 8
  br label %58

; <label>:54:                                     ; preds = %30
  %55 = load %struct.tnode*, %struct.tnode** %4, align 8
  %56 = getelementptr inbounds %struct.tnode, %struct.tnode* %55, i32 0, i32 1
  %57 = getelementptr inbounds %struct.tdata, %struct.tdata* %56, i32 0, i32 0
  store i8 0, i8* %57, align 8
  br label %58

; <label>:58:                                     ; preds = %54, %37
  br label %59

; <label>:59:                                     ; preds = %58, %13
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

;void mul_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
;  if (n1->pd.type == 2 && n2->pd.type == 2){
;      r->pd.data.f = n1->pd.data.f * n2->pd.data.f;
;      r->pd.type = 2;
;  } else if (n1->pd.type == 1 && n2->pd.type == 1){
;    r->pd.data.i = n1->pd.data.i * n2->pd.data.i;
;    r->pd.type = 1;
;  } else if (n1->pd.type == 2 && n2->pd.type == 1){
;    r->pd.data.f = n1->pd.data.f * (double)(n2->pd.data.i);
;    r->pd.type = 2;
;  } else if (n1->pd.type == 1 && n2->pd.type == 2){
;    r->pd.data.f = (double)n1->pd.data.i * n2->pd.data.f;
;    r->pd.type = 2;
;  } else {
;    //Invalid data
;    r->pd.type = 0;
;  }
;
;}

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
  %10 = load i8, i8* %9, align 4
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %39

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %6, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 4
  %18 = zext i8 %17 to i32
  %19 = icmp eq i32 %18, 2
  br i1 %19, label %20, label %39

; <label>:20:                                     ; preds = %13
  %21 = load %struct.tnode*, %struct.tnode** %5, align 8
  %22 = getelementptr inbounds %struct.tnode, %struct.tnode* %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct.tdata, %struct.tdata* %22, i32 0, i32 1
  %24 = bitcast %union.data_type* %23 to float*
  %25 = load float, float* %24, align 4
  %26 = load %struct.tnode*, %struct.tnode** %6, align 8
  %27 = getelementptr inbounds %struct.tnode, %struct.tnode* %26, i32 0, i32 1
  %28 = getelementptr inbounds %struct.tdata, %struct.tdata* %27, i32 0, i32 1
  %29 = bitcast %union.data_type* %28 to float*
  %30 = load float, float* %29, align 4
  %31 = fmul float %25, %30
  %32 = load %struct.tnode*, %struct.tnode** %4, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 1
  %35 = bitcast %union.data_type* %34 to float*
  store float %31, float* %35, align 4
  %36 = load %struct.tnode*, %struct.tnode** %4, align 8
  %37 = getelementptr inbounds %struct.tnode, %struct.tnode* %36, i32 0, i32 1
  %38 = getelementptr inbounds %struct.tdata, %struct.tdata* %37, i32 0, i32 0
  store i8 2, i8* %38, align 4
  br label %151

; <label>:39:                                     ; preds = %13, %3
  %40 = load %struct.tnode*, %struct.tnode** %5, align 8
  %41 = getelementptr inbounds %struct.tnode, %struct.tnode* %40, i32 0, i32 1
  %42 = getelementptr inbounds %struct.tdata, %struct.tdata* %41, i32 0, i32 0
  %43 = load i8, i8* %42, align 4
  %44 = zext i8 %43 to i32
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %72

; <label>:46:                                     ; preds = %39
  %47 = load %struct.tnode*, %struct.tnode** %6, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 1
  %49 = getelementptr inbounds %struct.tdata, %struct.tdata* %48, i32 0, i32 0
  %50 = load i8, i8* %49, align 4
  %51 = zext i8 %50 to i32
  %52 = icmp eq i32 %51, 1
  br i1 %52, label %53, label %72

; <label>:53:                                     ; preds = %46
  %54 = load %struct.tnode*, %struct.tnode** %5, align 8
  %55 = getelementptr inbounds %struct.tnode, %struct.tnode* %54, i32 0, i32 1
  %56 = getelementptr inbounds %struct.tdata, %struct.tdata* %55, i32 0, i32 1
  %57 = bitcast %union.data_type* %56 to i32*
  %58 = load i32, i32* %57, align 4
  %59 = load %struct.tnode*, %struct.tnode** %6, align 8
  %60 = getelementptr inbounds %struct.tnode, %struct.tnode* %59, i32 0, i32 1
  %61 = getelementptr inbounds %struct.tdata, %struct.tdata* %60, i32 0, i32 1
  %62 = bitcast %union.data_type* %61 to i32*
  %63 = load i32, i32* %62, align 4
  %64 = mul nsw i32 %58, %63
  %65 = load %struct.tnode*, %struct.tnode** %4, align 8
  %66 = getelementptr inbounds %struct.tnode, %struct.tnode* %65, i32 0, i32 1
  %67 = getelementptr inbounds %struct.tdata, %struct.tdata* %66, i32 0, i32 1
  %68 = bitcast %union.data_type* %67 to i32*
  store i32 %64, i32* %68, align 4
  %69 = load %struct.tnode*, %struct.tnode** %4, align 8
  %70 = getelementptr inbounds %struct.tnode, %struct.tnode* %69, i32 0, i32 1
  %71 = getelementptr inbounds %struct.tdata, %struct.tdata* %70, i32 0, i32 0
  store i8 1, i8* %71, align 4
  br label %150

; <label>:72:                                     ; preds = %46, %39
  %73 = load %struct.tnode*, %struct.tnode** %5, align 8
  %74 = getelementptr inbounds %struct.tnode, %struct.tnode* %73, i32 0, i32 1
  %75 = getelementptr inbounds %struct.tdata, %struct.tdata* %74, i32 0, i32 0
  %76 = load i8, i8* %75, align 4
  %77 = zext i8 %76 to i32
  %78 = icmp eq i32 %77, 2
  br i1 %78, label %79, label %108

; <label>:79:                                     ; preds = %72
  %80 = load %struct.tnode*, %struct.tnode** %6, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 1
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 0
  %83 = load i8, i8* %82, align 4
  %84 = zext i8 %83 to i32
  %85 = icmp eq i32 %84, 1
  br i1 %85, label %86, label %108

; <label>:86:                                     ; preds = %79
  %87 = load %struct.tnode*, %struct.tnode** %5, align 8
  %88 = getelementptr inbounds %struct.tnode, %struct.tnode* %87, i32 0, i32 1
  %89 = getelementptr inbounds %struct.tdata, %struct.tdata* %88, i32 0, i32 1
  %90 = bitcast %union.data_type* %89 to float*
  %91 = load float, float* %90, align 4
  %92 = fpext float %91 to double
  %93 = load %struct.tnode*, %struct.tnode** %6, align 8
  %94 = getelementptr inbounds %struct.tnode, %struct.tnode* %93, i32 0, i32 1
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %94, i32 0, i32 1
  %96 = bitcast %union.data_type* %95 to i32*
  %97 = load i32, i32* %96, align 4
  %98 = sitofp i32 %97 to double
  %99 = fmul double %92, %98
  %100 = fptrunc double %99 to float
  %101 = load %struct.tnode*, %struct.tnode** %4, align 8
  %102 = getelementptr inbounds %struct.tnode, %struct.tnode* %101, i32 0, i32 1
  %103 = getelementptr inbounds %struct.tdata, %struct.tdata* %102, i32 0, i32 1
  %104 = bitcast %union.data_type* %103 to float*
  store float %100, float* %104, align 4
  %105 = load %struct.tnode*, %struct.tnode** %4, align 8
  %106 = getelementptr inbounds %struct.tnode, %struct.tnode* %105, i32 0, i32 1
  %107 = getelementptr inbounds %struct.tdata, %struct.tdata* %106, i32 0, i32 0
  store i8 2, i8* %107, align 4
  br label %149

; <label>:108:                                    ; preds = %79, %72
  %109 = load %struct.tnode*, %struct.tnode** %5, align 8
  %110 = getelementptr inbounds %struct.tnode, %struct.tnode* %109, i32 0, i32 1
  %111 = getelementptr inbounds %struct.tdata, %struct.tdata* %110, i32 0, i32 0
  %112 = load i8, i8* %111, align 4
  %113 = zext i8 %112 to i32
  %114 = icmp eq i32 %113, 1
  br i1 %114, label %115, label %144

; <label>:115:                                    ; preds = %108
  %116 = load %struct.tnode*, %struct.tnode** %6, align 8
  %117 = getelementptr inbounds %struct.tnode, %struct.tnode* %116, i32 0, i32 1
  %118 = getelementptr inbounds %struct.tdata, %struct.tdata* %117, i32 0, i32 0
  %119 = load i8, i8* %118, align 4
  %120 = zext i8 %119 to i32
  %121 = icmp eq i32 %120, 2
  br i1 %121, label %122, label %144

; <label>:122:                                    ; preds = %115
  %123 = load %struct.tnode*, %struct.tnode** %5, align 8
  %124 = getelementptr inbounds %struct.tnode, %struct.tnode* %123, i32 0, i32 1
  %125 = getelementptr inbounds %struct.tdata, %struct.tdata* %124, i32 0, i32 1
  %126 = bitcast %union.data_type* %125 to i32*
  %127 = load i32, i32* %126, align 4
  %128 = sitofp i32 %127 to double
  %129 = load %struct.tnode*, %struct.tnode** %6, align 8
  %130 = getelementptr inbounds %struct.tnode, %struct.tnode* %129, i32 0, i32 1
  %131 = getelementptr inbounds %struct.tdata, %struct.tdata* %130, i32 0, i32 1
  %132 = bitcast %union.data_type* %131 to float*
  %133 = load float, float* %132, align 4
  %134 = fpext float %133 to double
  %135 = fmul double %128, %134
  %136 = fptrunc double %135 to float
  %137 = load %struct.tnode*, %struct.tnode** %4, align 8
  %138 = getelementptr inbounds %struct.tnode, %struct.tnode* %137, i32 0, i32 1
  %139 = getelementptr inbounds %struct.tdata, %struct.tdata* %138, i32 0, i32 1
  %140 = bitcast %union.data_type* %139 to float*
  store float %136, float* %140, align 4
  %141 = load %struct.tnode*, %struct.tnode** %4, align 8
  %142 = getelementptr inbounds %struct.tnode, %struct.tnode* %141, i32 0, i32 1
  %143 = getelementptr inbounds %struct.tdata, %struct.tdata* %142, i32 0, i32 0
  store i8 2, i8* %143, align 4
  br label %148

; <label>:144:                                    ; preds = %115, %108
  %145 = load %struct.tnode*, %struct.tnode** %4, align 8
  %146 = getelementptr inbounds %struct.tnode, %struct.tnode* %145, i32 0, i32 1
  %147 = getelementptr inbounds %struct.tdata, %struct.tdata* %146, i32 0, i32 0
  store i8 0, i8* %147, align 4
  br label %148

; <label>:148:                                    ; preds = %144, %122
  br label %149

; <label>:149:                                    ; preds = %148, %86
  br label %150

; <label>:150:                                    ; preds = %149, %53
  br label %151

; <label>:151:                                    ; preds = %150, %20
  ret void
}



;void funk_sub_rf(struct tnode * r, struct tnode * n1, double d){
;  if (n1->pd.type == 2){
;      r->pd.data.f = n1->pd.data.f - d;
;      r->pd.type = 2;
;  } else if (n1->pd.type == 1 ){
;    r->pd.data.f = ((double)n1->pd.data.i) - d;
;    r->pd.type = 2;
;  } else {
;    //Invalid data
;    r->pd.type = 0;
;  }
;
;}

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

;
;void funk_add_rf(struct tnode * r, struct tnode * n1, double d){
;  if (n1->pd.type == 2){
;      r->pd.data.f = n1->pd.data.f + d;
;      r->pd.type = 2;
;  } else if (n1->pd.type == 1 ){
;    r->pd.data.f = ((double)n1->pd.data.i) + d;
;    r->pd.type = 2;
;  } else {
;    //Invalid data
;    r->pd.type = 0;
;  }
;
;}
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
  %9 = load double, double* %3, align 4
  %10 = fsub double %8, %9
  %11 = fmul double %7, %10
  %12 = load double, double* %3, align 4
  %13 = fadd double %11, %12
  ret double %13
}

;struct tnode * funk_CreateLinkedListConstInt(int start, int end, int val ){
;   struct tnode * head = NULL;
;   struct tnode * prev = NULL;
;   struct tnode * node = NULL;
;
;  int i = 0;
;  for (i = start; i <= end; ++i){
;    node = (struct tnode*)malloc(sizeof(struct tnode));
;    node->type = 3; //List Node
;    node->pd.type = type_int;
;    node->pd.data.i = val;
;    registerHeapAllocation(node);
;
;    if (prev){
;        prev->next = node;
;    } else {
;      head = node;
;    }
;    prev = node;
;  }
;
;   struct tnode * tail = (struct tnode*)malloc(sizeof(struct tnode));
;   tail->type = 4; //empty_array
;   tail->pd.type = type_int;
;
;   if (node != NULL)
;      node->next = tail;
;
;   if (head == NULL)
;      head = tail;
;
;   tail->next = NULL;
;   tail->pd.data.i = i;
;   return head;
;}

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
  %18 = call i8* @malloc(i64 40) #4
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
  %45 = call i8* @malloc(i64 40) #4
  %46 = bitcast i8* %45 to %struct.tnode*
  store %struct.tnode* %46, %struct.tnode** %11, align 8
  %47 = load %struct.tnode*, %struct.tnode** %11, align 8
  %48 = getelementptr inbounds %struct.tnode, %struct.tnode* %47, i32 0, i32 0
  store i8 4, i8* %48, align 8
  %49 = load %struct.tnode*, %struct.tnode** %11, align 8
  %50 = getelementptr inbounds %struct.tnode, %struct.tnode* %49, i32 0, i32 1
  %51 = getelementptr inbounds %struct.tdata, %struct.tdata* %50, i32 0, i32 0
  store i8 1, i8* %51, align 8
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


;float funk_ToFloat(struct tnode * n){
;  if (n->pd.type == type_int){
;    return (float)n->pd.data.i;
;  } else if (n->pd.type == type_double){
;    return (float)n->pd.data.f;
;  } else {
;    n->pd.type = type_invalid;
;    return 0.0f;
;  }
;}

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
  br i1 %12, label %13, label %31

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = load i32, i32* %6, align 4
  %20 = sitofp i32 %19 to double
  %21 = fcmp olt double %18, %20
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
  br label %60

; <label>:31:                                     ; preds = %3
  %32 = load %struct.tnode*, %struct.tnode** %5, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 0
  %35 = load i8, i8* %34, align 8
  %36 = zext i8 %35 to i32
  %37 = icmp eq i32 %36, 2
  br i1 %37, label %38, label %55

; <label>:38:                                     ; preds = %31
  %39 = load %struct.tnode*, %struct.tnode** %5, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 1
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 1
  %42 = bitcast %union.data_type* %41 to i32*
  %43 = load i32, i32* %42, align 8
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

; <label>:55:                                     ; preds = %31
  %56 = load %struct.tnode*, %struct.tnode** %4, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 0
  store i8 0, i8* %58, align 8
  br label %59

; <label>:59:                                     ; preds = %55, %38
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
  br i1 %12, label %13, label %31

; <label>:13:                                     ; preds = %3
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = getelementptr inbounds %struct.tnode, %struct.tnode* %14, i32 0, i32 1
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 1
  %17 = bitcast %union.data_type* %16 to double*
  %18 = load double, double* %17, align 8
  %19 = load i32, i32* %6, align 4
  %20 = sitofp i32 %19 to double
  %21 = fcmp ogt double %18, %20
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
  br label %60

; <label>:31:                                     ; preds = %3
  %32 = load %struct.tnode*, %struct.tnode** %5, align 8
  %33 = getelementptr inbounds %struct.tnode, %struct.tnode* %32, i32 0, i32 1
  %34 = getelementptr inbounds %struct.tdata, %struct.tdata* %33, i32 0, i32 0
  %35 = load i8, i8* %34, align 8
  %36 = zext i8 %35 to i32
  %37 = icmp eq i32 %36, 2
  br i1 %37, label %38, label %55

; <label>:38:                                     ; preds = %31
  %39 = load %struct.tnode*, %struct.tnode** %5, align 8
  %40 = getelementptr inbounds %struct.tnode, %struct.tnode* %39, i32 0, i32 1
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 1
  %42 = bitcast %union.data_type* %41 to i32*
  %43 = load i32, i32* %42, align 8
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

; <label>:55:                                     ; preds = %31
  %56 = load %struct.tnode*, %struct.tnode** %4, align 8
  %57 = getelementptr inbounds %struct.tnode, %struct.tnode* %56, i32 0, i32 1
  %58 = getelementptr inbounds %struct.tdata, %struct.tdata* %57, i32 0, i32 0
  store i8 0, i8* %58, align 8
  br label %59

; <label>:59:                                     ; preds = %55, %38
  br label %60

; <label>:60:                                     ; preds = %59, %13
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
  br label %109

; <label>:45:                                     ; preds = %13, %3
  %46 = load %struct.tnode*, %struct.tnode** %5, align 8
  %47 = getelementptr inbounds %struct.tnode, %struct.tnode* %46, i32 0, i32 1
  %48 = getelementptr inbounds %struct.tdata, %struct.tdata* %47, i32 0, i32 0
  %49 = load i8, i8* %48, align 8
  %50 = zext i8 %49 to i32
  %51 = icmp eq i32 %50, 2
  br i1 %51, label %52, label %87

; <label>:52:                                     ; preds = %45
  %53 = load %struct.tnode*, %struct.tnode** %6, align 8
  %54 = getelementptr inbounds %struct.tnode, %struct.tnode* %53, i32 0, i32 1
  %55 = getelementptr inbounds %struct.tdata, %struct.tdata* %54, i32 0, i32 0
  %56 = load i8, i8* %55, align 8
  %57 = zext i8 %56 to i32
  %58 = icmp eq i32 %57, 2
  br i1 %58, label %59, label %87

; <label>:59:                                     ; preds = %52
  %60 = load %struct.tnode*, %struct.tnode** %5, align 8
  %61 = getelementptr inbounds %struct.tnode, %struct.tnode* %60, i32 0, i32 1
  %62 = getelementptr inbounds %struct.tdata, %struct.tdata* %61, i32 0, i32 1
  %63 = bitcast %union.data_type* %62 to i32*
  %64 = load i32, i32* %63, align 8
  %65 = sitofp i32 %64 to float
  %66 = fcmp une float %65, 0.000000e+00
  br i1 %66, label %75, label %67

; <label>:67:                                     ; preds = %59
  %68 = load %struct.tnode*, %struct.tnode** %6, align 8
  %69 = getelementptr inbounds %struct.tnode, %struct.tnode* %68, i32 0, i32 1
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 1
  %71 = bitcast %union.data_type* %70 to i32*
  %72 = load i32, i32* %71, align 8
  %73 = sitofp i32 %72 to float
  %74 = fcmp une float %73, 0.000000e+00
  br label %75

; <label>:75:                                     ; preds = %67, %59
  %76 = phi i1 [ true, %59 ], [ %74, %67 ]
  %77 = zext i1 %76 to i64
  %78 = select i1 %76, float 1.000000e+00, float 0.000000e+00
  %79 = fpext float %78 to double
  %80 = load %struct.tnode*, %struct.tnode** %4, align 8
  %81 = getelementptr inbounds %struct.tnode, %struct.tnode* %80, i32 0, i32 1
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 1
  %83 = bitcast %union.data_type* %82 to double*
  store double %79, double* %83, align 8
  %84 = load %struct.tnode*, %struct.tnode** %4, align 8
  %85 = getelementptr inbounds %struct.tnode, %struct.tnode* %84, i32 0, i32 1
  %86 = getelementptr inbounds %struct.tdata, %struct.tdata* %85, i32 0, i32 0
  store i8 2, i8* %86, align 8
  br label %108

; <label>:87:                                     ; preds = %52, %45
  %88 = load %struct.tnode*, %struct.tnode** %5, align 8
  %89 = getelementptr inbounds %struct.tnode, %struct.tnode* %88, i32 0, i32 1
  %90 = getelementptr inbounds %struct.tdata, %struct.tdata* %89, i32 0, i32 0
  %91 = load i8, i8* %90, align 8
  %92 = zext i8 %91 to i32
  %93 = load %struct.tnode*, %struct.tnode** %6, align 8
  %94 = getelementptr inbounds %struct.tnode, %struct.tnode* %93, i32 0, i32 1
  %95 = getelementptr inbounds %struct.tdata, %struct.tdata* %94, i32 0, i32 0
  %96 = load i8, i8* %95, align 8
  %97 = zext i8 %96 to i32
  %98 = icmp ne i32 %92, %97
  br i1 %98, label %99, label %103

; <label>:99:                                     ; preds = %87
  %100 = load %struct.tnode*, %struct.tnode** %4, align 8
  %101 = getelementptr inbounds %struct.tnode, %struct.tnode* %100, i32 0, i32 1
  %102 = getelementptr inbounds %struct.tdata, %struct.tdata* %101, i32 0, i32 0
  store i8 0, i8* %102, align 8
  br label %107

; <label>:103:                                    ; preds = %87
  %104 = load %struct.tnode*, %struct.tnode** %4, align 8
  %105 = getelementptr inbounds %struct.tnode, %struct.tnode* %104, i32 0, i32 1
  %106 = getelementptr inbounds %struct.tdata, %struct.tdata* %105, i32 0, i32 0
  store i8 0, i8* %106, align 8
  br label %107

; <label>:107:                                    ; preds = %103, %99
  br label %108

; <label>:108:                                    ; preds = %107, %75
  br label %109

; <label>:109:                                    ; preds = %108, %34
  ret void
}
