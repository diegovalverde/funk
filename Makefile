.PHONY: clean test-cpp20 examples examples-graphics examples-experimental examples-interactive

clean:
	rm -rf build build_tests

test-cpp20:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py ./funk/tests/test_main.f --backend cpp20 --build-dir build_tests --include "$(FUNK_INCLUDE_PATH)" ./funk/tests "$(FUNK_EXAMPLES_PATH)/examples/games"
	./build_tests/test_main

examples:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/bottles_of_beer.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/bottles_of_beer
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/fibonacci.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/fibonacci
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/fizzbuzz.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/fizzbuzz
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/merge_sort.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/merge_sort
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/test_bfs.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/test_bfs
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/hanoi.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/hanoi
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/games/puzzle_8_main.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)" "$(FUNK_EXAMPLES_PATH)/examples/games"
	./build/puzzle_8_main
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/games/sudoku.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/sudoku

examples-graphics:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/graphics/barnsly_fern.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/barnsly_fern
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/graphics/cantor_set.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/cantor_set
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/graphics/game_of_life.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/game_of_life
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/graphics/random_walk.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/random_walk

examples-experimental:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)

examples-interactive:
	@test -n "$(FUNK_INCLUDE_PATH)" || (echo "FUNK_INCLUDE_PATH is not set"; exit 1)
	@test -n "$(FUNK_EXAMPLES_PATH)" || (echo "FUNK_EXAMPLES_PATH is not set"; exit 1)
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/games/connect4.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/connect4
	./venv_3.11/bin/python ./funky.py "$(FUNK_EXAMPLES_PATH)/examples/games/tic_tac_toe.f" --backend cpp20 --include "$(FUNK_INCLUDE_PATH)"
	./build/tic_tac_toe
