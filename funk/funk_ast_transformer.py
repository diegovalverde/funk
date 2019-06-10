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

from . import funk_ast
import collections

try:
    from lark import Lark, Transformer
except ImportError:
    import lark, Transformer


def flatten(x):
    if isinstance(x, collections.Iterable):
        return [a for i in x for a in flatten(i)]
    else:
        return [x]


def remove_invalid(l):
    return [x for x in l if x is not None]


class TreeToAst(Transformer):

    def __init__(self, funk, debug=False):
        self.funk = funk
        self.debug = debug
        self.function_map = {}
        self.function_definition_list = []

    def statement(self, token):
        if self.debug:
            print('--Debug-- statement', token)
        return token

    def function(self, tree):
        # TODO Needs refactoring

        fn_name = tree[0].name

        special_fns = ['main', 's2d_render']
        if fn_name in special_fns:

            fn_body = flatten(tree[1])
            clause = funk_ast.FunctionClause(self.funk, fn_name, fn_body, preconditions=None, pattern_matches=None,
                                             arguments=[])

            self.function_map[fn_name] = funk_ast.FunctionMap(self.funk, fn_name, [])
            self.function_definition_list.append(fn_name)
            self.function_map[fn_name].clauses.append(clause)
        else:

            firm = remove_invalid(flatten(tree[1]))

            preconditions = None
            if isinstance(firm[-1], funk_ast.BinaryOp):
                preconditions = firm[-1]
                firm.pop()

            fn_arguments = []
            tail_pairs = []
            pattern_matches = []
            position = 0

            for arg in firm:
                if isinstance(arg, funk_ast.HeadTail):
                    fn_arguments.append(arg.head)
                    tail_pairs.append([arg.head, arg.tail])
                elif isinstance(arg, funk_ast.PatternMatch):
                    fn_arguments.append('_')
                    arg.position = position
                    pattern_matches.append(arg)
                else:
                    fn_arguments.append(arg.name)
                position += 1

            fn_body = flatten(tree[2])
            function_key = '@{}'.format(fn_name)

            clause = funk_ast.FunctionClause(self.funk, function_key, fn_body, preconditions, pattern_matches,
                                             arguments=fn_arguments, tail_pairs=tail_pairs)

            if function_key not in self.function_map:
                self.function_definition_list.append(function_key)
                self.function_map[function_key] = funk_ast.FunctionMap(self.funk, function_key, arguments=fn_arguments,
                                                                       tail_pairs=tail_pairs)

            self.function_map[function_key].clauses.append(clause)

    def fn_precondition(self, token):
        return token

    @staticmethod
    def function_body(token):
        return token

    @staticmethod
    def return_statement(token):
        return token[0]

    def function_call(self, token):
        if len(token) == 2:
            if isinstance(token[1], funk_ast.FunctionCall) or isinstance(token[1], funk_ast.ArrayElement):
                token[1].name = token[0].name
                return token[1]
        else:
            return token[0]

    def action_function_call_args(self, args):

        return funk_ast.FunctionCall(self.funk, '<un-named>', flatten(args))

    def expr_handler(self, token):
        children = remove_invalid(flatten(token))

        if len(children) == 2:
            lhs = children[0]
            rhs_expr = children[1]
            rhs_expr.left = lhs
            return rhs_expr
        else:
            return children[0]

    def action_list_element(self, token):

        return self.expr_handler(token)

    def action_match_identifier(self, token):
        if len(token) == 1:
            return token[0]
        else:
            return token

    def action_match_literal(self, token):
        return funk_ast.PatternMatchLiteral(self.funk, token[0])

    def action_firm_element(self, token):
        token = remove_invalid(flatten(token))
        if len(token) == 2:
            return funk_ast.HeadTail(self.funk, head=token[0], tail=token[1])
        else:
            return self.expr_handler(token)

    def action_pop_list_head(self, token):
        return token[0]

    def action_match_empty_list(self, token):
        return funk_ast.PatternMatchEmptyList(self.funk)

    def expr(self, token):
        return self.expr_handler(token)

    def boolean_expr(self, token):

        return self.expr_handler(token)

    def arith_mul(self, children):
        rhs = children[0]
        return funk_ast.Mul(self.funk, None, rhs)

    def bin_op(self, token, ast_op):
        children = remove_invalid(flatten(token))

        if len(children) == 0:
            return None
        elif len(children) == 1:
            return ast_op(self.funk, None, children[0])
        elif len(children) == 2:
            children[1].left = children[0]
            return ast_op(self.funk, None, children[1])
        else:
            return None

    def action_arith_sub(self, token):
        return self.bin_op(token, funk_ast.Sub)

    def action_arith_add(self, token):
        return self.bin_op(token, funk_ast.Sum)

    def action_arith_div(self, token):
        return self.bin_op(token, funk_ast.Div)

    def action_arith_mul(self, token):
        return self.bin_op(token, funk_ast.Mul)

    def action_arith_mod(self, token):
        return self.bin_op(token[0], funk_ast.Mod)

    def action_lhs_assignment(self, children):
        rhs = children[0]
        return funk_ast.Assignment(self.funk, None, rhs)

    def action_list_concat_head(self, children):
        rhs = children[0]
        return funk_ast.ListConcatHead(self.funk, None, rhs)

    def action_bool_and(self, token):
        return funk_ast.And(self.funk, right=token[0])

    def action_bool_or(self, token):
        return funk_ast.Or(self.funk, right=token[0])

    def action_bool_mod(self, token):
        # Note: this returns an integer (not a TNode)
        return funk_ast.Mod(self.funk, right=token[0])

    def action_bool_lt(self, token):
        if len(token) == 2:
            return funk_ast.LessThan(self.funk, left=token[0], right=token[1])
        else:
            return funk_ast.LessThan(self.funk, right=token[0])

    def action_bool_gt(self, token):
        if len(token) == 2:
            return funk_ast.GreaterThan(self.funk, left=token[0], right=token[1])
        else:
            return funk_ast.GreaterThan(self.funk, right=token[0])

    def action_bool_eq(self, token):
        if len(token) == 2:
            return funk_ast.EqualThan(self.funk, left=token[0], right=token[1])
        else:
            return funk_ast.EqualThan(self.funk, right=token[0])

    def action_rhs_bool_factor(self, token):
        if len(token) == 2 and isinstance(token[1], funk_ast.BinaryOp):

            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

    def action_include_external_function(self, token):
        functions = remove_invalid(flatten(token))

        for fn in functions:

            if fn.name == 's2d':
                self.funk.preamble += \
                    """
    declare %struct.S2D_Window* @S2D_CreateWindow(i8*, i32, i32, void (...)*, void (...)*, i32) #1
    declare i32 @S2D_Show(%struct.S2D_Window*) #1
    declare void @S2D_DrawTriangle(float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float) #1
    declare void @S2D_DrawLine(float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float) #1
    declare void @S2D_DrawCircle(float, float , float, i32, float, float , float, float)
    declare void @S2D_DrawQuad( float, float, float, float, float, float, float , float ,float , float , float , float ,float , float ,float , float , float , float ,float , float ,float , float , float , float ) #1

    %struct.S2D_Window = type { %struct.SDL_Window*, i8*, i8*, i8*, i8*, i32, i32, i8*, i8*, i32, i32, i32, i32, %struct.S2D_Viewport, void (...)*, void (...)*, i32, %struct.S2D_Mouse, void (%struct.S2D_Event*)*, void (%struct.S2D_Event*)*, void (%struct.S2D_Event*)*, i8, i32, %struct.S2D_Color, i8*, i32, i32, i32, i32, double, i8 }
    %struct.SDL_Window = type opaque
    %struct.S2D_Viewport = type { i32, i32, i32 }
    %struct.S2D_Mouse = type { i32, i32, i32 }
    %struct.S2D_Event = type { i32, i32, i32, i8, i8*, i32, i32, i32, i32, i32, i32, i32 }
    %struct.S2D_Color = type { float, float, float, float }

                    """

                continue
            fn_symbol = '@{}'.format(fn.name)
            self.funk.functions.append(fn_symbol)
            self.funk.symbol_table[fn_symbol] = funk_ast.ExternalFunction(self.funk, fn_symbol)

    def more_extern_funcs(self, token):
        return token

    def boolean_binary_term(self, token):

        if len(token) == 2:
            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

    def array_index(self, token):
        t = flatten(token)
        return funk_ast.ArrayElement(self.funk, '', t[0])

    def expr_rhs(self, tokens):
        if len(tokens) == 1:
            return tokens[0]
        else:
            return None

    def list(self, tokens):
        if len(tokens) == 0:
            return [funk_ast.Identifier(self.funk, 'empty'), funk_ast.LiteralList(self.funk,'anon-empty-list',[])]

        e = flatten(tokens)[0]

        if isinstance(e, funk_ast.Range):
            return [e]
        else:
            return e

    @staticmethod
    def list_elements(token):
        return token

    @staticmethod
    def list_initialization(token):
        return token

    @staticmethod
    def fn_firm_args(token):
        return token

    @staticmethod
    def more_list_elements(token):
        return token

    @staticmethod
    def more_fn_firm_elements(token):
        return token

    @staticmethod
    def boolean_binary_term_(self, token):
        if len(token) == 2:
            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

    @staticmethod
    def bool_factor(self, token):
        return token[0]

    def boolean_expr(self, token):
        if len(token) == 2:
            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

    def factor(self, token):
        return token[0]

    def fn_call_arguments(self, token):
        return token[0]

    def term(self, children):
        if len(children) == 2:
            lhs = children[0]
            rhs_expr = children[1]
            rhs_expr.left = lhs
            return rhs_expr
        else:
            return children[0]

    def term_(self, children):
        return children[0]

    def identifier(self, token):
        return funk_ast.Identifier(self.funk, token[0].value)

    def string(self, token):
        return funk_ast.String(self.funk, token[0])

    def number(self, token):
        token[1].sign = token[0]
        return token[1]

    def action_sign_negative(self, token):
        return -1

    def action_sign_positive(self, token):
        return 1

    def action_float_constant(self, token):
        return funk_ast.FloatConstant(self.funk, token[0].value)

    def action_int_constant(self, token):
        return funk_ast.IntegerConstant(self.funk, token[0].value)

    def action_range_exclusive_rhs(self, token):
        return funk_ast.Range(self.funk, rhs=token[0], rhs_type='<')

    def action_range_inclusive_rhs(self, token):
        return funk_ast.Range(self.funk, rhs=token[0], rhs_type='<=')

    def action_inclusive_range_lhs(self, token):
        identifier = token[0]
        range = token[1]
        range.identifier = identifier
        range.lhs_type = '<='
        return range

    def action_exclusive_range_lhs(self, token):
        identifier = token[0]
        range = token[1]
        range.identifier = identifier
        range.lhs_type = '<'
        return range

    def action_list_comprehension_range(self, token):
        expr = token[0]
        range = token[1]
        range.lhs = expr
        return range

    def action_list_comprehension(self, token):
        token[1].expr = token[0]
        return token[1].eval()

