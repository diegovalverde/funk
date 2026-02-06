.PHONY: clean test-opt examples examples-graphics examples-experimental examples-interactive

clean:
	rm -rf build build_opt

test-opt:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py ./funk/tests/test_main.f --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)" ./funk/tests "$(FUNK_EXAMPLES_PATH)/examples/games"
	./build_opt/test_main

examples:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/bottles_of_beer.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/bottles_of_beer
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/fibonacci.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/fibonacci
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/fizzbuzz.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/fizzbuzz
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/merge_sort.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/merge_sort
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/test_bfs.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/test_bfs
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/hanoi.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/hanoi
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/games/puzzle_8_main.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)" "$(FUNK_EXAMPLES_PATH)/examples/games"
	./build_opt/puzzle_8_main
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/games/sudoku.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/sudoku

examples-graphics:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/graphics/barnsly_fern.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/barnsly_fern
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/graphics/cantor_set.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/cantor_set
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/graphics/game_of_life.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/game_of_life
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/graphics/random_walk.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/random_walk

examples-experimental:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)

examples-interactive:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/games/connect4.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/connect4
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/games/tic_tac_toe.f" --backend optimized_cpp --include "$(FUNK_INCLUDE_PATH)"
	./build_opt/tic_tac_toe
