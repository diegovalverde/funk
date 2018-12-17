import funk_types
import struct
import re


#depends on bitstring

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

    def get_node_data_value(self, node):
        p = [x for x in range(self.index, self.index + 4)]
        self.index = p[-1] + 1
        self.code += """
        ;; Get node.data.value
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
        %{1} = getelementptr inbounds %struct.tdata, %struct.tdata* %{0}, i32 0, i32 1
        %{2} = bitcast %union.data_type* %{1} to i32*
        %{3} = load i32, i32* %{2}, align 8
        """.format(p[0], p[1], p[2], p[3], node=node)

        return '%{}'.format(p[-1])

    def set_node_data_value(self, name, node, value):
        p = [x for x in range(self.index, self.index + 3)]
        self.index = p[-1] + 1
        self.code += """
        ;; {name}.data.value = {value}
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 1
        %{1} = getelementptr inbounds %struct.tdata, %struct.tdata* %{0}, i32 0, i32 1
        %{2} = bitcast %union.data_type* %{1} to i32*
        store i32 {value}, i32* %{2}, align 8
        """.format(p[0], p[1], p[2], node=node, value=value, name=name)

    def get_node_data_type(self, node):
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

    def set_node_next(self, p_node,p_node_next):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        ;; set next node
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* %{p_node}, i32 0, i32 2
        store %struct.tnode* %{p_node_next}, %struct.tnode** %{0}, align 8
        """.format(p[0],p_node=p_node, p_node_next=p_node_next)

    def get_node_type(self, node):

        p = [x for x in range(self.index, self.index + 3)]
        self.index = p[-1] + 1

        self.code +="""
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
        call void @llvm.memcpy.p0i8.p0i8.i64(i8* %{3}, i8* %{4}, i64 32, i32 8, i1 false)
        """.format(p[0], p[1], p[2], p[3], p[4], node=node)

        return '%{}'.format(p[0])

    def icmp_signed(self, val_rhs, val_lhs, result=None):
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = icmp eq i32 {val_rhs}, {val_lhs}
        %{1} = zext i1 %{0} to i32
        """.format(p[0], p[1], val_rhs=val_rhs, val_lhs=val_lhs)

        return "%{}".format(p[-1])

    def srem(self, node, lit):
        self.add_comment('{} MOD {}'.format(node, lit))
        val = self.get_node_data_value(node)

        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = srem i32 {val} , {lit}
        """.format(p[0], val=val, lit=lit)

        return '%{}'.format(p[-1])

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

    def br_cond(self, cond, a, b, label_true, label_false):
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1]
        self.code += """
        %{0} = icmp {cond} i32 {a}, {b}
         br i1 %{0}, label %{label_true}, label %{label_false}
        """.format(p[0], p[1], cond=cond, a=a, b=b, label_true=label_true, label_false=label_false)

    def add_comment(self,comment):
        self.code += """
        ;;;  {}""".format(comment)

    def ret(self):
        self.code += """
        ret void
        """
        self.index += 1

    def add_label(self,label):
        """
        Labels can only be placed at the start of a basic block.
        In other words, they must go directly after a terminator instruction
        """
        self.code += """
    {label}:
        """.format(label=label)

    def add(self, a, b, result_data=None):

        if result_data is None:
            result = self.alloc_tnode('addition result' )

        if isinstance(a, int):
            self.code += """
            call void @funk_add_ri(%struct.tnode* {p_result},  %struct.tnode* {pA}, i32 {pB} )
            """.format(p_result=result, pA=b, pB=a)
        elif isinstance(b, int):
            self.code += """
            call void @funk_add_ri(%struct.tnode* {p_result},  %struct.tnode* {pA}, i32 {pB} )
            """.format(p_result=result, pA=a, pB=b)
        else:
            self.code += """
            call void @funk_add_rr(%struct.tnode* {p_result},  %struct.tnode* {pA}, %struct.tnode* {pB} )
            """.format(p_result=result, pA=a, pB=b)

        return result

    def sub(self, a, b, result_data=None):

        if result_data is None:
            result = self.alloc_tnode('subtraction result' )

        if isinstance(a, int):
            self.code += """
            call void @funk_sub_ri(%struct.tnode* {p_result},  %struct.tnode* {pA}, i32 {pB} )
            """.format(p_result=result, pA=b, pB=a)
        elif isinstance(b, int):
            self.code += """
            call void @funk_sub_ri(%struct.tnode* {p_result},  %struct.tnode* {pA}, i32 {pB} )
            """.format(p_result=result, pA=a, pB=b)
        else:
            self.code += """
            call void @funk_sub_rr(%struct.tnode* {p_result},  %struct.tnode* {pA}, %struct.tnode* {pB} )
            """.format(p_result=result, pA=a, pB=b)

        return result

    def store_val(self,p_data,val):
        self.code += """
        store i32 {val}, i32* %{p_data}, align 4
        """.format(val=val, p_data=p_data)

    def copy_node(self, node_src, node_dst):
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        self.code += """
        ;; copy 
        %{0} = bitcast %struct.tnode* {node_dst} to i8*
        %{1} = bitcast %struct.tnode* {node_src} to i8*
        call void @llvm.memcpy.p0i8.p0i8.i64(i8* %{0}, i8* %{1}, i64 32, i32 8, i1 false)
        """.format(p[0], p[1], node_dst=node_dst, node_src=node_src)

    def call_fn_ptr(self, fn_node, arguments):
        n=len(arguments)

        result = self.allocate_fn_return_node()

        self.add_comment('Create the argument array')
        array = self.alloc_array(n)

        prev = None
        for i in range(n):
            p_element = self.get_array_element(array, i, n)
            self.copy_node(arguments[i], p_element)

        head = self.get_array_element(array, 0, n)

        fn_data = self.get_node_data(fn_node)

        p = [x for x in range(self.index, self.index + 3)]
        self.index = p[-1] + 1
        self.code += """
        %{0} = getelementptr inbounds %struct.tdata, %struct.tdata* {fn_data}, i32 0, i32 1
        %{1} = bitcast %union.data_type* %{0} to void (%struct.tnode*, i32, %struct.tnode*)**
        %{2} = load void (%struct.tnode*, i32, %struct.tnode*)*, void (%struct.tnode*, i32, %struct.tnode*)** %{1}, align 8
        call void %{2}(%struct.tnode* {result}, i32 {n}, %struct.tnode* {args})
        """.format(p[0], p[1], p[2], fn_data=fn_data, result=result, n=n, args=head)

    def allocate_fn_return_node(self):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        ;; allocate the function result node
        %{0} = alloca %struct.tnode, align 8
        """.format(p[0])

        return '%{}'.format(p[0])

    def call(self, fn, arguments):
        self.add_comment('====== call function {} {}'.format(fn, arguments))

        n = len(arguments)
        self.add_comment('Create the argument array')
        array = self.alloc_array(n)

        for i in range(n):
            p_element = self.get_array_element(array, i, n)
            self.copy_node(arguments[i], p_element)

        head = self.get_array_element(array, 0, n)

        result = self.allocate_fn_return_node()

        self.code += """
         ;;call the function
         call void {fn}(%struct.tnode* {result}, i32 {n}, %struct.tnode* {arguments})
        """.format(result=result, fn=fn, arguments=head, n=n)

    def get_result_pointer(self):

        p = [x for x in range(self.index, self.index + 4)]

        self.code += """     
              ;;; Get a pointer to the pointer to the result
              %{0} = alloca %struct.tnode*, align 8
              store %struct.tnode* %0, %struct.tnode** %{0}, align 8
              ;;Now get the actual data
              %{1} = load %struct.tnode*, %struct.tnode** %{0}, align 8
              %{2} = getelementptr inbounds %struct.tnode, %struct.tnode* %{1}, i32 0, i32 1
              ;;**** %{3} has the pointer to result data ****
              %{3} = load %struct.tdata*, %struct.tdata** %{2}, align 8


              """.format(p[0], p[1], p[2], p[3])

        self.index = p[-1] + 1

    def get_function_argument_tnode(self, idx):
        p = [x for x in range(self.index, self.index + 2)]

        self.code +="""
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

    def open_function(self, name, ret_type='void'):
        self.index = 0
        self.scope_arg_map = {}
        self.scope_result_idx = None
        p = [None]

        if name == 'main':
            self.code += """
;; ==========================
;; ===            
;; ======= M A I N ==========
;; ===            
;; ==========================
define i32 @main() #0 {
            """
            self.index = 1
        else:

            self.index = 4  # number of arguments + result + the first label



            self.code += """
;; ======== {fn_name} Function implementation =========
;; The first input argument is a pointer to the result
;; The second argument is a list of nodes containing zero or more arguments
;; Arguments are 

define {ret_type} {fn_name}(%struct.tnode*, i32, %struct.tnode*) #0 {{
        """.format(fn_name=name,  ret_type=ret_type)

            self.add_comment('pointer to result')
            p_result = self.alloc_tnode_pointer()

            self.add_comment('function arity')
            arity = self.alloc_i32()

            self.code += """
        store i32 %1, i32* {arg_count}, align 4
        
            """.format(arg_count=arity)

            self.add_comment('pointer to argument list')
            p_arglist = self.alloc_tnode_pointer()

            self.code += """
        store %struct.tnode* %2, %struct.tnode** {p_arglist}, align 8
            """.format(p_arglist=p_arglist)

            self.p_fn_args = p_arglist

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
         ret void
    }}""".format(result=self.scope_result_idx)

    def enconde_float_to_ieee754_32(self, value):
        # For obscure historical reasons, llvm float literals are represented as
        # if they were doubles, but with the precision of a float.
        return hex(struct.unpack('Q', struct.pack('d', float(value)))[0])[:-8] + '00000000'

    def load_global_function_to_data(self, data, global_symbol):
        p = [x for x in range(self.index, self.index + 2)]
        self.index = p[-1] + 1

        self.code += """
        ;; Store pointer to global function: \'{global_symbol}\'
        %{0} = getelementptr inbounds %struct.tdata, %struct.tdata* {data}, i32 0, i32 1
        %{1} = bitcast %union.data_type* %{0} to void (%struct.tnode*, i32, %struct.tnode*)**
        store void (%struct.tnode*, i32, %struct.tnode*)* {global_symbol}, void (%struct.tnode*, i32, %struct.tnode*)**  %{1}, align 8
        """.format(p[0], p[1], data=data, global_symbol=global_symbol)

    def alloc_tnode_pointer(self):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
        %{0} = alloca %struct.tnode*, align 8""".format(p[0])

        return '%{}'.format(p[0])

    def alloc_tnode(self, name, value=None, data_type=None, node_type=None):
        p = [x for x in range(self.index, self.index + 1)]

        self.code +="""
         ;; variable \'{name}\': allocate tnode
         %{0} = alloca %struct.tnode, align 8
         """.format(p[0], name=name)

        node = '%{}'.format(p[0])

        self.index = p[-1] + 1
        if value is not None:
            self.set_node_data_value(name, node, value)

        if data_type is not None:
            self.set_node_data_type(name, node, data_type)

        if node_type is not None:
            self.set_node_type(node, node_type)

        return node

    def get_array_element(self, array, idx, lenght):
        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code +="""
        %{0} = getelementptr inbounds [{lenght} x %struct.tnode], [{lenght} x %struct.tnode]* {array}, i64 0, i64 {idx}
        """.format(p[0], lenght=lenght, idx=idx, array=array)

        return '%{}'.format(p[-1])

    def alloc_array(self, length):
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
            self.set_next_node(p_node, index+1)

    def set_next_node(self, node, next_node):

        p = [x for x in range(self.index, self.index + 1)]
        self.index = p[-1] + 1

        self.code += """
         ;; Set linked list next element
        %{0} = getelementptr inbounds %struct.tnode, %struct.tnode* {node}, i32 0, i32 2
        store %struct.tnode* {next_node}, %struct.tnode** %{0}, align 8
         """.format(p[0],  next_node=next_node, node=node)

    def print_funk(self, funk, args):
        """
        Just call 1 print for each argument...
        disp('I am a float ', x ,'and I am an int', y)
        """

        for arg_expr in args:
            arg = arg_expr.eval()


            if arg[:1] != '%':
                format_string = arg
                format_len = len(format_string)+1
                p = [x for x in range(self.index, self.index + 1)]
                funk.preamble += \
                    """
@.str_{cnt} = private unnamed_addr constant [{format_len} x i8] c"{format_string}\00", align 1
                    """.format(cnt=funk.strings_count, format_len=format_len, format_string=format_string)


                self.code += """
        ;;Print a string         
        %{0} = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([{format_len} x i8], [{format_len} x i8]* @.str_{cnt} , i32 0, i32 0))""".format(p[0], format_len=format_len, cnt=funk.strings_count)

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