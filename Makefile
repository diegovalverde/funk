.PHONY: clean tests test-cpp20 examples examples-graphics examples-experimental examples-interactive bench-fib-compare bench-concat-compare bench-fib-fastpath bench-concat-fastpath bench-fib-i32 bench-concat-i32 bench-fib-tr bench-fib-tr-fastpath bench-sum-range bench-collatz bench-mutual-recursion bench-report bench-all

BENCH_RUNS ?= 7
BENCH_WARMUP ?= 1

clean:
	rm -rf build build_tests

tests: test-cpp20

test-cpp20:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py ./funk/tests/test_main.f --backend cpp20 --build-dir build_tests --include "$(FUNK_INCLUDE_PATH)" ./funk/tests "$(FUNK_EXAMPLES_PATH)/games"
	./build_tests/test_main

examples:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/bottles_of_beer.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/bottles_of_beer
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/fibonacci.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/fibonacci
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/fizzbuzz.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/fizzbuzz
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/merge_sort.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/merge_sort
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/test_bfs.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/test_bfs
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/hanoi.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/hanoi
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/puzzle_8_main.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)" "$(FUNK_EXAMPLES_PATH)/games"
	./build/puzzle_8_main
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/sudoku.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/sudoku

examples-graphics:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/graphics/barnsly_fern.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/barnsly_fern
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/graphics/cantor_set.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/cantor_set
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/graphics/game_of_life.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/game_of_life
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/graphics/random_walk.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/random_walk

examples-experimental:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)

examples-interactive:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/connect4.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/connect4
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/games/tic_tac_toe.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/tic_tac_toe

bench-fib-compare:
	./venv_3.11/bin/python ./scripts/benchmark_fib_compare.py --runs 5

bench-concat-compare:
	./venv_3.11/bin/python ./scripts/benchmark_concat_compare.py --runs 5

bench-fib-fastpath:
	./venv_3.11/bin/python ./scripts/benchmark_fib_compare.py --runs 5 --fastpath

bench-concat-fastpath:
	./venv_3.11/bin/python ./scripts/benchmark_concat_compare.py --runs 5 --fastpath

bench-fib-i32:
	./venv_3.11/bin/python ./scripts/benchmark_fib_compare.py --runs 5 --backend cpp20_i32

bench-concat-i32:
	./venv_3.11/bin/python ./scripts/benchmark_concat_compare.py --runs 5 --backend cpp20_i32

bench-fib-tr:
	./venv_3.11/bin/python ./scripts/benchmark_fib_tr_compare.py --runs 5 --backend cpp20_i32

bench-fib-tr-fastpath:
	./venv_3.11/bin/python ./scripts/benchmark_fib_tr_compare.py --runs 5 --backend cpp20_i32 --fastpath

bench-sum-range:
	./venv_3.11/bin/python ./scripts/benchmark_sum_range_compare.py --runs 5 --backend cpp20_i32

bench-collatz:
	./venv_3.11/bin/python ./scripts/benchmark_collatz_compare.py --runs 5 --backend cpp20_i32

bench-mutual-recursion:
	./venv_3.11/bin/python ./scripts/benchmark_mutual_recursion_compare.py --runs 5 --backend cpp20_i32

bench-report:
	./venv_3.11/bin/python ./benchmarks/generate_report.py --runs $(BENCH_RUNS) --warmup $(BENCH_WARMUP)

bench-all: bench-report
