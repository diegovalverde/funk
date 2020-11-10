# -*- coding: utf-8 -*-
#
# Copyright (C) 2020 Diego Valverde
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
import collections
import copy

def list_concat_tail(funk, left, right, result=None):
    """
    This corresponds to:
        [X] ~> [MyArray]

    Note that this operation will allocate the resulting
    list in the Heap.

    """

    funk.emitter.add_comment('Concatenating two arrays')
    ptr_left = left.eval(result=result)
    ptr_right = right.eval()

    return funk.emitter.concat_list(ptr_left, ptr_right)


def list_concat_head(funk, left, right, result=None):
    """
    This corresponds to:
        X ~> [MyArray]

    Note that this operation will allocate the resulting
    list in the Heap.

    """

    funk.emitter.add_comment('Concatenating head to array')
    ptr_left = left.eval(result=result)


def create_ast_named_symbol(name, funk, right):
    symbol_name = '{}_{}_{}'.format(funk.function_scope.name, funk.function_scope.clause_idx, name)

    if symbol_name in funk.symbol_table:
        print('symbol table', funk.symbol_table)
        raise Exception('=== Variables are immutable \'{}\' '.format(name))

    if isinstance(right, List):
        funk.symbol_table[symbol_name] = right.eval()
    elif isinstance(right, IntegerConstant) or isinstance(right, DoubleConstant):
        funk.symbol_table[symbol_name] = funk.alloc_literal_symbol(right, funk_types.global_pool, symbol_name)
    else:
        funk.symbol_table[symbol_name] = funk.create_variable_symbol(right, symbol_name)

    if isinstance(right, FunctionCall) or isinstance(right, List):
        funk.function_scope.lhs_symbols.append(funk.symbol_table[symbol_name])


def create_ast_anon_symbol(funk, right):
    if isinstance(right, IntegerConstant) or isinstance(right, DoubleConstant):
        return funk.alloc_literal_symbol(right, funk_types.global_pool, 'anon_list')
    else:
        return right.eval()


class Expression:
    def __init__(self):
        self.args = None

    def replace_symbol(self, symbol, value):
        pass

class IntegerConstant:
    def __init__(self, funk, value):
        self.value = value
        self.funk = funk
        self.sign = 1

    def replace_symbol(self, symbol, value):
        pass

    def get_compile_type(self):
        return funk_types.int

    def __repr__(self):
        return 'Integer({})'.format(self.value)

    def eval(self, result=None):
        val = self.sign * int(self.value)
        if result is not None:
            self.funk.emitter.set_node_data_value('result element', result, val, as_type=funk_types.int)


        return val

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return IntegerConstant(self.funk, value=copy.deepcopy(self.value, memo))

class DoubleConstant:
    def __init__(self, funk, value):
        self.value = value
        self.funk = funk
        self.sign = 1

    def replace_symbol(self, symbol, value):
        pass

    def get_compile_type(self):
        return funk_types.double

    def __repr__(self):
        return 'DoubleConstant({})'.format(self.value)

    def eval(self, result=None):
        val = self.sign * float(self.value)
        if result is not None:
            self.funk.emitter.set_node_data_value('result element', result, val, as_type=funk_types.double)
            self.funk.emitter.set_node_data_type('result element', result, funk_types.double)

        return val

class List(Expression):
    def __init__(self, funk, name, elements):
        self.funk = funk
        self.name = name
        self.elements = elements

    def replace_symbol(self, symbol, value):
        for element in self.elements:
            element.replace_symbol(symbol, value)

    def get_dimensions(self):
        def traverse(x, dimensions=[]):
            elements = []
            if isinstance(x, collections.Iterable): elements = x
            elif isinstance(x, List): elements = x.elements
            dimensions.append(len(elements))

            if len(elements) >0 and isinstance(elements[0],List) or isinstance(elements[0], collections.Iterable):
                return traverse(elements[0], dimensions)
            return dimensions

        if len(self.elements) == 0:
            return [1]

        return traverse(self)

    def flatten(self,x):
        if isinstance(x, collections.Iterable):
            return [a for i in x for a in self.flatten(i)]
        elif isinstance(x, List):
            return [a for i in x.elements for a in self.flatten(i)]
        else:
            return [x]

    def __repr__(self):
        return 'List({})'.format(self.elements)

class VariableList(List):
    """
    Essentially a NULL terminated linked list
    """

    def __init__(self, funk, name, start, end, start_inclusive, end_inclusive, expr):
        self.funk = funk
        self.name = name
        self.start = start
        self.end = end
        self.start_inclusive = start_inclusive == '<='
        self.end_inclusive = end_inclusive == '<='
        self.expr = expr

    def __repr__(self):
        return 'VariableList({},{})'.format(self.start, self.end)

    def eval(self, result=None):
        start = self.start.eval()
        end = self.end.eval()

        if not self.start_inclusive:
            start = self.funk.emitter.add(start, 1)

        if not self.end_inclusive:
            end = self.funk.emitter.sub(end, 1)

        return self.funk.alloc_variable_list_symbol(start, end, self.expr)

class FixedSizeExpressionList(List):
    def __init__(self, funk, name, elements):
        self.funk = funk
        self.name = name
        self.elements = elements

    def __repr__(self):
        return 'FixedSizeExpressionList({})'.format(self.elements)

    def eval(self, result=None):
        dimensions = self.get_dimensions()
        flattened_list = self.flatten(self.elements)

        expression_list = []
        for element in flattened_list:
            expression_list.append(element.eval(result=result))

        return self.funk.emitter.alloc_expression_list(name=self.name, expr_list=expression_list, dimensions=dimensions)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return FixedSizeExpressionList(self.funk, name=self.name, elements=copy.deepcopy(self.elements, memo))

class FixedSizeLiteralList(List):

    def __init__(self, funk, name, elements):
        self.funk = funk
        self.name = name
        self.elements = elements

    def eval(self, result=None):

        dimensions = self.get_dimensions()
        flattened_list = self.flatten(self.elements)

        literal_list = []
        for element in flattened_list:
            literal_list.append(element.eval(result=result))


        return self.funk.alloc_literal_list_symbol(literal_list, dimensions)

    def __repr__(self):
        return 'FixedSizeLiteralList({})'.format(self.elements)

    def eval(self, result=None):

        dimensions = self.get_dimensions()
        flattened_list = self.flatten(self.elements)

        literal_list = []
        for element in flattened_list:
            literal_list.append(element.eval(result=result))


        return self.funk.alloc_literal_list_symbol(literal_list, dimensions)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return FixedSizeLiteralList(self.funk, name=self.name, elements=copy.deepcopy(self.elements, memo))

class Identifier:
    def __init__(self, funk, name, indexes=None):
        self.funk = funk
        self.indexes = indexes # indexes for multidimensional array

        if name == '_':
            self.name = '_{}'.format(self.funk.empty_arg_count)
            self.funk.empty_arg_count += 1
        else:
            self.name = name
        self.is_literal = False

    def get_compile_type(self):
        return None

    def __repr__(self):
        string = 'Identifier({})'.format(self.name)
        if self.indexes is not None:
            string += '{}'.format(self.indexes)

        return string

    def eval_node_index(self,node):
        if self.indexes is not None:
            return self.funk.emitter.create_slice(node, self.indexes)
        else:
            return node

    def eval(self, result=None):
        # Check the current function that we are building
        # To see if the identifier is a function argument



        for arg in self.funk.function_scope.args:
            if arg == self.name:
                idx = self.funk.function_scope.args.index(arg)
                node = self.funk.emitter.get_function_argument_tnode(idx)
                if result is not None:
                    self.funk.emitter.copy_node(node, result)
                return self.eval_node_index(node)

        for head_tail in self.funk.function_scope.tail_pairs:
            head, tail = head_tail
            if self.name == tail:
                idx = self.funk.function_scope.args.index(head)
                head_node = self.funk.emitter.get_function_argument_tnode(idx)
                tail_node = self.funk.emitter.get_next_node(head_node)
                if result is not None:
                    self.funk.emitter.copy_node(tail_node, result)
                return tail_node

        global_symbol_name = '@{}'.format(self.name)
        local_symbol_name = '{}_{}_{}'.format(self.funk.function_scope.name, self.funk.function_scope.clause_idx,
                                              self.name)

        # Now check to see if it is a local (function scope) variable
        if local_symbol_name in self.funk.symbol_table:
            node = self.funk.symbol_table[local_symbol_name]
            if result is not None:
                self.funk.emitter.copy_node(node, result)
            return self.eval_node_index(node)

        if global_symbol_name in self.funk.symbol_table:
            self.funk.emitter.add_comment('creating reference to global function {}'.format(global_symbol_name))
            node = self.funk.emitter.alloc_tnode('global_symbol_ref', value=0, data_type=funk_types.function)
            data = self.funk.emitter.get_node_data(node)
            self.funk.emitter.load_global_function_to_data(data, global_symbol_name)
            if result is not None:
                self.funk.emitter.copy_node(node, result)
            return self.eval_node_index(node)

        if 'sd2_render_user_state' in self.funk.function_scope.args:
            node = self.funk.emitter.alloc_tnode('tmp_sd2_render_user_state')
            self.funk.emitter.get_s2d_user_global_state(node)
            if result is not None:
                self.funk.emitter.copy_node(node, result)
            return self.eval_node_index(node)

        return global_symbol_name

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Identifier(self.funk, name=self.name, indexes=copy.deepcopy(self.indexes, memo))

    def replace_symbol(self, symbol, value):
        if self.indexes is not None:
            for i in range(len(self.indexes)):
                if self.indexes[i].__repr__() == symbol.__repr__():
                    self.indexes[i] = value
                else:
                    self.indexes[i].replace_symbol(symbol, value)


class HeadTail:
    def __init__(self, funk, head=None, tail=None):
        self.funk = funk
        self.head = head.name
        self.tail = tail.name
        self.is_literal = False

    def __repr__(self):
        return 'HeadTail({},{})'.format(self.head, self.tail)

    def eval(self, result=None):
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
        PatternMatch.__init__(self, funk)
        self.funk = funk
        self.is_literal = False

    def __repr__(self):
        return 'PatternMatchEmptyList()'

    def eval(self, result=None):
        pass

class PatternMatchLiteral(PatternMatch):
    def __init__(self, funk, value):
        PatternMatch.__init__(self, funk)
        self.funk = funk
        self.value = value.eval()

        if isinstance(value, IntegerConstant):
            self.type = funk_types.int
        elif isinstance(value, DoubleConstant):
            self.type = funk_types.double
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

class BinaryOp(Expression):
    def __init__(self, funk, left=None, right=None):
        self.funk = funk
        self.left = left
        self.right = right

    def replace_symbol(self, symbol, value):

        if self.left.__repr__() == symbol.__repr__():
            self.left = value
        else:
            self.left.replace_symbol(symbol, value)

        if self.right.__repr__() == symbol.__repr__():
            self.right = value
        else:
            self.right.replace_symbol(symbol, value)

    def get_compile_type(self):
        # if either operand is float, then auto promote to float at compile time
        if isinstance(self.right, DoubleConstant) or isinstance(self.left, DoubleConstant):
            return funk_types.double
        else:
            return funk_types.int

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return BinaryOp(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))

class Sum(BinaryOp):
    def __repr__(self):
        return 'Sum({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.add(self.left.eval(), self.right.eval(), result=result)

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return Sum(self.funk, left=copy.deepcopy(self.left, memo), right=copy.deepcopy(self.right, memo))

class Mul(BinaryOp):
    def __repr__(self):
        return 'Mul({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.mul(self.left.eval(), self.right.eval(), result=result)

class Sub(BinaryOp):
    def __repr__(self):
        return 'Sub({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        i = self.funk.emitter.sub(self.left.eval(), self.right.eval(), result=result)
        return i

class Div(BinaryOp):
    def __repr__(self):
        return 'Div({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.sdiv(self.left.eval(), self.right.eval(), result)

class Mod(BinaryOp):
    def __repr__(self):
        return 'Mod({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.srem(self.left.eval(), self.right.eval(), result)

class And(BinaryOp):
    def __repr__(self):
        return 'And({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.boolean_op('and',self.left.eval(), self.right.eval(), result)

class Or(BinaryOp):
    def __repr__(self):
        return 'Or({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        return self.funk.emitter.boolean_op('or', self.left.eval(), self.right.eval(), result)

class BoolBinaryOp(BinaryOp):
    def eval(self, as_type, result=None):
        lval = self.left.eval()
        rval = self.right.eval()

        return lval, rval

class GreaterThan(BoolBinaryOp):
    def __repr__(self):
        return 'GreaterThan({} , {})'.format('sgt',self.left, self.right)

    def eval(self, result=None):

        if isinstance(self.left, DoubleConstant) or isinstance(self.right, DoubleConstant):
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.double, result=result)
            return self.funk.emitter.fcmp_signed('ogt', l, r)
        else:
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.int, result=result)
            return self.funk.emitter.icmp_signed('sgt', l, r)

class EqualThan(BoolBinaryOp):
    def __repr__(self):
        return 'Equal({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        l, r = BoolBinaryOp.eval(self, result)
        return self.funk.emitter.icmp_signed('eq', l, r)

class LessThan(BoolBinaryOp):
    def __repr__(self):
        return 'LessThan({} , {})'.format(self.left, self.right)

    def eval(self, result=None):

        if isinstance(self.left, DoubleConstant) or isinstance(self.right, DoubleConstant):
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.double, result=result)
            return self.funk.emitter.fcmp_signed('flt', l, r)
        else:
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.int, result=result)
            return self.funk.emitter.icmp_signed('slt', l, r)

class GreaterOrEqualThan(BoolBinaryOp):
    def __repr__(self):
        return 'GreaterOrEqualThan({} , {})'.format(self.left, self.right)

    def eval(self, result=None):

        if isinstance(self.left, DoubleConstant) or isinstance(self.right, DoubleConstant):
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.double, result=result)
            return self.funk.emitter.fcmp_signed('fge', l, r)
        else:
            l, r = BoolBinaryOp.eval(self, as_type=funk_types.int, result=result)
            return self.funk.emitter.icmp_signed('sge', l, r)

class ListConcat(BinaryOp):
    head = 1
    tail = 2

    def __init__(self, funk, left=None, right=None):
        BinaryOp.__init__(self, funk, left, right)
        self.direction = ListConcat.head

    def __repr__(self):
        return 'ListConcatTail({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        if self.direction == ListConcat.tail:
            list_concat_tail(self.funk, self.left, self.right, result=result)
        else:
            list_concat_head(self.funk, self.left, self.right, result=result)

class Assignment(BinaryOp):
    def __repr__(self):
        return 'Assignment({} , {})'.format(self.left, self.right)

    def eval(self, result=None):
        name = self.left.name
        create_ast_named_symbol(name, self.funk, self.right)

class Range:
    def __init__(self, funk, rhs=None, lhs=None, identifier=None, expr=None, rhs_type='<', lhs_type='<'):
        self.funk = funk
        self.identifier = identifier
        self.rhs = rhs
        self.lhs_type = lhs_type
        self.rhs_type = rhs_type
        self.lhs = lhs
        self.expr = expr

    def __repr__(self):
        return 'Range({} | {} {} {} {} {})'.format(self.expr, self.lhs, self.lhs_type, self.identifier, self.rhs_type, self.rhs)

    def eval(self):
        list_elements = []
        range_start = self.lhs.eval()

        if self.lhs_type == '<':
            range_start += 1

        range_end = self.rhs.eval()

        if self.rhs_type == '<=':
            range_end += 1

        if self.expr.__repr__() == self.identifier.__repr__():
            for i in range(range_start, range_end):
                list_elements.append(IntegerConstant(self.funk, i))
                return FixedSizeLiteralList(self.funk, '', list_elements)

        elif isinstance(self.expr, FixedSizeLiteralList):
            #orig_args = copy.copy(self.expr.args)
            for i in range(range_start, range_end):
                list_elements.append( self.expr )
                #list_elements[-1].replace_symbol(self.identifier, IntegerConstant(self.funk, i))
                return FixedSizeLiteralList(self.funk, '', list_elements)
        else:
            for i in range(range_start, range_end):
                list_elements.append( copy.deepcopy(self.expr) )  # the funk pointer is preventing the deepcopy!
                list_elements[-1].replace_symbol(self.identifier, IntegerConstant(self.funk, i))

            return FixedSizeExpressionList(self.funk, 'var_list', list_elements)

class ExternalFunction:
    def __init__(self, funk, name):
        self.funk = funk
        self.name = name

    def __repr__(self):
        return 'ExternalFunction({})'.format(self.name)

    def emit(self):
        return """
declare void {name}(%struct.tnode*, i32,  %struct.tnode*)
                """.format(name=self.name)

class FunctionCall(Expression):
    def __init__(self, funk, name, args):
        self.funk = funk
        self.name = name
        self.args = args

        self.system_functions = {
            'funk_set_config': SetConfigParam,
            'sleep': Sleep,
            'rand_int': RandInt,
            'rand_float': RandFloat,
            'say': Print,
            'dim': Dim,
            's2d_window': S2DCreateWindow,
            's2d_line': S2DDrawLine,
            's2d_point': S2DDrawPoint,
            's2d_quad': S2DDrawQuad,
            's2d_render': S2DRenderFunction,  # void s2d_render(void)
            'exit': Exit,
            'fread_list': FReadList,
        }

    def get_compile_type(self):
        if self.name in self.system_functions:
            return self.system_functions[self.name].get_compile_type()
        else:
            return None

    def __repr__(self):
        return 'FunctionCall({}({}))'.format(self.name, self.args)

    def replace_symbol(self, symbol, value):
        for i, arg in enumerate(self.args):
            if arg.__repr__() == symbol.__repr__():
                self.args[i] = value
            else:
                arg.replace_symbol(symbol, value)

    def eval(self, result=None):
        found = False
        name = '@{}'.format(self.name)

        if self.name in self.system_functions:
            p = self.system_functions[self.name](self.funk, self.args)
            return p.eval(result=result)

        # First check if this is globally defined function
        if name in self.funk.functions:
            return self.funk.emitter.call_function(name, [create_ast_anon_symbol(self.funk, a) for a in self.args], result=result)

        # Now check if this is an input argument containing a function pointer
        i = 0
        for arg in self.funk.function_scope.args:
            if arg == self.name:
                fn = self.funk.emitter.get_function_argument_tnode(i)
                return self.funk.emitter.call_fn_ptr(fn, [create_ast_anon_symbol(self.funk, a) for a in self.args],
                                                     result=result)
            i += 1

        if not found:
            raise Exception('Undeclared function \'{}\' '.format(self.name))

        return None

    def __deepcopy__(self, memo):
        # create a copy with self.linked_to *not copied*, just referenced.
        return FunctionCall(self.funk, name=self.name, args=copy.deepcopy(self.args, memo))

class FunctionClause:
    def __init__(self, funk, name, fn_body, preconditions, pattern_matches, tail_pairs=None, arguments=None):
        if arguments is None:
            arguments = []
        if tail_pairs is None:
            tail_pairs = []
        self.body = fn_body
        self.name = name
        self.arguments = arguments
        self.preconditions = preconditions
        self.pattern_matches = pattern_matches
        self.tail_pairs = tail_pairs
        self.funk = funk

    def emit(self, clause_idx, arity):
        # TODO: refactor
        if self.name in ['main', 's2d_render']:

            for stmt in self.body:
                stmt.eval()

        else:
            start_label = 'start_{}'.format(self.name[1:])

            # print('-I- Emitting clause ', self.arguments, self.name, self.pattern_matches, self.pattern_matches)
            # I need some kind of clause_exit_label here...
            # check for clause arity
            name = self.name[1:]
            clause_entry_label = '{}_{}_clause_entry'.format(name, clause_idx)
            clause_exit_label = '{}_{}_clause_exit'.format(name, clause_idx)
            clause_pm_label = '{}_{}_pattern_match'.format(name, clause_idx)
            clause_precondition_label = '{}_{}_clause_precondition'.format(name, clause_idx)
            self.funk.function_scope.args = self.arguments
            self.funk.function_scope.tail_pairs = self.tail_pairs

            # check for arity
            label_next = clause_entry_label
            if self.pattern_matches is not None and len(self.pattern_matches) != 0:
                label_next = clause_pm_label
            elif self.preconditions is not None:
                label_next = clause_precondition_label
            else:
                label_next = clause_entry_label

            # So the first function arguments is always the pointer to the
            # return value and the second (#1) is the arity (passed as a constant)
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
                        label_next = '{}_clause_{}_pattern_match_{}'.format(name, clause_idx, pm_count)

                    if isinstance(pattern, PatternMatchEmptyList):
                        node_type = self.funk.emitter.get_node_type(arg)
                        self.funk.emitter.br_cond('ne', node_type, funk_types.empty_array, clause_exit_label,
                                                  label_next)

                    elif isinstance(pattern, PatternMatchLiteral):
                        label_match_literal_check_value = '{}_clause_{}_pattern_match_literal_check_value_{}'.format(
                            name, clause_idx, pm_count)
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
                self.funk.emitter.add_label(clause_precondition_label)
                self.funk.emitter.add_comment('{}'.format(self.preconditions))
                result = self.preconditions.eval()
                self.funk.emitter.br_cond('eq', self.funk.emitter.get_node_data_value(result), 1, clause_entry_label, clause_exit_label)


            self.funk.emitter.add_comment('========= Emitting clause {} ========'.format(clause_idx))
            self.funk.emitter.add_label(clause_entry_label)

            for stmt in self.body[:-1]:
                stmt.eval()

            self.funk.emitter.add_comment('This is the last instruction in the function')
            self.funk.emitter.add_comment('The outcome of this instruction becomes the result')

            p_result = self.funk.emitter.get_result_data_pointer()

            last_insn = self.body[-1]
            if isinstance(last_insn, FixedSizeLiteralList) and len(last_insn.elements) == 0:
                # set result to null
                self.funk.emitter.set_null_result()
                self.funk.emitter.br('l_{}_end'.format(name))
            # TODO: if hasinstance_of( FucntionCall, self.name) print('Warning tail recursion could not be done here')
            elif isinstance(last_insn, FunctionCall) and last_insn.name == self.name[1:]:
                self.funk.emitter.add_comment('========== Applying TAIL RECURSION =========')
                # Essentially
                # 1- leave the result pointer alone
                # 2- Store your vals in the pointer to argument list
                # goto <function>_start

                for i in range(len(last_insn.args)):
                    arg_tnode = self.funk.emitter.get_function_argument_tnode(i)
                    val = last_insn.args[i].eval()
                    self.funk.emitter.copy_node(val, arg_tnode)


                self.funk.emitter.br(start_label)
            else:
                last_insn.eval(p_result)
                self.funk.emitter.ret()
                self.funk.emitter.br('l_{}_end'.format(name))

            # Call the garbage collector
            # The way it works is this: we will collect all of the
            # LSH symbols under this function scope that have a refcount <= 0
            # notice that this will not affect the return value since it is an
            # un-named value, thus not part of the function named-symbol list


            self.funk.emitter.ret()

            self.funk.emitter.add_label(clause_exit_label)

class FunctionMap:
    def __init__(self, funk, name, arguments=None, tail_pairs=None, pattern_matches=None):
        if arguments is None:
            arguments = []
        if tail_pairs is None:
            tail_pairs = []
        if pattern_matches is None:
            pattern_matches = []
        self.funk = funk
        self.name = name
        self.arity = len(arguments)
        self.clauses = []  # list of clauses
        self.arguments = arguments
        self.tail_pairs = tail_pairs
        self.pattern_matches = pattern_matches

    def eval(self, result=None):
        scope_name = self.funk.create_function_scope(self.name, args=self.arguments, tail_pairs=self.tail_pairs,
                                                     empty=True)

        self.funk.set_function_scope(scope_name)

        # Now implement the function
        arity = self.funk.emitter.open_function(self.name, len(self.arguments))

        index = 0
        for clause in self.clauses:
            self.funk.function_scope.clause_idx = index
            clause.emit(index, arity)
            index += 1

        self.funk.function_scope.clause_idx = 0

        self.funk.emitter.close_function(self.funk.function_scope.name)

        return scope_name

    def emit_main(self):
        for stmt in self.body:
            stmt.eval()

class String:
    def __init__(self, funk, fmt_str):
        self.funk = funk
        self.fmt_str = '{}'.format(fmt_str[1:-1])

    def __repr__(self):
        return 'String({})'.format(self.fmt_str)

    def eval(self, result=None):
        return self.fmt_str

class Dim:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.print_dim(self.funk, self.arg_list)

class Print:
    def __init__(self, funk, arg):
        self.funk = funk
        self.arg = arg

    def eval(self, result=None):
        self.funk.emitter.print_funk(self.funk, self.arg)

class RandInt:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result=None):
        return self.funk.emitter.rand_int(self.funk, self.arg_list)

class RandFloat:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.double

    def eval(self, result=None):
        return self.funk.emitter.rand_double(self.funk, self.arg_list, result=result)

class SetConfigParam:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result=None):
        return self.funk.emitter.set_config_parameter(self.arg_list)

class FReadList:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result):
        return self.funk.emitter.fread_list(self.funk, self.arg_list, result)

class Exit:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result=None):
        return self.funk.emitter.exit(self.funk, self.arg_list)

class Sleep:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    @staticmethod
    def get_compile_type():
        return funk_types.int

    def eval(self, result=None):
        return self.funk.emitter.sleep(self.funk, self.arg_list)

class S2DCreateWindow:
    """
    Requires Simple2D to be installed.
    https://github.com/simple2d/simple2d

    """

    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.window = self.funk.emitter.s2d_create_window(self.funk, self.arg_list)

class S2DRenderFunction:
    """
        Requires Simple2D to be installed.
        https://github.com/simple2d/simple2d

        """

    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.s2d_render_callback(self.funk, self.arg_list)

class S2DDrawQuad:
    """
            Requires Simple2D to be installed.
            https://github.com/simple2d/simple2d

            """

    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.s2d_quad(self.funk, self.arg_list)

class S2DDrawLine:
    """
        Requires Simple2D to be installed.
        https://github.com/simple2d/simple2d

        """

    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.s2d_draw_line(self.funk, self.arg_list)

class S2DDrawPoint:
    """
            Requires Simple2D to be installed.
            https://github.com/simple2d/simple2d

            """

    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        """
        This function must be provided the raw float/int
        registers
        """
        uwrapped_args = []
        for arg in self.arg_list:
            if isinstance(arg, DoubleConstant) or isinstance(arg, IntegerConstant):
                uwrapped_args.append(arg.eval())
            else:
                uwrapped_args.append(self.funk.emitter.get_node_data_value(arg.eval(), as_type=funk_types.double))

        self.funk.emitter.s2d_draw_point(self.funk, uwrapped_args)
