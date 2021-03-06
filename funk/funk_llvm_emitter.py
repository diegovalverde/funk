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


class Emitter:
    def __init__(self):
        self.index = 1
        self.code = ''
        self.scope_arg_map = {}
        self.scope_result_idx = None
        self.p_fn_args = None

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

    def get_node_data_value(self, node, as_type=funk_types.int):
        p = [x for x in range(self.index, self.index + 4)]
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
            ;; Get node.data.value
            %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
            %{1} = getelementptr inbounds %struct.tdata, %struct.tdata* %{0}, i32 0, i32 1
            %{2} = bitcast %union.data_type* %{1} to i32*
            %{3} = load i32, i32* %{2}, align 8
            """.format(p[0], p[1], p[2], p[3], node=node)

        return '%{}'.format(p[-1])

    def set_node_data_value(self, name, node, value, as_type):
        p = [x for x in range(self.index, self.index + 3)]
        self.index = p[-1] + 1

        if as_type == funk_types.double:
            self.code += """
        ;; {name}.data.value = {value} -- double
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
        %{1} = getelementptr inbounds %struct.tdata, %struct.tdata* %{0}, i32 0, i32 1
        %{2} = bitcast %union.data_type* %{1} to double*
        store double {value}, double* %{2}, align 8
         """.format(p[0], p[1], p[2], node=node, value=self.enconde_double_to_ieee754_32(value), name=name)
        else:
            self.code += """
        ;; {name}.data.value = {value} -- int
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
        %{1} = getelementptr inbounds %struct.tdata, %struct.tdata* %{0}, i32 0, i32 1
        %{2} = bitcast %union.data_type* %{1} to i32*
        store i32 {value}, i32* %{2}, align 8
        """.format(p[0], p[1], p[2], node=node, value=value, name=name)

            #raise Exception('Unsupported type {}'.format(type))



    def get_node_data_type(self, node, ret_i8=False):

        if ret_i8:
            p = [x for x in range(self.index, self.index + 3)]
            self.index = p[-1] + 1
            self.code += """
            ;;Get node.data.type
            %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
            %{1} = getelementptr inbounds %struct.tdata, %struct.tdata* %{0}, i32 0, i32 0
            %{2} = load i8, i8* %{1}, align 8
            """.format(p[0], p[1], p[2], node=node)

        else:
            p = [x for x in range(self.index, self.index + 4)]
            self.index = p[-1] + 1
            self.code += """
            ;;Get node.data.type
            %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
            %{1} = getelementptr inbounds %struct.tdata, %struct.tdata* %{0}, i32 0, i32 0
            %{2} = load i8, i8* %{1}, align 8
            %{3} = zext i8 %{2} to i32
            """.format(p[0], p[1], p[2], p[3], node=node)

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

    def get_node_type(self, node):

        p = [x for x in range(self.index, self.index + 3)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 0
        %{1} = load i8, i8* %{0}, align 8
        %{2} = zext i8 %{1} to i32
        """.format(p[0], p[1], p[2], node=node)

        return '%{}'.format(p[-1])

    def get_next_node(self, node):

        p = [x for x in range(self.index, self.index + 5)]
        self.index = p[-1] + 1

        self.code += """
        ;;return a copy of the next node from list
        %{0} = alloca %struct.tnode, align 8
        %{1} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 2
        %{2} = load %struct.tnode*, %struct.tnode** %{1}, align 8
        %{3} = bitcast %struct.tnode* %{0} to i8*
        %{4} = bitcast %struct.tnode* %{2} to i8*
        call void @memcpy(i8* align 8  %{3}, i8* align 8  %{4}, i64 {tnode_size}, i1 false)
        """.format(p[0], p[1], p[2], p[3], p[4], node=node, tnode_size=funk_constants.tnode_size_bytes)

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

    def arith_helper(self, a, b, operation, result):
        self.add_comment('{} {} {}'.format(a, operation, b))

        if result is None:
            result = self.alloc_tnode('{} result'.format(operation))

        if isinstance(a, int):
            self.code += """
            call void @funk_{operartion}_ri(%struct.tnode* {p_result},  %struct.tnode* {pA}, i32 {pB} )
            """.format(p_result=result, pA=b, pB=a, operartion=operation)
        elif isinstance(b, int):
            self.code += """
            call void @funk_{operartion}_ri(%struct.tnode* {p_result},  %struct.tnode* {pA}, i32 {pB} )
            """.format(p_result=result, pA=a, pB=b, operartion=operation)
        elif isinstance(a, float):
            self.code += """
            call void @funk_{operartion}_rf(%struct.tnode* {p_result},  %struct.tnode* {pA}, double {pB} )
            """.format(p_result=result, pA=b, pB=a, operartion=operation)
        elif isinstance(b, float):
            self.code += """
            call void @funk_{operartion}_rf(%struct.tnode* {p_result},  %struct.tnode* {pA}, double {pB} )
            """.format(p_result=result, pA=a, pB=b, operartion=operation)
        else:
            self.code += """
            call void @funk_{operartion}_rr(%struct.tnode* {p_result},  %struct.tnode* {pA}, %struct.tnode* {pB} )
            """.format(p_result=result, pA=a, pB=b, operartion=operation)

        return result

    def store_val(self, p_data, val):
        self.code += """
        store i32 {val}, i32* %{p_data}, align 4
        """.format(val=val, p_data=p_data)

    def copy_node(self, node_src, node_dst):
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        self.code += """
        ;; copy node
        %{0} = bitcast %struct.tnode* {node_dst} to i8*
        %{1} = bitcast %struct.tnode* {node_src} to i8*
        call void @memcpy(i8* align 8  %{0}, i8* align 8  %{1}, i64 {tnode_size}, i1 false)
        """.format(p[0], p[1], node_dst=node_dst, node_src=node_src, tnode_size=funk_constants.tnode_size_bytes)

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
        """.format(p[0])

        return '%{}'.format(p[0])

    def call_function(self, fn, arguments, result=None):
        self.add_comment('====== call function {} {}'.format(fn, arguments))

        n = len(arguments)
        self.add_comment('Create the argument array')
        array = self.alloc_array_on_stack(n)

        for i in range(n):
            p_element = self.get_array_element(array, i, n)
            self.copy_node(arguments[i], p_element)

        head = self.get_array_element(array, 0, n)

        if result is None:
            result = self.allocate_fn_return_node()
            self.set_node_data_type('result', result, funk_types.int)

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
        %{1} = getelementptr inbounds %struct.tnode, %struct.tnode* %{0}, i64 {idx}
        """.format(p[0], p[1], idx=idx, p_fn_args=self.p_fn_args)

        self.index = p[-1] + 1
        return '%{}'.format(p[-1])

    def alloc_i32(self):
        p = [x for x in range(self.index, self.index + 1)]

        self.code += """
        %{0} = alloca i32, align 4 """.format(p[0])
        self.index = p[-1] + 1
        return '%{}'.format(p[-1])

    def open_function(self, name, arg_count, ret_type='void'):
        self.index = 0
        self.scope_arg_map = {}
        self.scope_result_idx = None
        p = [None]

        if name == 'main':
            self.code += """
@.str_TRACE = private unnamed_addr constant [5 x i8] c"--->\00", align 1


;; ==========================
;; ===
;; ======= M A I N ==========
;; ===
;; ==========================
define i32 @main() #0 {
        call void @init_random_seed()

        ;; Init the garbage collector
        call void @initGarbageCollector()
            """
            self.index = 1
        elif name == 's2d_render':
            self.index = 1
            self.code += """
define void @s2d_render() #0 {
            """


        else:

            self.index = 4  # number of arguments + result + the first label

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

    def mark_node_for_garbage_collection(self, reg):
        self.code += """
        call void @markNodeForGarbageCollection(%struct.tnode* {reg})
        """.format(reg=reg)

    def garbage_collector_register_allocation(self, ptr):
        self.code += """

       call void @registerHeapAllocation(%struct.tnode* {ptr})
       """.format(ptr=ptr)

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

    def collect_garbage(self):
        self.print_collector_status()
        self.code += """
        call void @collectGarbage()
        """

    def allocate_in_heap(self):

        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = call i8* @malloc(i64 {tnode_size}) #3
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

    def alloc_tnode(self, name, value=None, data_type=None, node_type=None):
        p = [x for x in range(self.index, self.index + 1)]

        self.code += """
         ;; variable \'{name}\': allocate tnode
         %{0} = alloca %struct.tnode, align 8
         """.format(p[0], name=name)

        node = '%{}'.format(p[0])

        self.index = p[-1] + 1
        if value is not None:
            self.set_node_data_value(name, node, value, data_type)

        if data_type is not None:
            self.set_node_data_type(name, node, data_type)

        if node_type is not None:
            self.set_node_type(node, node_type)
        else:
            self.set_node_type(node,  funk_types.scalar)

        return node

    def get_array_element(self, array, idx, lenght):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = getelementptr inbounds [{lenght} x %struct.tnode], [{lenght} x %struct.tnode]* {array}, i64 0, i64 {idx}
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

        if not tail:
            self.set_next_node(p_node, index + 1)

    def set_next_node(self, node, next_node):

        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
         ;; Set linked list next element
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 2
        store %struct.tnode* {next_node}, %struct.tnode** %{0}, align 8
         """.format(p[0], next_node=next_node, node=node)

    def print_trace(self):
        p = [x for x in range(self.index, self.index + 1)]

        self.code += """
                ;;Print a string
                %{0} = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([{format_len} x i8], [{format_len} x i8]* @.str_TRACE , i32 0, i32 0))""".format(
            p[0], format_len=5)

        self.index = p[-1] + 1


    def print_funk(self, funk, args):

        for arg_expr in args:
            arg = arg_expr.eval()

            if arg[:1] != '%':
                format_string = arg
                format_len = len(format_string) + 1
                p = [x for x in range(self.index, self.index + 1)]
                funk.preamble += \
                    """
@.str_{cnt} = private unnamed_addr constant [{format_len} x i8] c"{format_string}\00", align 1
                    """.format(cnt=funk.strings_count, format_len=format_len, format_string=format_string)

                self.code += """
        ;;Print a string
        %{0} = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([{format_len} x i8], [{format_len} x i8]* @.str_{cnt} , i32 0, i32 0))""".format(
                    p[0], format_len=format_len, cnt=funk.strings_count)

                funk.strings_count += 1

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

    def get_s2d_user_global_state(self, dst):

        self.code += """
         ;;
         call void @get_s2d_user_global_state(%struct.tnode* noalias sret {})
         """.format(dst)

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

    def s2d_create_window(self, funk, args):

        window_name = args[0].eval()
        width = args[1].eval()
        height = args[2].eval()

        format_len = len(window_name) + 1

        funk.preamble += \
            """
@.str_{cnt} = private unnamed_addr constant [{format_len} x i8] c"{format_string}\00", align 1
            """.format(cnt=funk.strings_count, format_len=format_len, format_string=window_name)
        p = [x for x in range(self.index, self.index + 4)]
        self.code += """
        ;;Call simple2D create window
        %{0} = alloca i32, align 4
        %{1} = alloca %struct.S2D_Window*, align 8
        store i32 0, i32* %{0}, align 4
        %{2} = call %struct.S2D_Window* @S2D_CreateWindow(i8* getelementptr inbounds ([{format_len} x i8], [{format_len} x i8]* @.str_{cnt}, i32 0, i32 0), i32 {width}, i32 {height}, void (...)* null, void (...)* bitcast (void ()* {callback_fn} to void (...)*), i32 0)
        store %struct.S2D_Window* %{2}, %struct.S2D_Window** %{1}, align 8
        %{3} = load %struct.S2D_Window*, %struct.S2D_Window** %{1}, align 8
       
        """.format(
            p[0], p[1], p[2], p[3], format_len=format_len, cnt=funk.strings_count, height=height, width=width,
            callback_fn='@s2d_render')

        funk.strings_count += 1
        self.index = p[-1] + 1
        return p[3]

    def s2d_draw_line(self, funk, args):
        if len(args) != 9:
            raise Exception('=== s2d_draw_line takes 9 parameters')

        x1, y1, x2, y2, r, g, b, alpha, width = args

        x1 = self.get_node_data_value(x1.eval(), as_type=funk_types.double)
        x2 = self.get_node_data_value(x2.eval(), as_type=funk_types.double)
        y1 = self.get_node_data_value(y1.eval(), as_type=funk_types.double)
        y2 = self.get_node_data_value(y2.eval(), as_type=funk_types.double)

        p = [x for x in range(self.index, self.index + 4)]
        self.index = p[-1] + 1

        self.code += """
            %{0} = fptrunc double {x1} to float
            %{1} = fptrunc double {y1} to float
            %{2} = fptrunc double {x2} to float
            %{3} = fptrunc double {y2} to float
            call void @S2D_DrawLine(float %{0}, float %{1}, float %{2}, float %{3}, float {width}, float {r}, float {g},float {b}, float {alpha}, float {r}, float {g}, float {b}, float {alpha}, float {r}, float {g}, float {b}, float {alpha}, float {r}, float {g}, float {b}, float {alpha})
            """.format(p[0], p[1], p[2], p[3], x1=x1, x2=x2, y1=y1, y2=y2,
                       r=float(r.eval()), g=float(g.eval()), b=float(b.eval()), alpha=float(alpha.eval()),
                       width=float(width.eval()))

    def s2d_draw_point(self, funk, args):
        if len(args) != 6:
            raise Exception('=== s2d_draw_point takes 6 parameters')

        x1, y1, r, g, b, alpha = args
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        self.code += """
            %{0} = fptrunc double {x1} to float
            %{1} = fptrunc double {y1} to float
            call void @S2D_DrawCircle(float %{0}, float %{1}, float 1.0, i32 4, float {r}, float {g}, float {b}, float {alpha})
            """.format(p[0], p[1], x1=x1, y1=y1, r=float(r), g=g, b=b, alpha=alpha)

    def s2d_render_callback(self, funk, args):
        if len(args) > 1:
            raise Exception('=== s2d_render_callback takes 0 or 1 parameters')

        if len(args) > 0:
            global_state = args[0].eval()
            self.code += """
            ;; s2d_render_callback
            call void @set_s2d_user_global_state(%struct.tnode* {global_state})

            """.format(global_state=global_state)

        if funk.function_scope.name == 'main':
            self.add_comment('DUMMY CALL @s2d_render')
            p = [x for x in range(self.index, self.index + 1)]
            self.index = p[-1] + 1

            self.code += """
            %{0} = call i32 @S2D_Show( %struct.S2D_Window * %{s2d_window})
            """.format(p[0], s2d_window=funk.window)

    def s2d_quad(self, funk, args):
        if len(args) != 12:
            raise Exception('=== s2d_quad takes 12 parameters')

        v = []
        for arg in args:
            if isinstance(arg, funk_ast.DoubleConstant):
                x = arg.eval()
            elif isinstance(arg, funk_ast.IntegerConstant):
                x = float(arg.eval())
            else:

                x = arg.eval()
                p = [i for i in range(self.index, self.index + 1)]
                self.code += """
                %{0} = call float @funk_ToFloat(%struct.tnode* {x})
                """.format(p[0], x=x)
                x = '%{}'.format(p[-1])
                self.index = p[-1] + 1


            v.append(x)

        self.code += """
        ;; s2d_quad
        call void @S2D_DrawQuad( float {x1}, float {y1},float {r}, float {g}, float {b}, float {alpha},float {x2}, \
        float {y2},float {r}, float {g}, float {b}, float {alpha},float {x3}, float {y3},float {r}, float {g}, \
        float {b}, float {alpha},float {x4}, float {y4},float {r}, float {g}, float {b}, float {alpha})
        """.format(
                x1=v[0], y1=v[1], x2=v[2], y2=v[3], x3=v[4], y3=v[5], x4=v[6],
                y4=v[7], r=v[8], g=v[9], b=v[10], alpha=v[11])

    def fread_list(self, funk, args, result):
        if len(args) != 1:
            raise Exception('=== fread_list takes 1 parameter')

        path = args[0].eval()
        format_len = len(path) + 1

        funk.preamble += \
            """
@.str_{cnt} = private unnamed_addr constant [{format_len} x i8] c"{format_string}\00", align 1
            """.format(cnt=funk.strings_count, format_len=format_len, format_string=path)

        p = [i for i in range(self.index, self.index + 1)]
        self.code += """
                
                %{0} = call %struct.tnode* @funk_read_list_from_file(i8* getelementptr inbounds ([{format_len} x i8], [{format_len} x i8]* @.str_{cnt} , i32 0, i32 0))""".format(
            p[0], format_len=format_len, cnt=funk.strings_count)

        self.index = p[-1] + 1
        funk.strings_count += 1

        if result is not None:
            q = [i for i in range(self.index, self.index + 2)]
            self.code += """
            %{0} = bitcast %struct.tnode* {src} to i8*
            %{1} = bitcast %struct.tnode* %{dst} to i8*
            call void @memcpy(i8* align 8 %{0}, i8* align 8 %{1}, i64 40, i1 false)
            """.format(q[0], q[1], src=result, dst=p[0])

            self.index = q[-1] + 1
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


