from lark import Lark, Transformer
from llvmlite import binding
import funk.funk_ast as funk_ast
from funk.codegen import CodeGen
import argparse
import collections
from funk.funk import Funk


def flatten(x):
    if isinstance(x, collections.Iterable):
        return [a for i in x for a in flatten(i)]
    else:
        return [x]


def remove_invalid(L):
    return [x for x in L if x is not None]

#TODO Move this tree to another file
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

        if fn_name == 'main':

            fn_body = flatten(tree[1])
            clause = funk_ast.FunctionClause(self.funk, 'main', fn_body, preconditions=None, pattern_matches=None, arguments=[])

            self.function_map['main'] = funk_ast.FunctionMap(self.funk, 'main', [])
            self.function_definition_list.append('main')
            self.function_map['main'].clauses.append(clause)
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

            arity = len(fn_arguments)
            fn_body = flatten(tree[2])
            function_key = '@{}'.format(fn_name)

            clause = funk_ast.FunctionClause(self.funk,function_key, fn_body, preconditions, pattern_matches,
                                             arguments=fn_arguments, tail_pairs=tail_pairs)

            if function_key not in self.function_map:
                self.function_definition_list.append(function_key)
                self.function_map[function_key] = funk_ast.FunctionMap(self.funk, function_key, arguments=fn_arguments, tail_pairs=tail_pairs)

            self.function_map[function_key].clauses.append(clause)


    def fn_precondition(self,token):
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
        return funk_ast.PatternMatchLiteral(self.funk, token[0] )

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
        return funk_ast.Mul(self.funk, None, rhs, self.symbol_table)

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

    def action_arith_mod(self, token):
        return self.bin_op(token[0], funk_ast.Mod)

    def action_lhs_assignment(self, children):
        rhs = children[0]
        return funk_ast.Assignment(self.funk, None, rhs)

    def action_bool_mod(self, token):
        return funk_ast.Mod(self.funk, right=token[0])

    def action_bool_eq(self, token):
        if len(token) == 2:
            return funk_ast.EqualThan(self.funk,left=token[0], right=token[1])
        else:
            return funk_ast.EqualThan(self.funk, right=token[0])

    def action_rhs_bool_factor(self, token):
        if len(token) == 2 and isinstance(token[1], funk_ast.BinaryOp):

            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

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
        elements = flatten(tokens)

        # A Null terminated linked list

        return funk_ast.ArrayLiteral(self.funk, '<un-named>', elements)

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

    def bool_gt(self, token):
        return self.bin_op(token, funk_ast.GreaterThan)

    def bool_and(self, token):
        return self.bin_op(token, funk_ast.And)

    def bool_eq(self, token):
        return self.bin_op(token, funk_ast.EqualThan)

    def bool_lt(self,token):
        return self.bin_op(token, funk_ast.LessThan)

    @staticmethod
    def boolean_binary_term_(self,token):
        if len(token) == 2:
            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

    @staticmethod
    def bool_factor(self,token):
        return token[0]

    def boolean_expr(self,token):
        if len(token) == 2:
            token[1].left = token[0]
            return token[1]
        else:
            return token[0]

    def factor(self, token):
        return token[0]

    def fn_call_arguments(self,token):
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

    def action_float_constant(self,token):
        return funk_ast.FloatConstant(self.funk, token[0].value)

    def action_int_constant(self,token):
        return funk_ast.IntegerConstant(self.funk, token[0].value)


if __name__ == '__main__':
    """
    ======= M A I N =====
    """
    #try:
    parser = argparse.ArgumentParser(description='Compile a program to LLVM IR.')
    parser.add_argument('input_path', help='Path to input file')
    parser.add_argument('--debug', action='store_true', default=False, help='For tool debugging purposes only')
    args = parser.parse_args()

    funk_grammar = ''
    text = ''

    with open('funk/funk_ll1.lark', 'r') as myfile:
        funk_grammar = myfile.read()

    grammar = Lark(funk_grammar)

    with open(args.input_path, 'r') as myfile:
        text = myfile.read()

    parse_tree = grammar.parse(text)

    funk = Funk(binding.get_default_triple())

    ast_generator = TreeToAst(funk, debug=args.debug)

    ast_generator.transform(parse_tree)

    for fn in ast_generator.function_definition_list:
        if args.debug:
            print('-I- Emitting Function {}/{} '.format(fn, ast_generator.function_map[fn].arity))

        ast_generator.function_map[fn].eval()

    funk.save_ir('output.ll')

    print('Compilation successful')

    #except Exception as e:
    #    print('Compilation error: {}'.format(e))

