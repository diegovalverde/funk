from funk_llvm_emitter import Emitter
import funk_types


class IntegerConstant:
    def __init__(self, funk,  value):
        self.value = value
        self.funk = funk
        self.type = funk_types.int

    def __repr__(self):
        return 'Integer({})'.format(self.value)

    def eval(self, result=None):
        return int(self.value)


class FloatConstant:
    def __init__(self, funk, value):
        self.value = value
        self.funk = funk
        self.type = funk_types.float

    def __repr__(self):
        return 'Float({})'.format(self.value)

    def eval(self, result=None):
        return float(self.value)


class ArrayLiteral:
    """
    Essentially a NULL terminated linked list
    """
    def __init__(self, funk, name, elements):
        self.funk = funk
        self.name = name
        self.elements = elements

    def __repr__(self):
        return 'ArrayLiteral({})'.format(self.elements)


    def eval(self, result=None):

        return self.elements


class Identifier:
    def __init__(self, funk, name):
        self.funk = funk
        self.name = name
        self.is_literal = False

    def __repr__(self):
        return 'Identifier({})'.format(self.name)

    def eval(self, result=None):
        # Check the current function that we are building
        # To see if the identifier is a function argument

        for arg in self.funk.function_scope.args:
            if arg == self.name:
                idx = self.funk.function_scope.args.index(arg)
                node = self.funk.emitter.get_function_argument_tnode(idx)
                return node

        for head_tail in self.funk.function_scope.tail_pairs:
            head, tail = head_tail
            if self.name == tail:
                idx = self.funk.function_scope.args.index(head)
                head_node = self.funk.emitter.get_function_argument_tnode(idx)
                tail_node = self.funk.emitter.get_next_node(head_node)
                return tail_node


        global_symbol_name = '@{}'.format(self.name)
        local_symbol_name = '{}__{}'.format(self.funk.function_scope.name, self.name)

        # Now check to see if it is a local (function scope) variable
        if local_symbol_name in self.funk.symbol_table:
            return self.funk.symbol_table[local_symbol_name]

        if global_symbol_name in self.funk.symbol_table:
            self.funk.emitter.add_comment('creating reference to global function {}'.format(global_symbol_name))
            node = self.funk.emitter.alloc_tnode('global_symbol_ref', value=0, data_type=funk_types.function)
            data = self.funk.emitter.get_node_data(node)
            self.funk.emitter.load_global_function_to_data(data, global_symbol_name)
            return node

        return global_symbol_name


class HeadTail:
    def __init__(self, funk, head=None, tail=None):
        self.funk = funk
        self.head = head.name
        self.tail = tail.name
        self.is_literal = False

    def __repr__(self):
        return 'HeadTail({},{})'.format(self.head, self.tail)

    def eval(self, result=None):
        print('$$$$$$$$$$$$$$$$ !!!!!! pop_arg_head')
        pass


class PatternMatch:
    def __init__(self, funk):
        self.funk = funk
        self.is_literal = True
        self.position = None

    def __repr__(self):
        return 'PatternMatch()'


class PatternMatchEmptyList(PatternMatch):
    def __init__(self, funk):
        self.funk = funk
        self.is_literal = False

    def __repr__(self):
        return 'PatternMatchEmptyList()'

    def eval(self, result=None):
        pass


class PatternMatchLiteral(PatternMatch):
    def __init__(self, funk, value):
        self.funk = funk
        self.value = value.eval()

        if isinstance(value, IntegerConstant):
            self.type = funk_types.int
        elif isinstance(value, FloatConstant):
            self.type = funk_types.float
        else:
            self.type = funk_types.invalid

        self.is_literal = True

    def __repr__(self):
        return 'PatternMatchLiteral({})'.format(self.value)

    def eval(self, result=None):
        pass


class PatternMatchIdentifier:
    def __init__(self, funk, name):
        self.funk = funk
        self.name = name
        self.is_literal = False

    def __repr__(self):
        return 'PatternMatchIdentifier({})'.format(self.name)

    def eval(self, result=None):
        pass

class BinaryOp:
    def __init__(self, funk, left=None, right=None):
        self.funk = funk
        self.left = left
        self.right = right


class Sum(BinaryOp):
    def __repr__(self):
        return 'Sum({} , {})'.format(self.left, self.right)

    def eval(self, result=None):

        return self.funk.emitter.add(self.left.eval(), self.right.eval(), result_data=result)


class Mul(BinaryOp):
    def __repr__(self):
        return 'Mul({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.mul(self.left.eval(), self.right.eval())


class Sub(BinaryOp):
    def __repr__(self):
        return 'Sub({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        i = self.funk.emitter.sub(self.left.eval(), self.right.eval())
        return i


class Div(BinaryOp):
    def __repr__(self):
        return 'Div({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.sdiv(self.left.eval(), self.right.eval())


class Mod(BinaryOp):
    def __repr__(self):
        return 'Mod({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.srem(self.left.eval(), self.right.eval())


class GreaterThan(BinaryOp):
    def __repr__(self):
        return 'GreaterThan({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        i = self.funk.emitter.icmp_signed('>', self.left.eval(), self.right.eval())
        return i


class EqualThan(BinaryOp):
    def __repr__(self):
        return 'Equal({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.icmp_signed(self.left.eval(), self.right.eval())


class And(BinaryOp):
    def __repr__(self):
        return 'And({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.and_( self.left.eval(), self.right.eval())


class LessThan(BinaryOp):
    def __repr__(self):
        return 'LessThan({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.icmp_signed('<', self.left.eval(), self.right.eval())


class Assignment(BinaryOp):
    def __repr__(self):
        return 'Assignment({} , {})'.format(self.left, self.right)


    def eval(self, result=None):
        name = self.left.name

        symbol_name = '{}__{}'.format(self.funk.function_scope.name, name)

        if symbol_name in self.funk.symbol_table:
            raise Exception('=== Variables are immutable \'{}\' '.format(name))

        if isinstance(self.right, IntegerConstant) or isinstance(self.right, FloatConstant):
            self.funk.symbol_table[symbol_name] = self.funk.emitter.alloc_tnode(symbol_name, self.right.eval(),
                                                                                self.right.type)
        elif isinstance(self.right, ArrayLiteral):
            elements = self.right.eval()
            n = len(elements)
            prev = None
            head = None
            node = None
            for i in range(n):

                node = self.funk.emitter.alloc_tnode(name='list[{}]'.format(i),
                                                    value=elements[i].eval(),
                                                     data_type=funk_types.int,
                                                    node_type=funk_types.array)
                if prev is not None:
                    self.funk.emitter.set_next_node(prev, node)
                else:
                    head = node
                    
                prev = node

            tail = self.funk.emitter.alloc_tnode(name='list_tail',
                                                 node_type=funk_types.empty_array)

            self.funk.emitter.set_next_node(node, tail)
            self.funk.symbol_table[symbol_name] = head


        else:
            allocation = self.funk.emitter.alloc_tdata(symbol_name)
            self.funk.symbol_table[symbol_name] = '{}'.format(allocation)
            self.right.eval(result=allocation)

        return

class FunctionCall:
    def __init__(self, funk, name, args):
        self.funk = funk
        self.name = name
        self.args = args

    def __repr__(self):
        return 'FunctionCall({})'.format(self.name)

    def eval(self, result=None):
        found = False
        name = '@{}'.format(self.name)

        if self.name == 'say':

            p = Print(self.funk, self.args)
            return p.eval()

        # First check if this is globally defined function
        for fn in self.funk.functions:
            if fn == name:
                return self.funk.emitter.call(fn, [a.eval() for a in self.args])
        # Now check if this is an input argument containing a function pointer
        i = 0
        for arg in self.funk.function_scope.args:
            if arg == self.name:
                fn = self.funk.emitter.get_function_argument_tnode(i)
                return self.funk.emitter.call_fn_ptr(fn, [a.eval() for a in self.args])
            i += 1

        if not found:
            raise Exception('Undeclared function \'{}\' '.format(self.name))

        return None


class FunctionClause:
    def __init__(self, funk, name, fn_body, preconditions, pattern_matches, tail_pairs=[], arguments=[]):
        self.body = fn_body
        self.name = name
        self.arguments = arguments
        self.preconditions = preconditions
        self.pattern_matches = pattern_matches
        self.tail_pairs = tail_pairs
        self.funk = funk

    def emit(self, index, arity):
        if self.name == 'main':
            for stmt in self.body:
                stmt.eval()

        else:

            # print('-I- Emitting clause ', self.arguments, self.name, self.pattern_matches, self.pattern_matches)
            # I need some kind of clause_exit_label here...
            # check for clause arity
            name = self.name[1:]
            clause_entry_label = '{}_{}_clause_entry'.format(name, index)
            clause_exit_label = '{}_{}_clause_exit'.format(name, index)
            clause_pm_label = '{}_{}_pattern_match'.format(name, index)

            # check for arity

            label_next = clause_pm_label
            if self.pattern_matches is None or len(self.pattern_matches) == 0:
                label_next = clause_entry_label

            self.funk.emitter.br_cond('eq', '%1', len(self.arguments), label_next, clause_exit_label)

            # check for clause pattern matches
            if self.pattern_matches is not None and len(self.pattern_matches) != 0:
                self.funk.emitter.add_label(clause_pm_label)
                self.funk.emitter.add_comment('{}'.format(self.pattern_matches))

                pm_count = 0
                for pattern in self.pattern_matches:
                    self.funk.emitter.add_comment('{}'.format(self.arguments))
                    arg = self.funk.emitter.get_function_argument_tnode(pattern.position)
                    last = pm_count + 1 == len(self.pattern_matches)

                    if last:
                        label_next = clause_entry_label
                    else:
                        label_next = '{}_clause_{}_pattern_match_{}'.format(name, index, pm_count)

                    if isinstance(pattern, PatternMatchEmptyList):
                        node_type = self.funk.emitter.get_node_type( arg )
                        self.funk.emitter.br_cond('ne', node_type, funk_types.empty_array, clause_exit_label,
                                                  label_next)

                    elif isinstance(pattern, PatternMatchLiteral):
                        label_match_literal_check_value = '{}_clause_{}_pattern_match_literal_check_value_{}'.format(
                            name, index, pm_count)
                        data_type = self.funk.emitter.get_node_data_type(arg)
                        self.funk.emitter.br_cond('ne', data_type, pattern.type, clause_exit_label,
                                                  label_match_literal_check_value)

                        self.funk.emitter.add_label(label_match_literal_check_value)
                        value = self.funk.emitter.get_node_data_value(arg)
                        self.funk.emitter.br_cond('ne', value, pattern.value, clause_exit_label, label_next)

                    if not last:
                        self.funk.emitter.add_label(label_next)


            # check for clause preconditions
            if self.preconditions is not None:
                print('Preconditions ', self.preconditions)

            self.funk.function_scope.args = self.arguments
            self.funk.function_scope.tail_pairs = self.tail_pairs


            self.funk.emitter.add_comment('========= Emitting clause {} ========'.format(index))
            self.funk.emitter.add_label(clause_entry_label)


            for stmt in self.body:
                stmt.eval()

            self.funk.emitter.ret()

            self.funk.emitter.br(clause_exit_label)
            self.funk.emitter.add_label(clause_exit_label)



class FunctionMap:
    def __init__(self, funk, name, arguments=[], tail_pairs=[], pattern_matches=[]):
        self.funk = funk
        self.name = name
        self.arity = len(arguments)
        self.clauses = [] # list of clauses
        self.arguments = arguments
        self.tail_pairs = tail_pairs
        self.pattern_matches = pattern_matches

    def eval(self, result=None):
        scope_name = self.funk.create_function_scope(self.name, args=self.arguments, tail_pairs=self.tail_pairs,
                                                     empty=True)

        self.funk.set_function_scope(scope_name)

        # Now implement the function
        arity = self.funk.emitter.open_function(self.name)

        index = 0
        for clause in self.clauses:
            clause.emit(index, arity)
            index += 1

        self.funk.emitter.close_function(self.funk.function_scope.name)

        return scope_name

    def emit_main(self):
        for stmt in self.body:
            stmt.eval()

class String:
    def __init__(self, funk, fmt_str):
        self.funk = funk
        self.fmt_str = '{}'.format(fmt_str[1:-1])

    def set_builder(self, builder):
        self.builder = builder

    def __repr__(self):
        return 'String({})'.format(self.fmt_str)

    def eval(self, result=None):
        return self.fmt_str


class Print:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):

        self.funk.emitter.print_funk(self.funk, self.arg_list)
