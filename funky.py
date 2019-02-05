import argparse

from funk.funk import Funk
import os


if __name__ == '__main__':
    #try:
    parser = argparse.ArgumentParser(description='Compile a program to LLVM IR.')
    parser.add_argument('input_path', help='Path to input file')
    parser.add_argument('--debug', action='store_true', default=False, help='For tool debugging purposes only')
    args = parser.parse_args()

    with open(args.input_path, 'r') as my_file:
        text = my_file.read()

    funk = Funk()

    funk.compile(text)

    path, file_name = os.path.split(args.input_path)
    file_base_name, file_extension = os.path.splitext(file_name)
    ll_name = '{}.ll'.format(file_base_name)

    funk.save_ir(ll_name)

    print('Compilation successful saved: {}'.format(ll_name) )

    #except Exception as e:
    #    print('Compilation error: {}'.format(e))

