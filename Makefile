.PHONY: clean clear test doctor release-check sync-submodules update-submodules submodule-status tests tests-fast tests-integration test-cpp20 examples examples-smoke examples-graphics examples-experimental examples-interactive vm-test bytecode-build-smoke bytecode-disasm-smoke bytecode-run-smoke bytecode-tests-subset test-bytecode-main test-bytecode bench-bytecode-smoke bench-fib-compare bench-concat-compare bench-fib-fastpath bench-concat-fastpath bench-fib-i32 bench-concat-i32 bench-fib-tr bench-fib-tr-fastpath bench-sum-range bench-collatz bench-mutual-recursion bench-fp-dot bench-fp-axpy bench-fp-triad bench-report bench-all

BENCH_RUNS ?= 7
BENCH_WARMUP ?= 1
BUILD_ROOT ?= build
CPP20_BUILD_DIR ?= $(BUILD_ROOT)/build_cpp20
CPP20_TEST_BUILD_DIR ?= $(BUILD_ROOT)/build_tests
BYTECODE_MAIN_BUILD_DIR ?= $(BUILD_ROOT)/build_tests_bytecode
FUNK_INCLUDE_PATH ?= $(CURDIR)/stdlib
BYTECODE_BUILD_DIR ?= $(BUILD_ROOT)/build_bytecode_smoke
BYTECODE_SMOKE_SRC ?= $(CURDIR)/bytecode_smoke.f
BYTECODE_TEST_DIR ?= $(CURDIR)/tests/bytecode
BYTECODE_TEST_SRCS ?= $(BYTECODE_TEST_DIR)/core_lists_ranges.f $(BYTECODE_TEST_DIR)/clauses_recursion.f

clean:
	rm -rf $(BUILD_ROOT)

build-root:
	mkdir -p "$(BUILD_ROOT)"

clear: clean

test: tests

doctor:
	@echo "== funk doctor =="
	@command -v clang++ >/dev/null || (echo "missing clang++ in PATH"; exit 1)
	@./venv_3.11/bin/python --version >/dev/null || (echo "missing ./venv_3.11/bin/python (create venv and install requirements)"; exit 1)
	@./venv_3.11/bin/python -m pip --version >/dev/null || (echo "pip not available in ./venv_3.11"; exit 1)
	@test -d "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH does not exist: $(FUNK_INCLUDE_PATH)"; exit 1)
	@test -f "$(FUNK_INCLUDE_PATH)/assert.f" || (echo "stdlib check failed: $(FUNK_INCLUDE_PATH)/assert.f not found"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	@test -d "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH does not exist: $(FUNK_EXAMPLES_PATH)"; exit 1)
	@test -f "$(FUNK_EXAMPLES_PATH)/bottles_of_beer.f" || (echo "examples check failed: $(FUNK_EXAMPLES_PATH)/bottles_of_beer.f not found"; exit 1)
	@echo "== submodule status =="
	@sub_status="$$(git submodule status --recursive)"; \
	echo "$$sub_status"; \
	echo "$$sub_status" | awk '$$1 ~ /^[-+U]/ { bad=1 } END { exit bad }' || (echo "submodule status is not clean; run make sync-submodules"; exit 1)
	@echo "doctor: OK"

release-check:
	$(MAKE) doctor
	$(MAKE) tests-fast
	$(MAKE) test-bytecode
	$(MAKE) examples-smoke
	$(MAKE) bench-report BENCH_RUNS=1 BENCH_WARMUP=0

sync-submodules:
	git submodule sync --recursive
	git submodule update --init --recursive

update-submodules:
	git submodule update --remote --recursive

submodule-status:
	git submodule status --recursive

tests: tests-fast

tests-fast: test-cpp20

tests-integration: build-root
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/puzzle_8_main.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)" "$(FUNK_EXAMPLES_PATH)/games"
	./$(CPP20_BUILD_DIR)/puzzle_8_main
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/sudoku.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/sudoku

test-cpp20: build-root
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py ./funk/tests/test_main.f --backend cpp20 --build-dir "$(CPP20_TEST_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)" ./funk/tests "$(FUNK_EXAMPLES_PATH)/games"
	./$(CPP20_TEST_BUILD_DIR)/test_main

examples: build-root
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/bottles_of_beer.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/bottles_of_beer
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/fibonacci.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/fibonacci
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/fizzbuzz.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/fizzbuzz
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/merge_sort.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/merge_sort
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/test_bfs.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/test_bfs
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/hanoi.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/hanoi
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/puzzle_8_main.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)" "$(FUNK_EXAMPLES_PATH)/games"
	./$(CPP20_BUILD_DIR)/puzzle_8_main
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/sudoku.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/sudoku

examples-smoke: build-root
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/fibonacci.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/fibonacci
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/fizzbuzz.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/fizzbuzz
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/test_bfs.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/test_bfs

examples-graphics: build-root
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/graphics/barnsly_fern.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/barnsly_fern
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/graphics/cantor_set.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/cantor_set
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/graphics/game_of_life.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/game_of_life
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/graphics/random_walk.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/random_walk

examples-experimental:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)

examples-interactive: build-root
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/connect4.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/connect4
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/tic_tac_toe.f" --backend cpp20 --build-dir "$(CPP20_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"
	./$(CPP20_BUILD_DIR)/tic_tac_toe

vm-test:
	cd ./funk_vm && cargo test --offline

bytecode-tests-subset: build-root
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@set -e; \
	for src in $(BYTECODE_TEST_SRCS); do \
		name="$$(basename "$$src" .f)"; \
		build_dir="$(BUILD_ROOT)/build_bytecode_$$name"; \
		echo "== bytecode subset: $$name =="; \
		./venv_3.11/bin/python ./funky.py "$$src" --backend bytecode --build-dir "$$build_dir" --include "$(FUNK_INCLUDE_PATH)"; \
		(cd ./funk_vm && cargo run --offline -- run "../$$build_dir/$$name.fkb"); \
	done

test-bytecode-main: build-root
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py ./funk/tests/test_main.f --backend bytecode --build-dir "$(BYTECODE_MAIN_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)" ./funk/tests "$(FUNK_EXAMPLES_PATH)/games"
	@set -e; \
	rc=0; \
	(cd ./funk_vm && cargo run --offline -- run ../$(BYTECODE_MAIN_BUILD_DIR)/test_main.fkb) || rc=$$?; \
	if [ "$$rc" -ne 0 ] && [ "$$rc" -ne 1 ]; then \
		exit $$rc; \
	fi

test-bytecode: vm-test bytecode-tests-subset test-bytecode-main

bytecode-build-smoke: build-root
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(BYTECODE_SMOKE_SRC)" --backend bytecode --build-dir "$(BYTECODE_BUILD_DIR)" --include "$(FUNK_INCLUDE_PATH)"

bytecode-disasm-smoke: bytecode-build-smoke
	cd ./funk_vm && cargo run --offline -- disasm ../$(BYTECODE_BUILD_DIR)/bytecode_smoke.fkb

bytecode-run-smoke: bytecode-build-smoke
	cd ./funk_vm && cargo run --offline -- run ../$(BYTECODE_BUILD_DIR)/bytecode_smoke.fkb

bench-fib-compare: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_fib_compare.py --runs 5

bench-bytecode-smoke: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_bytecode_smoke.py --runs $(BENCH_RUNS) --warmup $(BENCH_WARMUP)

bench-concat-compare: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_concat_compare.py --runs 5

bench-fib-fastpath: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_fib_compare.py --runs 5 --fastpath

bench-concat-fastpath: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_concat_compare.py --runs 5 --fastpath

bench-fib-i32: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_fib_compare.py --runs 5 --backend cpp20_i32

bench-concat-i32: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_concat_compare.py --runs 5 --backend cpp20_i32

bench-fib-tr: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_fib_tr_compare.py --runs 5 --backend cpp20_i32

bench-fib-tr-fastpath: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_fib_tr_compare.py --runs 5 --backend cpp20_i32 --fastpath

bench-sum-range: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_sum_range_compare.py --runs 5 --backend cpp20_i32

bench-collatz: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_collatz_compare.py --runs 5 --backend cpp20_i32

bench-mutual-recursion: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_mutual_recursion_compare.py --runs 5 --backend cpp20_i32

bench-fp-dot: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_fp_dot_compare.py --runs 5 --backend cpp20

bench-fp-axpy: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_fp_axpy_compare.py --runs 5 --backend cpp20

bench-fp-triad: build-root
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./scripts/benchmark_fp_triad_compare.py --runs 5 --backend cpp20

bench-report: build-root
	cd ./funk_vm && cargo build --release --offline
	FUNK_BUILD_ROOT="$(BUILD_ROOT)" ./venv_3.11/bin/python ./benchmarks/generate_report.py --runs $(BENCH_RUNS) --warmup $(BENCH_WARMUP)

bench-all: bench-report
