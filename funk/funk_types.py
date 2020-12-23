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

invalid = 0
int = 1
double = 2
array = 3
empty_array = 4
scalar = 5
function = 6
unknown = 7
string =8

global_pool=0
function_pool=1

to_str = {0: 'invalid', 1: 'int', 2: 'double', 3: 'array',
          4: 'empty_array', 5: 'scalar', 6: 'function'}

llvm = {int: 'i32', float: 'float'}


def num(s):
    try:
        return int(s)
    except ValueError:
        return float(s)
