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
    def __init__(self, triple):

        self.symbol_table = {}
        self.strings_count = 0
        self.triple = triple

        main_scope = '_function__{}'.format('main')
        self.symbol_table = {}
        self.function_scope = None
        self.functions = []
        self.preamble = \
            """
;; =============================================================== ;;
;;
;; *** F U N K ! *** Runtime embedded environment 
;;
;;
;; https://llvm.org/docs/LangRef.html
;; =============================================================== ;;


target triple = "{triple}"
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

declare void @print_scalar(%struct.tnode*) #0
declare void @funk_add_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare void @funk_add_ri(%struct.tnode*, %struct.tnode*, i32) #0
declare void @funk_sub_ri(%struct.tnode*, %struct.tnode*, i32) #0 
 
            """.format(triple=triple, funk_type_int=funk_types.int, funk_type_float=funk_types.float)

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

    def create_literal_symbol(self,symbol, symbol_name):
        self.symbol_table[symbol_name] = self.emitter.alloc_tnode(symbol_name, symbol.eval(),
                                                                  symbol.type)

    def create_list_symbol(self, symbol , symbol_name):
        elements = symbol.eval()
        n = len(elements)
        prev = None
        head = None
        node = None
        for i in range(n):
            node = self.emitter.alloc_tnode(name='list[{}]'.format(i),
                                                 value=elements[i].eval(),
                                                 data_type=funk_types.int,
                                                 node_type=funk_types.array)
            if prev is not None:
                self.emitter.set_next_node(prev, node)
            else:
                head = node

            prev = node

        tail = self.emitter.alloc_tnode(name='list_tail',
                                             node_type=funk_types.empty_array)

        self.emitter.set_next_node(node, tail)
        self.symbol_table[symbol_name] = head

    def create_variable_symbol(self, symbol, symbol_name):
        allocation = self.funk.emitter.alloc_tdata(symbol_name)
        self.symbol_table[symbol_name] = '{}'.format(allocation)
        symbol.eval(result=allocation)
