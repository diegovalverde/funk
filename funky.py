#!/usr/bin/env python3
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

import argparse

from funk.funk import Funk
import os

if __name__ == '__main__':
    try:
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

        print('Compilation successful saved: {}'.format(ll_name))

    except IOError:
        print('File not found')

    # TODO: display compilation error nicely (like Rust does)
    # except Exception as e:
    #    print('Compilation error: {}'.format(e))
