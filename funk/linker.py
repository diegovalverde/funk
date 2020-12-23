import re
from .funk import Funk
import os

link_with_sdl = False
dependency_satisfied = set()
link_targets = set()


def get_dependencies(src, include_paths=['.',os.getcwd()]):
    """

    :param include_paths: list of paths to the include search folders
    :param src: The text src file
    :return: list of paths to dependencies
    """
    dependencies = []
    for line in src.splitlines():
        global link_with_sdl
        match = re.findall('^ *\t*use +(.*)', line)
        if len(match) == 0:
            continue
        for dep in match[0].split(','):
            dep = dep.strip()
            if dep == 'sdl':
                link_with_sdl = True
                continue

            found = False
            for include_path in include_paths:
                dep_path = os.path.join(include_path, '{}.f'.format(dep))
                if os.path.isfile(dep_path):
                    dependencies.append(dep_path)
                    found = True
                    break

            if not found:
                print('-E- Could not find source file {}.f'.format(dep))
                print('-I- Include path ',include_paths)
                exit(1)

    return dependencies


def get_ll_path(src_path):
    ath, file_name = os.path.split(src_path)
    file_base_name, file_extension = os.path.splitext(file_name)
    return '{}.ll'.format(file_base_name), '{}.f'.format(file_base_name)


def compile_source(src_path, build_path, include_paths, debug=False):
    try:
        dependencies = []
        funk = Funk(debug=debug)

        if not os.path.isfile(src_path):
            src_path = os.path.join(os.getcwd(),src_path)

        with open(src_path, 'r') as my_file:
            src_text = my_file.read()

        funk.compile(src_text)

        ll_name, f_name = get_ll_path(src_path)

        funk.save_ir(os.path.join(build_path, ll_name))
        print('{} -> {}/{}'.format(f_name, build_path,ll_name))
        dependency_satisfied.add(src_path)
        link_targets.add(os.path.join(build_path,ll_name))

        for dependency in get_dependencies(src_text, include_paths=include_paths):
            ll_name, _ = get_ll_path(dependency)
            ll_path = os.path.join(build_path, ll_name)
            link_targets.add(ll_path)
            if not os.path.isfile(ll_path) or os.path.getmtime(ll_path) < os.path.getmtime(dependency):
                dependencies.append(dependency)

        return dependencies

    except IOError:
        print('-E- File not found \'{}\''.format(src_path))
        exit()


def is_in_path_env(program):
    for path in os.environ["PATH"].split(os.pathsep):
        exe_file = os.path.join(path, program)
        if os.path.exists(exe_file):
            return True

    return False


def build(src_path, include_paths, build_path, debug):
    global link_with_sdl

    if os.environ.get('LLVM_BIN_PATH') is None:
        print('-E- LLVM_BIN_PATH environment variable is undefined')
        exit(1)

    llvm_bin_prefix = os.environ.get('LLVM_BIN_PATH')


    print('==== compiling ====')

    if not os.path.exists(build_path):
        os.mkdir(build_path)
    build_source(src_path, include_paths, build_path, debug)

    print('==== linking ====')
    if not os.path.isfile(os.path.join(build_path,'funk_core.o')):
        link_targets.add('{}/core/funk_core.ll'.format(os.path.dirname(os.path.abspath(__file__))))

    if link_with_sdl and not os.path.isfile(os.path.join(build_path,'funk_sdl.o')):
        link_targets.add('{}/core/funk_sdl.ll'.format(os.path.dirname(os.path.abspath(__file__))))

    _, file_name = os.path.split(src_path)
    output = os.path.join(build_path, os.path.splitext(file_name)[0])

    obj_list = ''
    for link_target in link_targets:
        file_base_name, file_extension = os.path.splitext(link_target)
        obj_name = '{}.o'.format(file_base_name)

        if not os.path.isfile(obj_name) or os.path.getmtime(link_target) > os.path.getmtime(obj_name):
            cmd = '{}/llc -filetype=obj {link_target}'.format(llvm_bin_prefix, link_target=link_target)
            print(cmd)
            retval = os.system(cmd)
            if retval != 0:
                print('-E- Error Linking {link_target}'.format(link_target=link_target))
                exit(retval)
            else:
                print('{file_base_name}.ll -> {file_base_name}.o'.format(file_base_name=file_base_name))

        obj_list += ' {} '.format(obj_name)

    libs = ''
    
    if link_with_sdl:
        # TODO: allow user to specify the path to libs
        libs += '-L/usr/local/lib -lSDL2 '

    cmd = '{}/clang {obj_list} {libs} -o {output}'.format(llvm_bin_prefix, obj_list=obj_list, libs=libs, output=output)

    print(cmd)
    os.system(cmd)


def build_source(src_path, include_paths, build_path, debug=False):

    dependencies = compile_source(src_path, include_paths=include_paths,
                                  build_path=build_path, debug=debug)
    for dependency in dependencies:
        if dependency in dependency_satisfied:
            continue
        build_source(dependency, include_paths=include_paths,
                     build_path=build_path, debug=debug)


