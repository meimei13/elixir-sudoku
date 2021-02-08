defmodule Generator do
  alias Board
  alias Sudoku
  @moduledoc """
  Documentation for `Generator`.
  """

  def empty_board({m, n}) do
    List.duplicate(0, m*n)
    |> List.duplicate(m*n)  
  end

  def gen(board, {m, n}) do
    filled_coord = for y <- 0..(m*n-1), x <- 0..(m*n-1) do 
      if !(Board.is_empty?(board, {x, y})) do
        {x, y}
      end
    end 
    |>Enum.filter(fn x -> x != nil end)
    |>Enum.shuffle()
    |>List.first()

    new_board = Board.update(board, filled_coord, 0)
    solve_count = Sudoku.two_solutions(new_board, {m, n})
    if solve_count != 1 do
      board
    else
      gen(new_board, {m, n})
    end
  end

  def gen({m, n}) do
    if m == 0 || n == 0, do: throw({m, n})
    gen(Sudoku.solve(empty_board({m, n}), {m, n}), {m, n})
  end

  def test() do
    Sudoku.solve(empty_board({3, 3}), {3,3})
  end
end
