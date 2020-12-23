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


from . import funk_types
from . import funk_constants
from . import funk_ast


def add_constant_string_symbol(funk, arg):
    format_string = arg
    format_len = len(format_string) + 1

    symbol = '@.str_{cnt}'.format(cnt=funk.strings_count)
    symbol_len = '[{format_len} x i8]'.format(format_len=format_len)

    funk.preamble += \
        """
    {symbol} = private unnamed_addr constant [{format_len} x i8] c"{format_string}\00", align 1
        """.format(symbol=symbol, cnt=funk.strings_count, format_len=format_len, format_string=format_string)

    funk.strings_count += 1

    return symbol, symbol_len


class Emitter:
    def __init__(self):
        self.index = 1
        self.code = ''
        self.scope_arg_map = {}
        self.scope_result_idx = None
        self.p_fn_args = None
        self.label_count = 0

    def emit(self):
        return self.code

    def get_node_data(self, node):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1
        self.code += """
        ;; extract data from Node
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
        """.format(p[0], node=node)

        return '%{}'.format(p[-1])

    def set_node_type(self, node, funk_type, index=0):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1
        self.code += """
        ;;;store node type: {str_type}
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 0
        store i8 {funk_type}, i8* %{0}, align 8
        """.format(p[0], str_type=funk_types.to_str[funk_type], node=node, funk_type=funk_type)

    def get_node_data_value(self, node, as_type=funk_types.int,offset = 0):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        if as_type == funk_types.double:
            self.code += """
            ;; Get node.data.value
            %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
            %{1} = getelementptr inbounds %struct.tdata, %struct.tdata* %{0}, i32 0, i32 1
            %{2} = bitcast %union.data_type* %{1} to double*
            %{3} = load double, double* %{2}, align 8
            """.format(p[0], p[1], p[2], p[3], node=node)
        else:
            self.code += """
            ;; Get node.data.value INT
            %{0} = call i32 @funk_get_node_value_int(%struct.tnode* {node}, i32 {offset})
            """.format(p[0], node=node, offset=offset)

        return '%{}'.format(p[0])

    def set_node_data_value(self, name, node, value, as_type, offset=0):

        if as_type == funk_types.double:
            self.code += """
        ERROR Un-implemented
         """.format(node=node, value=self.enconde_double_to_ieee754_32(value), name=name)
        else:
            self.code += """
        ;; {name}.data.value = {value} -- int
          call void @funk_set_node_value_int(%struct.tnode* {node}, i32 {offset}, i32 {value})
        """.format(node=node, value=value, name=name, offset=offset)

            #raise Exception('Unsupported type {}'.format(type))

    def get_node_data_type(self, node, ret_i8=False, offset=0):

        if ret_i8:
            p = [x for x in range(self.index, self.index + 1)]
            self.index = p[-1] + 1
            self.code += """
            ;;Get node.data.type
            %{0} = alloca i8, align 1
            call void @funk_get_node_type(%struct.tnode* {node}, i32 {offset}, i8* %{0})
            """.format(p[0],  node=node, offset=offset)

        else:
            p = [x for x in range(self.index, self.index + 3)]
            self.index = p[-1] + 1
            self.code += """
            ;;Get node.data.type (i32)
            %{0} = alloca i8, align 1
            call void @funk_get_node_type(%struct.tnode* {node}, i32 {offset}, i8* %{0})
            %{1} = load i8, i8* %{0}, align 1
            %{2} = zext i8 %{1} to i32

            """.format(p[0], p[1], p[2], node=node, offset=offset)

        return '%{}'.format(p[-1])

    def set_node_data_type(self, name, node, type):
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1
        self.code += """
        ;; {name}.data.type = '{type_string}\'
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
        %{1} = getelementptr inbounds %struct.tdata, %struct.tdata* %{0}, i32 0, i32 0
        store i8 {type}, i8* %{1}, align 8
        """.format(p[0], p[1], node=node, type=type, name=name, type_string=funk_types.to_str[type])

    def get_node_pointer(self, node):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        ;; get node pointer
        %{0} = load %struct.tnode*, %struct.tnode** {node}, align 8
               """.format(p[0], node=node)

        return '%{}'.format(p[-1])

    def get_node_type(self, node, lit_offset=0):

        p = [x for x in range(self.index, self.index + 5)]
        self.index = p[-1] + 1

        self.code += """
        ;; get_node_type
        %{0} = alloca i32, align 4 ;; offset
        %{1} = alloca i8, align 1 ;; type
        store i32 {offset}, i32* %{0}, align 4
        %{2} = load i32, i32* %{0}, align 4
        call void @funk_get_node_type(%struct.tnode* {node}, i32 %{2}, i8* %{1})
        %{3} = load i8, i8* %{1}, align 4
        %{4} = zext i8 %{3} to i32
        """.format(p[0], p[1], p[2], p[3], p[4], node=node, offset=lit_offset)

        return '%{}'.format(p[-1])

    def get_next_node(self, node):

        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        ;;get the next node (will not copy)
        %{0} = alloca %struct.tnode, align 8
        ;;; ARE WE SURE WE CAN PASS node LIKE THAT???
        call void @funk_get_next_node(%struct.tnode* %{0}, %struct.tnode* {node})
        """.format(p[0],  node=node)

        return '%{}'.format(p[0])

    def fcmp_signed(self, operation, a, b, result=None):
        return self.arith_helper(a, b, operation, result)

    def icmp_signed(self, operation, a, b, result=None):
        return self.arith_helper(a, b, operation, result)

    def boolean_op(self, operation, a, b, result=None):
        return self.arith_helper(a, b, operation, result)

    def external_function(self, name):
        self.code += """
                declare void {name}(%struct.tnode*, %struct.tnode*, i32)
                """.format(name=name)

    def noop(self):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = add i1 0, 0
        """.format(p[0])

    def br(self, label_true):
        self.code += """
        br label %{label_true}
        """.format(label_true=label_true)

    def br_cond_reg(self, reg, label_true, label_false):
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1]
        self.code += """
        br i1 {reg}, label %{label_true}, label %{label_false}
       """.format(reg=reg, label_true=label_true, label_false=label_false)

    def br_cond(self, cond, a, b, label_true, label_false):
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1]
        self.code += """
        %{0} = icmp {cond} i32 {a}, {b}
         br i1 %{0}, label %{label_true}, label %{label_false}
        """.format(p[0], p[1], cond=cond, a=a, b=b, label_true=label_true, label_false=label_false)

    def add_comment(self, comment):
        self.code += """
        ;;;  {}""".format(comment)

    def ret(self):
        self.code += """
        ret void
        """
        self.index += 1

    def add_label(self, label):
        """
        Labels can only be placed at the start of a basic block.
        In other words, they must go directly after a terminator instruction
        """
        self.code += """
    {label}:
        """.format(label=label)

    def add(self, a, b, result=None):
        return self.arith_helper(a, b, 'add', result)

    def sub(self, a, b, result=None):
        return self.arith_helper(a, b, 'sub', result)

    def srem(self, a, b, result=None):
        return self.arith_helper(a, b, 'mod', result)

    def sdiv(self, a, b, result=None):
        return self.arith_helper(a, b, 'div', result)

    def mul(self, a, b, result=None):
        return self.arith_helper(a, b, 'mul', result)

    def arith_lit_helper(self,a,b,operation):
        if operation == 'sub':
            return a-b
        elif operation == 'add':
            return a+b

    def arith_helper(self, a, b, operation, result, idx_r=0, idx_a=0, idx_b=0):
        self.add_comment('{} {} {}'.format(a, operation, b))

        if isinstance(a, int) and isinstance(b, int):
            return self.arith_lit_helper(a,b,operation)

        if result is None:
            result = self.alloc_tnode('{} result'.format(operation), 0, funk_types.function_pool, funk_types.unknown)

        if isinstance(a, int):
            self.code += """
            call void @funk_{operartion}_ri(%struct.tnode* {p_result}, i32 {idx_r}, %struct.tnode* {pA}, i32 {idx_a}, i32 {pB} )
            """.format(p_result=result, pA=b, pB=a, operartion=operation, idx_r=idx_r, idx_a=idx_a)
        elif isinstance(b, int):
            self.code += """
            call void @funk_{operartion}_ri(%struct.tnode* {p_result}, i32 {idx_r}, %struct.tnode* {pA}, i32 {idx_a}, i32 {pB} )
            """.format(p_result=result, pA=a, pB=b, operartion=operation, idx_r=idx_r, idx_a=idx_a)
        elif isinstance(a, float):
            self.code += """
            call void @funk_{operartion}_rf(%struct.tnode* {p_result}, i32 {idx_r}, %struct.tnode* {pA}, i32 {idx_a}, double {pB} )
            """.format(p_result=result, pA=b, pB=a, idx_r=idx_r, idx_a=idx_b, operartion=operation)
        elif isinstance(b, float):
            self.code += """
            call void @funk_{operartion}_rf(%struct.tnode* {p_result}, i32 {idx_r}, %struct.tnode* {pA}, i32 {idx_a}, double {pB} )
            """.format(p_result=result, pA=a, idx_r=idx_r, idx_a=idx_a, pB=b, operartion=operation)
        else:
            self.code += """
            call void @funk_{operartion}_rr(%struct.tnode* {p_result}, i32 {idx_r}, %struct.tnode* {pA}, i32 {idx_a}, %struct.tnode* {pB}, i32 {idx_b} )
            """.format(p_result=result, pA=a, pB=b, operartion=operation, idx_r=idx_r, idx_a=idx_a, idx_b=idx_b)

        return result

    def store_val(self, p_data, val):
        self.code += """
        store i32 {val}, i32* %{p_data}, align 4
        """.format(val=val, p_data=p_data)

    def copy_node(self, node_src, node_dst):
        self.code += """
        ;; copy node
        call void @funk_copy_node(%struct.tnode* {dst}, %struct.tnode* {src} )
        """.format(dst=node_dst, src=node_src)

    def call_fn_ptr(self, fn_node, arguments, result=None):
        n = len(arguments)

        if result is None:
            result = self.allocate_fn_return_node()

        self.add_comment('Create the argument array')
        array = self.alloc_array_on_stack(n)

        prev = None
        for i in range(n):
            p_element = self.get_array_element(array, i, n)
            self.copy_node(arguments[i], p_element)

        head = self.get_array_element(array, 0, n)

        fn_data = self.get_node_data(fn_node)

        p = [x for x in range(self.index, self.index + 3)]
        self.index = p[-1] + 1
        self.code += """
        ;; call Function Pointer

        %{0} = getelementptr inbounds %struct.tdata, %struct.tdata* {fn_data}, i32 0, i32 1
        %{1} = bitcast %union.data_type* %{0} to void (%struct.tnode*, i32, %struct.tnode*)**
        %{2} = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %{1}, align 8
        call void %{2}(%struct.tnode* {result}, i32 {n}, %struct.tnode* {args})
        """.format(p[0], p[1], p[2], fn_data=fn_data, result=result, n=n, args=head)

        return result

    def allocate_fn_return_node(self):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        ;; allocate the function result node
        %{0} = alloca %struct.tnode, align 8
        call void @funk_create_int_scalar(i32 {pool}, %struct.tnode* %{0},  i32 {val})
        """.format(p[0], val=0, pool=funk_types.function_pool)

        return '%{}'.format(p[0])

    def call_function(self, funk, fn, arguments, result=None):
        if None in arguments:
            print('???')

        self.add_comment('====== call function {} {} ====='.format(fn, arguments))

        extern_name = 'extern::{}'.format(fn)
        if fn in funk.function_debug_name_map:
            name_str, format_len = funk.function_debug_name_map[fn]
        elif extern_name in funk.function_debug_name_map:
            name_str, format_len = funk.function_debug_name_map[extern_name]
        else:
            funk.function_debug_name_map[extern_name] = add_constant_string_symbol(funk,extern_name)
            name_str, format_len =  funk.function_debug_name_map[extern_name]



        self.code += """
        call void @funk_debug_function_entry_hook(i8* getelementptr inbounds ({format_len}, {format_len}* {name_str}, i64 0, i64 0))
        """.format(name_str=name_str, format_len=format_len)

        n = len(arguments)
        self.add_comment('Create the argument array')
        array = self.alloc_array_on_stack(n)

        for i in range(n):
            p_element = self.get_array_element(array, i, n)
            self.copy_node(arguments[i], p_element)

        head = self.get_array_element(array, 0, n)

        if result is None:
            result = self.allocate_fn_return_node()

        self.code += """
         ;;call the function
         call void {fn}(%struct.tnode* {result}, i32 {n}, %struct.tnode* {arguments})
        """.format(result=result, fn=fn, arguments=head, n=n)

        return result

    def set_null_result(self):
        self.set_node_type('%0', funk_types.empty_array)

    def get_result_data_pointer(self):

        p = [x for x in range(self.index, self.index + 2)]

        self.code += """
          ;;; Get a pointer to the pointer to the result
          %{0} = alloca %struct.tnode*, align 8
          store %struct.tnode* %0, %struct.tnode** %{0}, align 8
          ;;Now get the actual data
          %{1} = load %struct.tnode*, %struct.tnode** %{0}, align 8
          """.format(p[0], p[1])

        self.index = p[-1] + 1
        return '%{}'.format(p[1])

    def get_function_argument_tnode(self, idx):
        p = [x for x in range(self.index, self.index + 2)]

        self.code += """
        ;; get Node from pointer
        %{0} = load %struct.tnode*, %struct.tnode** {p_fn_args}, align 8
        %{1} = getelementptr inbounds %struct.tnode, %struct.tnode* %{0}, i32 {idx}
        """.format(p[0], p[1], idx=idx, p_fn_args=self.p_fn_args)

        self.index = p[-1] + 1
        return '%{}'.format(p[-1])

    def alloc_i32(self):
        p = [x for x in range(self.index, self.index + 1)]

        self.code += """
        %{0} = alloca i32, align 4 """.format(p[0])
        self.index = p[-1] + 1
        return '%{}'.format(p[-1])

    def open_function(self, funk, name, arg_count, ret_type='void'):
        self.index = 0
        self.scope_arg_map = {}
        self.scope_result_idx = None
        p = [None]

        funk.function_debug_name_map[name] = add_constant_string_symbol(funk, name)

        if name == 'main':
            self.code += """
@.str_TRACE = private unnamed_addr constant [5 x i8] c"--->\00", align 1


;; ==========================
;; ===
;; ======= M A I N ==========
;; ===
;; ==========================
define i32 @main() #0 {
        call void @funk_init()


            """
            self.index = 1
        else:

            self.index = 4  # number of arguments + result + the first label

            if name == 'sdl_render': name = '@sdl_render'

            self.code += """
;; ======== {fn_name} Function implementation =========
;; The first input argument is a pointer to the result
;; The second argument contains the arity of the function
;; The third argument is a list of nodes containing zero or more arguments


define {ret_type} {fn_name}(%struct.tnode*, i32, %struct.tnode*) #0 {{
        """.format(fn_name=name, ret_type=ret_type)

            self.add_comment('pointer to result')
            p_result = self.alloc_tnode_pointer()

            # TODO: Arity is already a copy, why do I
            # TODO: need yet another copy on the stack?
            self.add_comment('function arity')
            arity = self.alloc_i32()

            self.code += """
        store i32 %1, i32* {arg_count}, align 4

            """.format(arg_count=arity)

            self.add_comment('pointer to argument list')
            p_arglist = self.alloc_tnode_pointer()
            self.p_fn_args = p_arglist

            self.code += """
        store %struct.tnode* %2, %struct.tnode** {p_arglist}, align 8
                """.format(p_arglist=p_arglist)

            # Note that all of the input arguments to the function
            # are copied into a new vector (sequential in memory) under
            # the function stack frame. The reason for this is:
            #   1 - In case of tail recursion we want to update this same vector
            #   2 - We don't wan't the callee to modify the caller's stack thus the copy
            # Note that this does not incur in additional stack space since this
            # is done only once in case of tail recursion (which is the most used
            # pattern in Funk

            self.add_comment('Create the argument array')
            array = self.alloc_array_on_stack(arg_count)

            array_ptr = self.get_array_element(array, 0, arg_count)
            self.code += """
            call void @funk_memcp_arr(%struct.tnode* {dst}, %struct.tnode* {src}, i32 {n}, i8 1)
            """.format(dst=array_ptr, src='%2', n=arg_count)

            self.code += """
            store %struct.tnode* {src}, %struct.tnode** {dst}, align 8
            """.format(src=array_ptr, dst=self.p_fn_args)
            start_label = 'start_{}'.format(name[1:])

            self.br(start_label)
            self.add_label(start_label)

            return arity

    def close_function(self, name):
        if name == 'main':
            self.code += """
        ret i32 0
    }
    """
        else:
            self.code += """
        ;; Remember we return void because a pointer to the result
        ;; is passed as argument
        br label %l_{name}_end
    l_{name}_end:
         ret void
    }}""".format(result=self.scope_result_idx, name=name[1:])

    def enconde_double_to_ieee754_32(self, value):
        # For obscure historical reasons, llvm double literals are represented as
        # if they were doubles, but with the precision of a double.
        # return hex(struct.unpack('Q', struct.pack('d', double(value)))[0])[:-8] + '00000000'
        return value

    def load_global_function_to_data(self, data, global_symbol):
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        self.code += """
        ;; Store pointer to global function: \'{global_symbol}\'
        %{0} = getelementptr inbounds %struct.tdata, %struct.tdata* {data}, i32 0, i32 1
        %{1} = bitcast %union.data_type* %{0} to void (%struct.tnode*, i32, %struct.tnode*)**
        store void (%struct.tnode*, i32, %struct.tnode*)* {global_symbol}, void (%struct.tnode*, i32, %struct.tnode*)**  %{1}, align 8
        """.format(p[0], p[1], data=data, global_symbol=global_symbol)

    def concat_list(self,left,right):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = call %struct.tnode* @funk_concatenate_lists(%struct.tnode* {left}, %struct.tnode* {right})
        """.format(p[0], left=left, right=right)

        return '%{}'.format(p[-1])

    def malloc_right_node(self, ptr_left):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = call %struct.tnode* @funk_mallocNodeRight(%struct.tnode* {ptr_left})
        """.format(p[0], ptr_left=ptr_left)

        return '%{}'.format(p[-1])

    def print_collector_status(self):
        self.code += """
        ;;call void @printCollectorStatus()
        """

    def allocate_in_heap(self):

        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = call i8* @malloc(i32 {tnode_size}) #3
        %{1} = bitcast i8* %{0} to %struct.tnode*

        """.format(p[0], p[1], tnode_size=funk_constants.tnode_size_bytes)

        return '%{}'.format(p[1])

    def alloc_tnode_pointer(self):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = alloca %struct.tnode*, align 8""".format(p[0])

        return '%{}'.format(p[0])

    def set_config_parameter(self, args):

        if len(args) != 2:
            raise Exception('=== set_config_parameter takes 2 parameters')

        id = args[0]
        value = args[1]

        self.code += """
        call void @funk_set_config_param(i32 {}, i32 {})
        """.format(id.eval(), value.eval())

    def alloc_tnode_helper_list(self, size):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1
        self.code += """
                ;;; ====== alloc tnode helper list =====
                %{0} = alloca [{n} x %struct.tnode], align 16
                """.format(p[0], n=size)

        return '%{}'.format(p[0])

    def alloc_expression_list(self, name, expr_list, dimensions, pool):
        n = len(expr_list)
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1
        dst = p[0]
        self.code += """
        ;;; ====== alloc_expression_list {name} =====
        %{0} = alloca [{n} x %struct.tnode], align 16
        """.format(p[0], n=n, name=name)

        for i,expr in enumerate(expr_list):
            p = [x for x in range(self.index, self.index + 1)]
            self.index = p[-1] + 1

            self.code += """
                %{0} = getelementptr inbounds [{n} x %struct.tnode], [{n} x %struct.tnode]* %{dst}, i64 0, i64 {i}
                call void @funk_copy_node(%struct.tnode* %{0}, %struct.tnode* {src} )
                    """.format(p[0], n=n, i=i, dst=dst, src=expr, tnode_size=funk_constants.tnode_size_bytes)

        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        if len(dimensions) == 2:
            self.code += """
             %{0} = getelementptr inbounds [{n} x %struct.tnode], [{n} x %struct.tnode]* %{dst}, i64 0, i64 0
             ;; allocate destination
             %{1} = alloca %struct.tnode, align 8
             call void @funk_create_2d_matrix(%struct.tpool* {pool}, %struct.tnode* %{1}, %struct.tnode* %{0}, i32 {d0}, i32 {d1})
            """.format(p[0], p[1], n=n, d0=dimensions[0], d1=dimensions[1], dst=dst, pool=pool)
        else:
            self.code += """
             %{0} = getelementptr inbounds [{n} x %struct.tnode], [{n} x %struct.tnode]* %{dst}, i64 0, i64 0
             ;; allocate destination
             %{1} = alloca %struct.tnode, align 8
             call void @funk_create_list(%struct.tpool* {pool}, %struct.tnode* %{1}, %struct.tnode* %{0}, i32 {n})
            """.format(p[0], p[1], n=n, dst=dst, pool=pool)

        return '%{}'.format(p[1])

    def regroup_list(self, node_list, n, pool, result=None):
        if result is None:
            result = self.allocate_result()

        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
             %{0} = getelementptr inbounds [{n} x %struct.tnode], [{n} x %struct.tnode]* {list}, i64 0, i64 0
             call void @funk_regroup_list(i32 {pool}, %struct.tnode* {result}, %struct.tnode* %{0}, i32 {n})
            """.format(p[0], result=result,  list=node_list, n=n, pool=pool)

        return result

    def alloc_literal_list(self, name, lit_list, dimensions, pool):
        p = [x for x in range(self.index, self.index + 3)]
        self.index = p[-1] + 1
        A = p[0]
        ptr = p[-1]
        n = len(lit_list)
        self.code += """
        ;; variable \'{name}\': {lit_list}
        %{0} = alloca [{n} x i32], align 16
        %{1} = bitcast [{n} x i32]* %{0} to i8*
        %{2} = bitcast i8* %{1} to [{n} x i32]*
        """.format(p[0], p[1], p[2], name=name, lit_list=lit_list, n=n)

        i = 0
        for lit in lit_list:
            p = [x for x in range(self.index, self.index + 1)]
            self.index = p[-1] + 1
            self.code += """
        %{0} = getelementptr [{n} x i32], [{n} x i32]* %{p}, i64 0, i64 {i}
        store i32 {lit}, i32* %{0}
        """.format(p[0], p=ptr, n=n, lit=lit, i = i)
            i += 1

        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        if len(dimensions) == 2:
            self.code += """
            %{0} = getelementptr inbounds [{n} x i32], [{n} x i32]* %{A}, i32 0, i32 0
            %{1} = alloca %struct.tnode, align 8
            call void @funk_create_2d_matrix_int_literal(i32 {pool}, %struct.tnode* %{1}, i32* %{0}, i32 {N}, i32 {M})

            """.format(p[0], p[1], A=A, name=name, lit_list=lit_list, n=n, pool=pool, N=dimensions[0], M=dimensions[1])
        else:
            self.code += """
            %{0} = getelementptr inbounds [{n} x i32], [{n} x i32]* %{A}, i32 0, i32 0
            %{1} = alloca %struct.tnode, align 8
            call void @funk_create_list_int_literal(i32 {pool}, %struct.tnode* %{1}, i32* %{0}, i32 {n})

            """.format(p[0], p[1], A=A, name=name, lit_list=lit_list, pool=pool, n=dimensions[0])

        return '%{}'.format(p[1])

    def create_slice_lit_2d(self, node, indexes, result=None):
        i,j = indexes[0].eval(), indexes[1].eval()
        if result is None:
            p = [x for x in range(self.index, self.index + 1)]
            self.index = p[-1] + 1
            self.code += """
                   ;; allocate result
                   %{0} = alloca %struct.tnode, align 8
                   """.format(p[0])
            result = '%{}'.format(p[0])

            self.code += """
                ;; create slice
                ;; allocate result
                 call void @funk_create_list_slide_2d_lit(%struct.tnode* {node}, %struct.tnode * {result}, i32 {i}, i32 {j})
            """.format(node=node, result=result, i=i, j=j)

            return result

    def create_slice_lit_index(self, node, indexes, result=None):

        if len(indexes) == 1:
            i = indexes[0].eval()
            self.code += """
                        ;; create slice
                        ;; allocate result
                         call void @funk_create_list_slide_1d_lit(%struct.tnode* {node}, %struct.tnode * {result}, i32 {i})
                    """.format(node=node, result=result, i=i)


        return result

    def allocate_result(self):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1
        self.code += """
       ;; allocate result
       %{0} = alloca %struct.tnode, align 8
       """.format(p[0])
        result = '%{}'.format(p[0])
        return result

    def funk_summation_function(self, funk, args,pool, result=None):
        node = args[0].eval()
        if result is None:
            result = self.alloc_tnode('sum result', 0, pool, funk_types.int)

        self.code += """
                call void @funk_sum_list(%struct.tnode* {node}, %struct.tnode * {result})
               """.format(node=node, result=result)
        return result

    def get_node_lenght_as_int(self,node):
        p = [x for x in range(self.index, self.index + 3)]
        self.index = p[-1] + 1

        self.code += """
        ;; get lenght of node as integer
        %{0} = alloca i32, align 4
        %{1} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
        %{2} = load i32, i32* %{1}, align 4
        store i32 %{2}, i32* %{0}, align 4
        """.format(p[0], p[1], p[2],node=node)

        return '%{}'.format(p[0])

    def add_node_to_nodelist(self, node, node_list, idx_node, n):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1


        self.code += """
        ;;; Add node to C list of nodes
        %{0} = getelementptr inbounds [{n} x %struct.tnode], [{n} x %struct.tnode]* {list}, i64 0, i64 0
        call void @add_node_to_nodelist(%struct.tnode* %{0}, %struct.tnode* {node}, %struct.tnode* {idx}, i32 {n})
        """.format(p[0], node=node, list=node_list, idx=idx_node, n=n)

    def increment_node_value_int(self, node):

        self.code += """
                ;;; Increment the iterator of the loop
                call void @funk_increment_node_data_int(%struct.tnode* {node})
                """.format(node=node)

    def increment_node_len(self, node, delta_len):
        p = [x for x in range(self.index, self.index + 4)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = load i32, i32* {delta_len}, align 4
        %{1} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
        %{2} = load i32, i32* %{1}, align 4
        %{3} = add i32 %{2}, %{0}
        store i32 %{3}, i32* %{1}, align 4
        """.format(p[0],p[1],p[2],p[3],delta_len=delta_len,node=node)


    def get_node_length(self,funk, args,result=None):
        node = args[0].eval()
        if result is None:
            result = self.allocate_result()

        self.code += """

                call void @funk_get_len(%struct.tnode* {node}, %struct.tnode * {result})
               """.format(node=node, result=result)
        return result

    def create_fixed_range_list(self, expr, iterator, range_start, range_end, result):
        if result is None:
            result = self.allocate_result()

        p = [x for x in range(self.index, self.index + 6)]
        self.index = p[-1] + 1
        iterator_reg = p[0]

        self.code += """
        %{iterator_reg} = alloca i32, align 4
          store i32 {range_start}, i32* %{iterator_reg}, align 4
          br label %{1}

        {1}:                                                ; preds = %8, %0
          %{2} = load i32, i32* %{iterator_reg}, align 4
          %{3} = icmp slt i32 %{2}, {range_end}
          br i1 %{3}, label %{4}, label %{10}

        {4}:                                                ; preds = %{1}
          %{5} = load i32, i32* %{iterator_reg}, align 4
        """.format(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],
        range_start=range_start, range_end=range_end, iterator_reg=iterator_reg)

        expr.replace(iterator, iterator_reg).eval(result=result)

        self.code +="""
          %{6} = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.23, i64 0, i64 0), i32 %6)
          br label %{7}

        {7}:                                                ; preds = %5
          %{8} = load i32, i32* %{0}, align 4
          %{9} = add nsw i32 %{8}, 1
          store i32 %{9}, i32* %{iterator_reg}, align 4
          br label %{1}
        {10}:
        """.format(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],
        range_start=range_start, range_end=range_end, iterator_reg=iterator_reg)

        return result

    def create_submatrix(self, node, indexes, result=None):
        if result is None:
            p = [x for x in range(self.index, self.index + 1)]
            self.index = p[-1] + 1
            self.code += """
            ;; allocate result
            %{0} = alloca %struct.tnode, align 8
            """.format(p[0])
            result = '%{}'.format(p[0])


        if len(indexes) == 2:
            r1 = indexes[0].left.eval()
            r2 = indexes[0].right.eval()

            c1 = indexes[1].left.eval()
            c2 = indexes[1].right.eval()
            if isinstance(r1,int) and isinstance(r1,int) and isinstance(c1,int) and isinstance(c2,int):
                self.code += """
                ;; create slice
                 call void @funk_create_sub_matrix_lit_indexes(%struct.tnode* {node}, %struct.tnode * {result}, i32 {r1}, i32 {r2}, i32 {c1}, i32 {c2})
                """.format(node=node, result=result, r1=r1, r2=r2, c1=c1, c2=c2)
            else:
                self.code += """
                ;; create slice
                 call void @funk_create_sub_matrix(%struct.tnode* {node}, %struct.tnode * {result}, %struct.tnode * {r1}, %struct.tnode * {r2}, %struct.tnode * {c1}, %struct.tnode *{c2})
                """.format(node=node, result=result, r1=r1, r2=r2, c1=c1, c2=c2)
        else:
            raise Exception('Not supported')

        return result

    def create_slice(self, node, indexes, result=None):
        if result is None:
            p = [x for x in range(self.index, self.index + 1)]
            self.index = p[-1] + 1
            self.code += """
            ;; allocate result
            %{0} = alloca %struct.tnode, align 8
            """.format(p[0])
            result = '%{}'.format(p[0])

        all_indexes_are_int = True
        for i in indexes:
            if i.get_compile_type() != funk_types.int:
                all_indexes_are_int = False
                break

        if all_indexes_are_int:
            if len(indexes) == 1:
                self.create_slice_lit_index(node, indexes, result)
                return result
            elif len(indexes) == 2:
                self.create_slice_lit_2d(node, indexes, result)
                return result
            else:
                print(indexes, [  i.get_compile_type() for i in indexes])
                raise Exception('Multi-dimensional lit index not implemented')

        if len(indexes) == 1:
            i = indexes[0].eval()

            self.code += """
            ;; create slice
             call void @funk_create_list_slide_1d_var(%struct.tnode* {node}, %struct.tnode * {result}, %struct.tnode * {i})
        """.format( node=node, result=result, i=i)
        elif len(indexes) == 2:
            i = indexes[0].eval()
            j = indexes[1].eval()

            self.code += """
            ;; create slice
             call void @funk_create_list_slide_2d_var(%struct.tnode* {node}, %struct.tnode * {result}, %struct.tnode * {i}, %struct.tnode * {j})
            """.format( node=node, i=i, j=j, result=result)
        else:
            print('ERROR multi-dimension slicing Unimplemented')
            raise

        return result

    def debug_print_node_info(self, node):

        self.code += """
        call void @funk_print_node_info(%struct.tnode* {node})
        """.format(node=node)


    def alloc_tnode(self, name, value, pool, data_type):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        if data_type in [funk_types.int, funk_types.unknown, None]:
            self.code += """
        ;; create tnode '{name}' of type Integer
        %{0} = alloca %struct.tnode, align 8
        call void @funk_create_int_scalar(i32 {pool}, %struct.tnode* %{0},  i32 {val})
        """.format(p[0], val=value, name=name, pool=pool)
        else:
            print('Data type not implemented')

        return '%{}'.format(p[0])

    def set_node_dimensions(self, node, dim):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = alloca [{n} x i32], align 4
        """.format(p[0], n=len(dim))
        dim_array = p[0]

        for d in dim:
            p = [x for x in range(self.index, self.index + 1)]
            self.index = p[-1] + 1
            self.code += """
            %{0} = getelementptr inbounds [{n} x i32], [{n} x i32]* %{dim_array}, i64 0, i64 0
            store i32 {value}, i32* %{0}, align 4
            """.format(p[0], n=len(dim), value=d, dim_array=dim_array)

        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1
        self.code += """
        %{0} = getelementptr inbounds [{n} x i32], [{n} x i32]* %{dim_array}, i64 0, i64 0
        call void @funk_set_node_dimensions(%struct.tnode* {node}, i32* %{0}, i32 {n})
        """.format(p[0], n=len(dim), dim_array=dim_array, node=node)

    def get_array_element(self, array, idx, lenght):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = getelementptr inbounds [{lenght} x %struct.tnode], [{lenght} x %struct.tnode]* {array}, i32 0, i32 {idx}
        """.format(p[0], lenght=lenght, idx=idx, array=array)

        return '%{}'.format(p[-1])

    def alloc_array_on_stack(self, length):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = alloca [{lenght} x %struct.tnode], align 16
            """.format(p[0], lenght=length)

        return '%{}'.format(p[-1])

    def set_array_element(self, array_address, index, data, tail=False):
        self.add_comment(';; >>>>> set_array_element  ')

        if tail:
            type_array = funk_types.empty_array
        else:
            type_array = funk_types.array

        p_node = self.alloc_tnode_pointer()

        self.code += """
         ;; Store the array address into the pointer
         store %struct.tnode* %{array_address}, %struct.tnode** %{0}, align 8
        """.format(p_node, array_address=array_address)

        self.set_node_type(p_node, funk_types.array, index)

        self.set_node_data(p_node, data, index)

    def print_trace(self):
        p = [x for x in range(self.index, self.index + 1)]

        self.code += """
                ;;Print a string
                %{0} = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([{format_len} x i8], [{format_len} x i8]* @.str_TRACE , i32 0, i32 0))""".format(
            p[0], format_len=5)

        self.index = p[-1] + 1

    def print_dim(self, funk, arg):
        self.code += """
        call void @funk_print_dimension(%struct.tnode* {node})
           """.format(node=arg[0].eval())

    def print_funk(self, funk, args):
        if args is not None:
            for arg_expr in args:
                arg = arg_expr.eval()

                if arg[:1] != '%':
                    str_reg, format_len = add_constant_string_symbol(funk, arg)

                    p = [x for x in range(self.index, self.index + 1)]


                    self.code += """
            ;;Print a string
            %{0} = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ({format_len}, {format_len}* {str_reg} , i32 0, i32 0))""".format(
                        p[0], format_len=format_len, str_reg=str_reg)



                    self.index = p[-1] + 1
                else:

                    self.code += """
        call void @print_scalar(%struct.tnode* {node})
            """.format(node=arg)

        p = [x for x in range(self.index, self.index + 1)]
        self.code += """
        ;; EOL
        %{0} = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str_DISP_EOL, i32 0, i32 0))
        ;;============ [END] Print ====
        """.format(p[0])
        self.index = p[-1] + 1

    def init_stack_variable(self, node):

        self.code += """
        call void @createLhsStackVar(%struct.tnode* {node})
        """.format(node=node)

    def alloc_variable_linked_list(self, start, end, expr):
        start_val = self.get_node_data_value(start)
        end_val = self.get_node_data_value(end)

        if isinstance(expr, funk_ast.IntegerConstant):
            p = [x for x in range(self.index, self.index + 1)]
            self.code += """
                    ;;
                    %{0} = call %struct.tnode* @funk_CreateLinkedListConstInt(i32 {start}, i32 {end}, i32 {val})

                    """.format(p[0], start=start_val, end=end_val,
                               val=expr.eval())
            self.index = p[-1] + 1
            return '%{}'.format(p[0])
        else:
            start_type = self.get_node_data_type(start, ret_i8=True)

            p = [x for x in range(self.index, self.index + 1)]
            self.code += """
            ;;
            %{0} = call %struct.tnode* @createLinkedList(i32 {start}, i32 {end}, i8 zeroext {type})

            """.format(p[0], start=start_val, end=end_val,
                       type=start_type)
            self.index = p[-1] + 1
            return '%{}'.format(p[0])

    def rand_int(self, funk, args):
        if len(args) != 2:
            raise Exception('=== rand_int takes 2 parameters')

        lower, upper = args

        p = [x for x in range(self.index, self.index + 1)]
        self.code += """
              ;;
              %{0} = call i32 @rand_int(i32 {lower}, i32 {upper})

              """.format(p[0], lower=lower.eval(), upper=upper.eval())
        self.index = p[-1] + 1

        return '%{}'.format(p[0])


    def rand_double(self, funk, args, result=None):
        if len(args) != 2:
            raise Exception('=== rand_double takes 2 parameters')

        lower, upper = args

        p = [x for x in range(self.index, self.index + 1)]
        self.code += """
        ;;
        %{0} = call double @rand_double(double {lower}, double {upper})
        """.format(p[0], lower=lower.eval(), upper=upper.eval())
        self.index = p[-1] + 1

        node_val = '%{}'.format(p[-1])

        if result is None:
            result = self.alloc_tnode(name='rand_double_result', value=node_val, data_type=funk_types.double)
        else:
            self.set_node_data_value('rand_double_result', result, node_val, as_type=funk_types.double)

        return result

    def sdl_create_window(self, funk, args):
        if len(args) != 3:
            raise Exception('sdl_create_window takes 3 arguments')
        w = args[0].eval()
        h = args[1].eval()
        node = args[2].eval()

        self.code += """
        call void @funk_sdl_create_window(i32 {w}, i32 {h}, %struct.tnode* {node})
        """.format(w=w, h=h, node=node)

    def sdl_render_callback(self,funk,args):
        if len(args) != 1:
            raise Exception('=== sdl_render_callback takes 1 parameter')

        global_state = args[0].eval()
        self.code += """
        ;; sdl_render_callback
        call void @set_sdl_user_global_state(%struct.tnode* {global_state})

        """.format(global_state=global_state)

    def sdl_rect(self, funk, args):
        if len(args) != 4:
            raise Exception('=== sdl_rect takes 4 parameters')
        x = args[0].eval()
        y = args[1].eval()
        w = args[2].eval()
        h = args[3].eval()

        self.code += """
                call void @sdl_rect(%struct.tnode* {x}, %struct.tnode* {y}, %struct.tnode* {w}, %struct.tnode* {h})
                """.format(x=x,y=y,w=w,h=h)

    def sdl_set_color(self, funk, args):
        if len(args) != 3:
            raise Exception('=== sdl_set_color takes 3 parameters')

        r = args[0].eval()
        g = args[1].eval()
        b = args[2].eval()

        self.code += """
                call void @sdl_set_color(%struct.tnode* {r}, %struct.tnode* {g}, %struct.tnode* {b})
                """.format(r=r, g=g, b=b)

    def reshape(self, funk, args, result):
        if isinstance(args[0],str):
            node = args[0]
        else:
            node = args[0].eval(result)
        lit_list = args[1:][0].elements

        p = [x for x in range(self.index, self.index + 3)]
        self.index = p[-1] + 1

        ptr = p[-1]
        n = len(lit_list)
        self.code += """

       %{0} = alloca [{n} x i32], align 16
       %{1} = bitcast [{n} x i32]* %{0} to i8*
       %{2} = bitcast i8* %{1} to [{n} x i32]*
       """.format(p[0], p[1], p[2], lit_list=lit_list, n=n)

        i = 0
        for lit in lit_list:
            lit = lit.eval()
            p = [x for x in range(self.index, self.index + 1)]
            self.index = p[-1] + 1
            self.code += """
        %{0} = getelementptr [{n} x i32], [{n} x i32]* %{p}, i64 0, i64 {i}
        store i32 {lit}, i32* %{0}
        """.format(p[0], p=ptr, n=n, lit=lit, i = i)
            i += 1

        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1
        self.code += """
         %{0} = getelementptr inbounds [{n} x i32], [{n} x i32]* %{ptr}, i32 0, i32 0
         call void @reshape(%struct.tnode* {node}, i32* %{0}, i32 {n})

         """.format(p[0], ptr=ptr, node=node, n=n)

        return node

    def fread_list(self, funk, args, result, pool=funk_types.global_pool):
        if len(args) != 1:
            raise Exception('=== fread_list takes 1 parameter')

        path = args[0].eval()
        format_len = len(path) + 1

        funk.preamble += \
            """
@.str_{cnt} = private unnamed_addr constant [{format_len} x i8] c"{format_string}\00", align 1
            """.format(cnt=funk.strings_count, format_len=format_len, format_string=path)

        if result is not None:
            self.code += """

                call void @funk_read_list_from_file(i32 {pool}, %struct.tnode* {result}, i8* getelementptr inbounds ([{format_len} x i8], [{format_len} x i8]* @.str_{cnt} , i32 0, i32 0))""".format(
                result=result, format_len=format_len, cnt=funk.strings_count, pool=pool)
        else:
            p = [i for i in range(self.index, self.index + 1)]
            self.code += """
                    %{0} = alloca %struct.tnode, align 8
                    call void @funk_read_list_from_file(i32 {pool}, %struct.tnode* %{0}, i8* getelementptr inbounds ([{format_len} x i8], [{format_len} x i8]* @.str_{cnt} , i32 0, i32 0))""".format(
                p[0], format_len=format_len, cnt=funk.strings_count, pool=pool)

            self.index = p[-1] + 1
        funk.strings_count += 1

        if result is not None:
            return result
        else:
            return '%{}'.format(p[0])

    def exit(self, funk, args):
        if len(args) != 0:
            raise Exception('=== exit takes 0 parameter')

        self.code += """
                call void @funk_exit()
                """

    def sleep(self, funk, args):

        if len(args) != 1:
            raise Exception('=== sleep takes 1 parameter')

        useconds = args[0]

        self.code += """
        call void @funk_sleep(i32 {useconds})
        """.format(useconds=useconds.eval())


