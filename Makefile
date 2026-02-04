.PHONY: clean test-opt

clean:
	rm -rf build build_opt

test-opt:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py ./funk/tests/test_main.f --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)" ./funk/tests
	./build_opt/test_main
