from llvmlite import ir, binding



class ToyDefs:
    def __init__(self):
        self.debug = True

        self.int32 = ir.IntType(32)
        self.int64 = ir.IntType(64)
        self.t_tag_type = ir.IntType(8)


        self.t_data = None

        self.t_array_node = None
        self.t_p_array_node = None
        self.t_p_array_node_null = None

        self.tag_type_int = ir.Constant(self.t_tag_type, 77)
        self.tag_type_float = ir.Constant(self.t_tag_type, 2)
        self.tag_type_array = ir.Constant(self.t_tag_type, 70)
        self.tag_type_empty_array = ir.Constant(self.t_tag_type, 4)

class CodeGen:
    def __init__(self):
        self.binding = binding
        self.binding.initialize()
        self.binding.initialize_native_target()
        self.binding.initialize_native_asmprinter()
        self.toy = ToyDefs()
        self._config_llvm()
        self._create_execution_engine()
        self._declare_print_function()
        self._declare_data_types()

    def _declare_data_types(self):
        context = self.module.context
        # Generic  data definitions
        self.toy.t_data = context.get_identified_type('t_data')
        self.toy.t_data.set_body(ir.IntType(8), self.toy.int32)

        # Array definitions
        self.toy.t_array_node = context.get_identified_type('t_node')
        self.toy.t_array_node.set_body(ir.IntType(8), ir.PointerType(self.toy.t_data),
                                       ir.PointerType(self.toy.t_array_node))
        self.toy.t_p_array_node = self.toy.t_array_node.as_pointer()
        self.toy.t_p_array_node_null = ir.Constant(self.toy.t_p_array_node, 0)

    def _config_llvm(self):
        # Config LLVM
        self.module = ir.Module(name=__file__)
        self.module.triple = self.binding.get_default_triple()
        func_type = ir.FunctionType(ir.VoidType(), [], False)
        base_func = ir.Function(self.module, func_type, name="main")
        block = base_func.append_basic_block(name="entry")
        self.builder = ir.IRBuilder(block)

    def _create_execution_engine(self):
        """
        Create an ExecutionEngine suitable for JIT code generation on
        the host CPU.  The engine is reusable for an arbitrary number of
        modules.
        """
        target = self.binding.Target.from_default_triple()
        target_machine = target.create_target_machine()
        # And an execution engine with an empty backing module
        backing_mod = binding.parse_assembly("")
        engine = binding.create_mcjit_compiler(backing_mod, target_machine)
        self.engine = engine

    def _declare_print_function(self):
        # Declare Printf function
        voidptr_ty = ir.IntType(8).as_pointer()
        printf_ty = ir.FunctionType(ir.IntType(32), [voidptr_ty], var_arg=True)
        printf = ir.Function(self.module, printf_ty, name="printf")
        self.printf = printf

    def _compile_ir(self):
        """
        Compile the LLVM IR string with the given engine.
        The compiled module object is returned.
        """
        # Create a LLVM module object from the IR
        self.builder.ret_void()
        llvm_ir = str(self.module)
        mod = self.binding.parse_assembly(llvm_ir)
        mod.verify()
        # Now add the module and make sure it is ready for execution
        self.engine.add_module(mod)
        self.engine.finalize_object()
        self.engine.run_static_constructors()
        return mod

    def create_ir(self):
        self._compile_ir()

    def save_ir(self, filename):
        with open(filename, 'w') as output_file:
            output_file.write(str(self.module))
