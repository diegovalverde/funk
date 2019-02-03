
from llvmlite import binding
from lark import Lark
from funk.funk_ast_transformer import TreeToAst

import argparse

from funk.funk import Funk
import os


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

    path, file_name = os.path.split(args.input_path)

    file_base_name, file_extension = os.path.splitext(file_name)

    parse_tree = grammar.parse(text)

    funk = Funk(binding.get_default_triple())

    ast_generator = TreeToAst(funk, debug=args.debug)

    ast_generator.transform(parse_tree)

    for fn in ast_generator.function_definition_list:
        if args.debug:
            print('-I- Emitting Function {}/{} '.format(fn, ast_generator.function_map[fn].arity))

        ast_generator.function_map[fn].eval()

    ll_name = '{}.ll'.format(file_base_name)
    funk.save_ir(ll_name)

    print('Compilation successful saved: {}'.format(ll_name) )

    #except Exception as e:
    #    print('Compilation error: {}'.format(e))

