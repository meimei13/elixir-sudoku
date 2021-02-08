defmodule SudokuTest do
  use ExUnit.Case
  doctest Sudoku

  # This is a sudoku easy for human players to solve
  # I got it off a sudoku website and it took me about 10 minutes with a monkey brain
  defp setup_board(_) do
    easy = [
      [1,0,0, 0,6,0, 5,3,8],
      [0,3,8, 5,4,0, 0,0,6],
      [5,7,0, 0,0,0, 2,0,9],

      [0,0,0, 0,0,1, 0,9,0],
      [0,2,0, 4,0,5, 0,8,0],
      [0,1,0, 3,0,0, 0,0,0],

      [3,0,1, 0,0,0, 0,2,4],
      [8,0,0, 0,5,4, 3,7,0],
      [7,9,4, 0,3,0, 0,0,5]
    ]
    {:ok, board: easy}
  end

  defp solved_board(_) do
    easy = [
      [1,4,9, 2,6,7, 5,3,8],
      [2,3,8, 5,4,9, 7,1,6],
      [5,7,6, 8,1,3, 2,4,9],

      [4,8,5, 7,2,1, 6,9,3],
      [6,2,3, 4,9,5, 1,8,7],
      [9,1,7, 3,8,6, 4,5,2],

      [3,5,1, 6,7,8, 9,2,4],
      [8,6,2, 9,5,4, 3,7,1],
      [7,9,4, 1,3,2, 8,6,5]
    ]
    {:ok, solved: easy}
  end

  defp hard_board(_) do
    hard = [
      [0,0,0, 0,0,0, 0,1,2],
      [0,0,0, 0,3,5, 0,0,0],
      [0,0,0, 6,0,0, 0,7,0],

      [7,0,0, 0,0,0, 3,0,0],
      [0,0,0, 4,0,0, 8,0,0],
      [1,0,0, 0,0,0, 0,0,0],

      [0,0,0, 1,2,0, 0,0,0],
      [0,8,0, 0,0,0, 0,4,0],
      [0,5,0, 0,0,0, 6,0,0]
    ]
    {:ok, hard: hard}
  end

  defp solved_hard(_) do
    hard = [
      [6,7,3, 8,9,4, 5,1,2],
      [9,1,2, 7,3,5, 4,8,6],
      [8,4,5, 6,1,2, 9,7,3],

      [7,9,8, 2,6,1, 3,5,4],
      [5,2,6, 4,7,3, 8,9,1],
      [1,3,4, 5,8,9, 2,6,7],

      [4,6,9, 1,2,8, 7,3,5],
      [2,8,7, 3,5,6, 1,4,9],
      [3,5,1, 9,4,7, 6,2,8]
    ]
    {:ok, hsolved: hard}
  end

  defp odd_size(_) do
    odd = [
      [1,0,0, 0,5,6],
      [0,5,0, 1,2,0],

      [0,0,0, 5,6,0],
      [0,0,1, 2,0,0],

      [3,4,0, 0,0,0],
      [0,0,2, 0,4,0]
    ]
    {:ok, odd: odd}
  end

  defp odd_solved(_) do
    odd = [
      [1,2,3, 4,5,6],
      [4,5,6, 1,2,3],

      [2,3,4, 5,6,1],
      [5,6,1, 2,3,4],

      [3,4,5, 6,1,2],
      [6,1,2, 3,4,5]
    ]
    {:ok, osolved: odd}
  end

  describe "squares" do
    setup :setup_board
    test "get board squares", %{board: board} do
      assert Board.squares(board, {3, 3}) === [
        [1,0,0,0,3,8,5,7,0],
        [0,6,0,5,4,0,0,0,0],
        [5,3,8,0,0,6,2,0,9],
        [0,0,0,0,2,0,0,1,0],
        [0,0,1,4,0,5,3,0,0],
        [0,9,0,0,8,0,0,0,0],
        [3,0,1,8,0,0,7,9,4],
        [0,0,0,0,5,4,0,3,0],
        [0,2,4,3,7,0,0,0,5]
      ]
    end

    test "get first square", %{board: board} do
      assert Board.square(board, 0, {3, 3}) === [1,0,0,0,3,8,5,7,0]
    end

    test "get middle square", %{board: board} do
      assert Board.square(board, 4, {3, 3}) === [0,0,1,4,0,5,3,0,0]
    end

    test "get first square by first cell", %{board: board} do
      assert Board.square_by_cell(board, {0, 0}, {3, 3}) === [1,0,0,0,3,8,5,7,0]
    end

    test "get middle square by cell", %{board: board} do
      assert Board.square_by_cell(board, {3, 3}, {3, 3}) === [0,0,1,4,0,5,3,0,0]
    end
  end

  describe "rows" do
    setup :setup_board
    test "get board rows", %{board: board} do
      rows = Board.rows(board)
      assert rows === [
        [1,0,0,0,6,0,5,3,8],
        [0,3,8,5,4,0,0,0,6],
        [5,7,0,0,0,0,2,0,9],
        [0,0,0,0,0,1,0,9,0],
        [0,2,0,4,0,5,0,8,0],
        [0,1,0,3,0,0,0,0,0],
        [3,0,1,0,0,0,0,2,4],
        [8,0,0,0,5,4,3,7,0],
        [7,9,4,0,3,0,0,0,5]
      ]
    end

    test "get first row", %{board: board} do 
      row = Board.row(board, 0)
      assert row === [1,0,0,0,6,0,5,3,8]
    end

    test "get fist cell on first row", %{board: board} do
      cell = Board.cell(board, {0, 0})
      assert cell === 1 
    end
  end

  describe "cols" do
    setup :setup_board
    test "get board cols", %{board: board} do
      assert Board.cols(board) === [
        [1,0,5,0,0,0,3,8,7],
        [0,3,7,0,2,1,0,0,9],
        [0,8,0,0,0,0,1,0,4],

        [0,5,0,0,4,3,0,0,0],
        [6,4,0,0,0,0,0,5,3],
        [0,0,0,1,5,0,0,4,0],

        [5,0,2,0,0,0,0,3,0],
        [3,0,0,9,8,0,2,7,0],
        [8,6,9,0,0,0,4,0,5]
      ]
    end

    test "get first col", %{board: board} do
      col = Board.col(board, 0) 
      assert col === [1,0,5,0,0,0,3,8,7]
    end
  end

  describe "empty" do
    setup :setup_board
    test "cell is empty", %{board: board} do
      assert Board.is_empty?(board, {1,0}) == true
    end
  
    test "count empty cells", %{board: board} do
      assert Board.freecount(board) == 45
    end

    test "next_squares", %{board: board} do
      assert Board.next_squares(board, {3, 3}) === [
        {1, 0}, {2, 0}, {3, 0}, {5, 0},
        {0, 1}, {5, 1}, {6, 1}, {7, 1},
        {2, 2}, {3, 2}, {4, 2}, {5, 2}, 
        {7, 2}, {0, 3}, {1, 3}, {2, 3},
        {3, 3}, {4, 3}, {6, 3}, {8, 3},
        {0, 4}, {2, 4}, {4, 4}, {6, 4},
        {8, 4}, {0, 5}, {2, 5}, {4, 5},
        {5, 5}, {6, 5}, {7, 5}, {8, 5},
        {1, 6}, {3, 6}, {4, 6}, {5, 6},
        {6, 6}, {1, 7}, {2, 7}, {3, 7},
        {8, 7}, {3, 8}, {5, 8}, {6, 8}, {7, 8}
      ]
    end
  end

  describe "uniqueness" do
    setup :solved_board
    test "row is unique", %{solved: board} do
      row = Board.row(board, 0)
      assert Board.is_unique?(row) == true
    end

    test "col is unique", %{solved: board} do
      col = Board.col(board, 0)
      assert Board.is_unique?(col) == true
    end

    test "square is unique", %{solved: board} do
      square = Board.square(board, 0, {3, 3})
      assert Board.is_unique?(square) == true
    end

    test "solved board has no free cells", %{solved: board} do
      assert Sudoku.is_solution?(board) == true
    end
  end

  describe "solve" do
    setup :solved_board
    setup :setup_board 
    setup :hard_board
    setup :solved_hard
    setup :odd_size
    setup :odd_solved
    
    test "solved easy board correctly", %{board: board, solved: solved} do
      assert Sudoku.solve(board, {3, 3}) === solved
    end

    test "solved very challenging board correctly", %{hard: board, hsolved: solved} do
      assert Sudoku.solve(board, {3, 3}) === solved
    end

    test "solved a 3x2 board correctly", %{odd: board, osolved: solved} do
      assert Sudoku.solve(board, {3, 2}) === solved
    end
  
    test "hard board has one solution", %{hard: board} do
      assert Sudoku.two_solutions(board, {3, 3}) === 1
    end
  end

  describe "generate" do
    test "2x2 board generated can be solved" do
      assert Sudoku.solve(Generator.gen({2, 2}), {2, 2})
      |>Sudoku.is_solution?()
    end

    test "3x3 board generated can be solved" do
      assert Sudoku.solve(Generator.gen({3, 3}), {3, 3})
      |>Sudoku.is_solution?()
    end
    
    test "2x3 board generated can be solved" do
      assert Sudoku.solve(Generator.gen({2, 3}), {2, 3})
      |>Sudoku.is_solution?()
    end
  end

  describe "candidates" do
    setup :setup_board
    test "candidate of cell with one candidate is correct", %{board: board} do
      assert Sudoku.candidates(board, {1, 0}, {3, 3}) == [4]
    end

    test "candidate of cell with multiple candidates is correct", %{board: board} do
      assert Sudoku.candidates(board, {4, 5}, {3, 3}) == [2, 7, 8, 9]
    end

    test "update cell with new value", %{board: board} do
      assert Board.update(board, {1, 0}, 4) === [
        [1,4,0, 0,6,0, 5,3,8],
        [0,3,8, 5,4,0, 0,0,6],
        [5,7,0, 0,0,0, 2,0,9],

        [0,0,0, 0,0,1, 0,9,0],
        [0,2,0, 4,0,5, 0,8,0],
        [0,1,0, 3,0,0, 0,0,0],

        [3,0,1, 0,0,0, 0,2,4],
        [8,0,0, 0,5,4, 3,7,0],
        [7,9,4, 0,3,0, 0,0,5]
      ]
    end

    test "get candidates for all empty cells", %{board: board} do
      assert Sudoku.all_candidates(board, {3, 3}) === [
        {{1, 0}, [4]},
        {{2, 0}, [2, 9]},
        {{3, 0}, [2, 7, 9]},
        {{5, 0}, [2, 7, 9]},
        {{0, 1}, [2, 9]},
        {{5, 1}, [2, 7, 9]},
        {{6, 1}, [1, 7]},
        {{7, 1}, [1]},
        {{2, 2}, [6]},
        {{3, 2}, [1, 8]},
        {{4, 2}, [1, 8]},
        {{5, 2}, [3, 8]},
        {{7, 2}, [1, 4]},
        {{0, 3}, [4, 6]},
        {{1, 3}, [4, 5, 6, 8]},
        {{2, 3}, [3, 5, 6, 7]},
        {{3, 3}, [2, 6, 7, 8]},
        {{4, 3}, [2, 7, 8]},
        {{6, 3}, [4, 6, 7]},
        {{8, 3}, [2, 3, 7]},
        {{0, 4}, [6, 9]},
        {{2, 4}, [3, 6, 7, 9]},
        {{4, 4}, [7, 9]},
        {{6, 4}, [1, 6, 7]},
        {{8, 4}, [1, 3, 7]},
        {{0, 5}, [4, 6, 9]},
        {{2, 5}, [5, 6, 7, 9]},
        {{4, 5}, [2, 7, 8, 9]},
        {{5, 5}, [2, 6, 7, 8, 9]},
        {{6, 5}, [4, 6, 7]},
        {{7, 5}, [4, 5, 6]},
        {{8, 5}, [2, 7]},
        {{1, 6}, [5, 6]},
        {{3, 6}, [6, 7, 8, 9]},
        {{4, 6}, [7, 8, 9]},
        {{5, 6}, [6, 7, 8, 9]},
        {{6, 6}, [6, 8, 9]},
        {{1, 7}, [6]},
        {{2, 7}, [2, 6]},
        {{3, 7}, [1, 2, 6, 9]},
        {{8, 7}, [1]},
        {{3, 8}, [1, 2, 6, 8]},
        {{5, 8}, [2, 6, 8]},
        {{6, 8}, [1, 6, 8]},
        {{7, 8}, [1, 6]}
      ]
    end
  end
end
