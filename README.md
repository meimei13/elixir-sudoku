# ⬛ Sudoku ⬜

This is a small Sudoku solver and board generator written in Elixir.
Since this is a functional exercise, I tried to avoid using anything
imperative or with state! As such, this solver is composed of lots
of small functions ping ponging between each other 🤔. The program is composed of three modules:

1. **Board**: Provides a set of functions for representing and manipulating a board, such
as asking if a cell is empty or grabbing a row
2. **Sudoku**: Using the functions which represent the board, this module uses a back-tracking
algorithm to recursively fill empty cells with the least number of possibilities until
the entire board is solved
3. **Generator**: The generator will fill an empty board of m x n dimensions, shuffle
the elements, and then continue removing cells until there is more than one solution (it 
returns the board with only one solution before that point)

## Usage

The program doesn't take input from I/O or output anything to stdout. You can try the functions
as in the following example, which generates and solves a 3x3 board 
from the elixir interactive shell:

```
iex -S mix
iex(1)> Sudoku.solve(Generator.gen({3, 3}), {3, 3})
[
  [4, 6, 3, 1, 5, 9, 2, 7, 8],
  [9, 5, 7, 2, 8, 6, 3, 4, 1],
  [1, 2, 8, 4, 3, 7, 9, 5, 6],
  [7, 4, 2, 5, 1, 8, 6, 9, 3],
  [6, 1, 5, 9, 4, 3, 8, 2, 7],
  [3, 8, 9, 7, 6, 2, 5, 1, 4],
  [5, 3, 4, 8, 9, 1, 7, 6, 2],
  [2, 9, 6, 3, 7, 4, 1, 8, 5],
  [8, 7, 1, 6, 2, 5, 4, 3, 9]
]
```

## Installation

Add to an existing project:

```elixir
def deps do
  [
    {:sudoku, "~> 0.1.0"}
  ]
end
```

---

More likely, you'll probably just want to grab the repo and run the tests.

To run tests, while in the top level directory, run: ``mix test``

Current tests:

```elixir
SudokuTest [test/sudoku_test.exs]
  * test squares get board squares (1.9ms) [L#105]
  * test generate 2x3 board generated can be solved (11.9ms) [L#273]
  * test squares get middle square (0.01ms) [L#123]
  * test cols get board cols (0.01ms) [L#166]
  * test generate 3x3 board generated can be solved (111.5ms) [L#268]
  * test candidates candidate of cell with one candidate is correct (0.01ms) [L#281]
  * test candidates candidate of cell with multiple candidates is correct (0.02ms) [L#285]
  * test uniqueness col is unique (0.00ms) [L#222]
  * test rows get fist cell on first row (0.00ms) [L#158]
  * test solve solved a 3x2 board correctly (1.0ms) [L#253]
  * test uniqueness square is unique (0.00ms) [L#227]
  * test solve solved easy board correctly (5.3ms) [L#245]
  * test candidates update cell with new value (0.00ms) [L#289]
  * test squares get first square (0.00ms) [L#119]
  * test rows get board rows (0.00ms) [L#138]
  * test empty count empty cells (0.02ms) [L#194]
  * test empty cell is empty (0.00ms) [L#190]
  * test solve solved very challenging board correctly (4003.1ms) [L#249]
  * test generate 2x2 board generated can be solved (0.7ms) [L#263]
  * test cols get first col (0.00ms) [L#182]
  * test candidates get candidates for all empty cells (0.2ms) [L#305]
  * test squares get first square by first cell (0.00ms) [L#127]
  * test uniqueness row is unique (0.00ms) [L#217]
  * test empty next_squares (0.04ms) [L#198]
  * test uniqueness solved board has no free cells (0.00ms) [L#232]
  * test solve hard board has one solution (5651.8ms) [L#257]
  * test squares get middle square by cell (0.00ms) [L#131]
  * test rows get first row (0.00ms) [L#153]


Finished in 9.9 seconds
28 tests, 0 failures
```

## Acknowledgments

Thank you to these references, for helping me understand back-tracking:
- https://www.algorist.com/ (The Algorithm Design Manual)
- https://en.wikipedia.org/wiki/Sudoku_solving_algorithms
- https://medium.com/swlh/simple-sudoku-with-backtracking-bb4813ddabb1

And also https://github.com/4e554c4c, for explaining folds and time complexity. 
