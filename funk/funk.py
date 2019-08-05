# -*- coding: utf-8 -*-
#
# Copyright (C) 2019 Diego Valverde
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.


from .funk_llvm_emitter import Emitter
from llvmlite import binding
try:
    from lark import Lark
except ImportError:
    import lark
from .funk_ast_transformer import TreeToAst
from . import funk_types


class FunctionScope:
    def __init__(self, name, ret_type='i32', args=None, pattern_matches=None, tail_pairs=None, empty=False):
        if pattern_matches is None:
            pattern_matches = []
        if tail_pairs is None:
            tail_pairs = []
        if args is None:
            args = []
        self.name = name
        self.clause_idx = 0  # In case there are multiple clauses this makes sure variable names can be reused
        self.args = args
        self.lhs_symbols = [] # This contains a list IR regs used
        self.tail_pairs = tail_pairs
        self.ret_val = ret_type
        self.emitter = Emitter()
        self.ret_statement = 'ret i32 0'
        self.empty = empty
        self.pattern_matches = pattern_matches

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
    def __init__(self, debug=False):

        self.debug = debug

        with open('funk/funk_ll1.lark', 'r') as myfile:
            funk_grammar = myfile.read()

        self.window = None
        self.grammar = Lark(funk_grammar)
        self.strings_count = 0  # used to declare constant strings as unique globals
        self.triple = binding.get_default_triple()
        self.symbol_table = {}  # the symbol table
        self.function_scope = None  # The function scope that we are currently building
        self.functions = []
        self.empty_arg_count = 0  # essentially all of the '_' shall be uniquely identifiable
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

%union.data_type = type {{ double }}

;; This a primitive data type. It contains a type tag (i8) followed by
;; the actual data represented as a union

%struct.tdata = type {{ i8, %union.data_type }}

;; These are nodes of a linked list. These are used to present lists
;; as well are function arguments (which are essentially lists)

%struct.tnode = type {{ i8, %struct.tdata, %struct.tnode*, i32 }}


;; =============================================================== ;;

;; ===  Global Funk definitions ===

@.str_DISP_INT = private unnamed_addr constant [3 x i8] c"%i\0", align 1
@.str_DISP_FLOAT = private unnamed_addr constant [3 x i8] c"%f\0", align 1
@.str_DISP_EOL = private unnamed_addr constant [2 x i8] c"\\0A\\00", align 1

@.str_ERR_ARITH_TYPE = private unnamed_addr constant [36 x i8] c"-E- Unsupported Arithmetic Type %i\\0A\\00", align 1
@.str_ERR_PRINT_TYPE = private unnamed_addr constant [33 x i8] c"-E- Unsupported Print Type   %i\\0A\\00", align 1


; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2


declare void @free(i8*) #1


declare double @rand_double(double, double) #0
declare i32 @rand_int(i32, i32) #0
declare void @init_random_seed() #0
declare void @print_scalar(%struct.tnode*) #0
declare void @funk_eq_ri(%struct.tnode*, %struct.tnode*, i32) #0
declare void @funk_flt_rf(%struct.tnode*, %struct.tnode*, double) #0
declare void @funk_mod_ri(%struct.tnode*, %struct.tnode*, i32) #0
declare void @funk_add_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare void @funk_eq_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare void @funk_add_ri(%struct.tnode*, %struct.tnode*, i32) #0
declare void @funk_sub_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare void @funk_sub_ri(%struct.tnode*, %struct.tnode*, i32) #0
declare void @funk_div_ri(%struct.tnode*, %struct.tnode*, i32) #0
declare void @funk_mul_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare void @funk_mul_rf(%struct.tnode*, %struct.tnode*, double) #0
declare void @funk_add_rf(%struct.tnode*, %struct.tnode*, double) #0
declare void @funk_sub_rf(%struct.tnode*, %struct.tnode*, double) #0
declare void @funk_div_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare  void @funk_mod_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare %struct.tnode* @funk_CreateLinkedListConstInt(i32, i32, i32) #0
declare void @registerHeapAllocation(%struct.tnode*) #0
declare void @initGarbageCollector() #0
declare void @collectGarbage() #0
declare i32 @"\\01_usleep"(i32) #1
declare %struct.tnode* @createLinkedList(i32, i32, i8 zeroext) #0
declare void @createLhsStackVar(%struct.tnode*) #0
declare float @funk_ToFloat(%struct.tnode*) #0
declare void @funk_slt_ri(%struct.tnode*, %struct.tnode*, i32) #0
declare void @funk_sgt_ri(%struct.tnode*, %struct.tnode*, i32) #0
declare void @funk_sge_ri(%struct.tnode*, %struct.tnode*, i32) #0
declare void @funk_sge_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare void @funk_or_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare void @funk_mul_ri(%struct.tnode*, %struct.tnode*, i32)
declare %struct.tnode* @funk_mallocNodeRight(%struct.tnode*) #0
declare void @markNodeForGarbageCollection(%struct.tnode*) #0
declare void @printCollectorStatus() #0
declare void @funk_memcp_arr(%struct.tnode*, %struct.tnode*, i32, i8 zeroext) #0
declare void @funk_and_rr(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0
declare void @funk_set_config_param(i32, i32) #0
declare %struct.tnode* @funk_concatenate_lists(%struct.tnode*, %struct.tnode*) #0 
declare void @get_s2d_user_global_state(%struct.tnode* noalias sret) #0
declare void @set_s2d_user_global_state(%struct.tnode*) #0
declare void @funk_exit() #0
            """.format(triple=self.triple, funk_type_int=funk_types.int, funk_type_float=funk_types.double)

        self.post_amble = \
            """

; Function Attrs: argmemonly nounwind
declare void @memcpy(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #3



declare i32 @printf(i8*, ...) #1

        """

        self.emitter = None

    def create_function_scope(self, name, ret_type='%struct.tdata', args=None, tail_pairs=None, pattern_matches=None,
                              empty=False):
        if args is None:
            args = []
        if tail_pairs is None:
            tail_pairs = []
        if pattern_matches is None:
            pattern_matches = []
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

    def compile(self, text):

        parse_tree = self.grammar.parse(text)

        ast_generator = TreeToAst(self, debug=self.debug)

        ast_generator.transform(parse_tree)

        for fn in ast_generator.function_definition_list:
            if self.debug:
                print('-I- Emitting Function {}/{} '.format(fn, ast_generator.function_map[fn].arity))

            ast_generator.function_map[fn].eval()

    def alloc_literal_symbol(self, symbol, symbol_name):
        return self.emitter.alloc_tnode(symbol_name, symbol.eval(), symbol.get_compile_type())

    def alloc_variable_list_symbol(self, p_start, p_end, expr):
        return self.emitter.alloc_variable_linked_list(p_start, p_end, expr)

    def alloc_literal_list_symbol(self, elements):
        n = len(elements)
        prev = None
        head = None
        node = None
        for i in range(n):
            node = self.emitter.alloc_tnode(name='list[{}]'.format(i),
                                            value=elements[i],
                                            data_type=funk_types.int,
                                            node_type=funk_types.array)
            if prev is not None:
                self.emitter.set_next_node(prev, node)
            else:
                head = node

            prev = node

        tail = self.emitter.alloc_tnode(name='list_tail',
                                        node_type=funk_types.empty_array)

        self.emitter.set_next_node(tail, 'null')
        self.emitter.set_next_node(node, tail)
        return head

    def create_variable_symbol(self, symbol, symbol_name):
        allocation = self.emitter.alloc_tnode(symbol_name, data_type=symbol.get_compile_type())
        symbol.eval(result=allocation)
        return allocation
