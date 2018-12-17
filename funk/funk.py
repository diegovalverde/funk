from funk_llvm_emitter import Emitter
import funk_types


class FunctionScope:
    def __init__(self, name, ret_type='i32',  args=[], pattern_matches=[], tail_pairs=[], empty=False):
        self.name = name
        self.args = args
        self.tail_pairs = tail_pairs
        self.ret_val = ret_type
        self.emitter = Emitter()
        self.ret_statement = 'ret i32 0'
        self.empty = empty
        self.pattern_matches = pattern_matches
        functions = []

    def emit(self):

        if self.empty:
            return self.emitter.emit()

        args_string = ''
        for i in range(len(self.args)):
            args_string += self.args[i]
            if i + 1 != len(self.args):
                args_string += ', '

        firm = """
        
define {ret_val} @{name}({args}) #0 {{
""".format(ret_val=self.ret_val, name=self.name, args=args_string)

        post_amble = """
        
        ;; Each function has a  return statement      
        {0}
}}

         """.format(self.ret_statement)

        return firm + self.emitter.emit() + post_amble


class Funk:
    def __init__(self):

        self.symbol_table = {}
        self.strings_count = 0

        main_scope = '_function__{}'.format('main')
        self.symbol_table = {} #[main_scope] = #FunctionScope('main', 'i32', [])
        self.function_scope = None #self.symbol_table[main_scope]
        self.functions = []#[main_scope]
        self.preamble = \
            """
;; =============================================================== ;;
;;
;; *** F U N K ! *** Runtime embedded environment 
;;
;;
;; https://llvm.org/docs/LangRef.html
;; =============================================================== ;;


target triple = "x86_64-apple-darwin17.7.0"
target datalayout = ""


;; =============================================================== ;;
;; Main data type representation

;; Since Funk supports runtime types, then a union is used
;; to store the types. Recall that there are really no unions
;; in LLVM, rather the size of the biggest data type is used and
;; then the appropiate bitcast is used to inform the compiler about
;; the corresponding data type for a given symbol

%union.data_type = type {{ {{}}* }}

;; This a primitive data type. It contains a type tag (i8) followed by
;; the actual data represented as a union

%struct.tdata = type {{ i8, %union.data_type }}

;; These are nodes of a linked list. These are used to present lists
;; as well are function arguments (which are essentially lists)

%struct.tnode = type {{ i8, %struct.tdata, %struct.tnode* }}


;; =============================================================== ;;

;; ===  Global Funk definitions ===

@.str_DISP_INT = private unnamed_addr constant [3 x i8] c"%i\0", align 1
@.str_DISP_FLOAT = private unnamed_addr constant [3 x i8] c"%f\0", align 1
@.str_DISP_EOL = private unnamed_addr constant [2 x i8] c"\\0A\\00", align 1

@.str_ERR_ARITH_TYPE = private unnamed_addr constant [36 x i8] c"-E- Unsupported Arithmetic Type %i\\0A\\00", align 1
@.str_ERR_PRINT_TYPE = private unnamed_addr constant [33 x i8] c"-E- Unsupported Print Type   %i\\0A\\00", align 1

;; ==== Funk internal functions =======

;;===== printing ====
; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_scalar(%struct.tnode*) #0 {{
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  %4 = getelementptr inbounds %struct.tnode, %struct.tnode* %3, i32 0, i32 1
  %5 = getelementptr inbounds %struct.tdata, %struct.tdata* %4, i32 0, i32 0
  %6 = load i8, i8* %5, align 8
  %7 = zext i8 %6 to i32
  switch i32 %7, label %23 [
    i32 {funk_type_int}, label %8
    i32 {funk_type_float}, label %15
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
  %19 = bitcast %union.data_type* %18 to float*
  %20 = load float, float* %19, align 8
  %21 = fpext float %20 to double
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str_DISP_FLOAT, i32 0, i32 0), double %21)
  br label %25

; <label>:23:                                     ; preds = %1
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str_ERR_PRINT_TYPE, i32 0, i32 0), i32 %7)
  br label %25

; <label>:25:                                     ; preds = %23, %15, %8
  ret void
}}


;;======== Arithmetic functions ====

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {{
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
  %19 = icmp eq i32 %18, {funk_type_int}
  br i1 %19, label %20, label %43

; <label>:20:                                     ; preds = %3
  %21 = load i8, i8* %8, align 1
  %22 = zext i8 %21 to i32
  %23 = icmp eq i32 %22, {funk_type_int}
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
  store i8 {funk_type_int}, i8* %42, align 8
  br label %77

; <label>:43:                                     ; preds = %20, %3
  %44 = load i8, i8* %7, align 1
  %45 = zext i8 %44 to i32
  %46 = icmp eq i32 %45, {funk_type_float}
  br i1 %46, label %47, label %70

; <label>:47:                                     ; preds = %43
  %48 = load i8, i8* %8, align 1
  %49 = zext i8 %48 to i32
  %50 = icmp eq i32 %49, {funk_type_float}
  br i1 %50, label %51, label %70

; <label>:51:                                     ; preds = %47
  %52 = load %struct.tnode*, %struct.tnode** %5, align 8
  %53 = getelementptr inbounds %struct.tnode, %struct.tnode* %52, i32 0, i32 1
  %54 = getelementptr inbounds %struct.tdata, %struct.tdata* %53, i32 0, i32 1
  %55 = bitcast %union.data_type* %54 to float*
  %56 = load float, float* %55, align 8
  %57 = load %struct.tnode*, %struct.tnode** %6, align 8
  %58 = getelementptr inbounds %struct.tnode, %struct.tnode* %57, i32 0, i32 1
  %59 = getelementptr inbounds %struct.tdata, %struct.tdata* %58, i32 0, i32 1
  %60 = bitcast %union.data_type* %59 to float*
  %61 = load float, float* %60, align 8
  %62 = fsub float %56, %61
  %63 = load %struct.tnode*, %struct.tnode** %4, align 8
  %64 = getelementptr inbounds %struct.tnode, %struct.tnode* %63, i32 0, i32 1
  %65 = getelementptr inbounds %struct.tdata, %struct.tdata* %64, i32 0, i32 1
  %66 = bitcast %union.data_type* %65 to float*
  store float %62, float* %66, align 8
  %67 = load %struct.tnode*, %struct.tnode** %4, align 8
  %68 = getelementptr inbounds %struct.tnode, %struct.tnode* %67, i32 0, i32 1
  %69 = getelementptr inbounds %struct.tdata, %struct.tdata* %68, i32 0, i32 0
  store i8 {funk_type_float}, i8* %69, align 8
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
}}


; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_add_ri(%struct.tnode*, %struct.tnode*, i32) #0 {{
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
  %14 = icmp ne i32 %13, {funk_type_int}
  br i1 %14, label %15, label %17

; <label>:15:                                     ; preds = %3
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str_ERR_ARITH_TYPE, i32 0, i32 0), i32 %13, i32 {funk_type_int})
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
  store i8 {funk_type_int}, i8* %31, align 8
  br label %32

; <label>:32:                                     ; preds = %17, %15
  ret void
}}


; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sub_ri(%struct.tnode*, %struct.tnode*, i32) #0 {{
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
  %14 = icmp ne i32 %13, {funk_type_int}
  br i1 %14, label %15, label %17

; <label>:15:                                     ; preds = %3
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str_ERR_ARITH_TYPE, i32 0, i32 0), i32 %13, i32 {funk_type_int})
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
  store i8 {funk_type_int}, i8* %31, align 8
  br label %32

; <label>:32:                                     ; preds = %17, %15
  ret void
}}



            """.format(funk_type_int=funk_types.int, funk_type_float=funk_types.float)

        self.post_amble =\
        """

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2


declare i32 @printf(i8*, ...) #1

        """

        self.emitter = None

    def create_function_scope(self, name, ret_type='%struct.tdata', args=[], tail_pairs=[], pattern_matches=[], empty=False):
        scope_name = '{}'.format(name)
        self.symbol_table[scope_name] = FunctionScope(name, ret_type=ret_type, args=args, tail_pairs=tail_pairs,
                                                      empty=empty, pattern_matches=pattern_matches)
        self.functions.append(scope_name)

        return scope_name

    def set_function_scope(self, name):
        if name not in self.symbol_table:
            raise Exception('-E- Function {} not in symbol table'.format(name))

        self.function_scope = self.symbol_table[name]
        self.emitter = self.function_scope.emitter

    def emit(self):
        code = self.preamble
        for func in self.functions:
            code += self.symbol_table[func].emit()

        code += self.post_amble

        return code

    def save_ir(self, path):
        f = open(path, 'w')
        f.write(self.emit())
        f.close()
