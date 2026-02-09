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

from funk.funky_builder import *


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Compile a program to LLVM IR.')
    parser.add_argument('input_path', help='Path to input file')
    parser.add_argument('--debug', action='store_true', default=False, help='For tool debugging purposes only')
    parser.add_argument('--include', nargs='+', help='Path to the .f includes', default='.')
    parser.add_argument('--backend', choices=['cpp20', 'cpp20_i32'], default='cpp20',
                        help='Select codegen backend')
    parser.add_argument('--build-dir', default=None, help='Build output directory')

    args = parser.parse_args()
    set_cwd(os.path.dirname(os.path.abspath(__file__)))
    if args.build_dir is None:
        build_dir = 'build'
    else:
        build_dir = args.build_dir

    build(args.input_path,
          include_paths=args.include,
          build_path=os.path.join(os.getcwd(), build_dir),
          debug=args.debug,
          backend=args.backend)
