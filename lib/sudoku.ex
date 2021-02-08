defmodule Sudoku do
  alias Board
  @moduledoc """
  Documentation for `Sudoku`.
  """

  def candidates(board, {x, y}, {m, n}) do
    row = Board.row(board, y)
    col = Board.col(board, x)
    square = Board.square_by_cell(board, {x, y}, {m, n}) 
    
    cands = 1..(m*n)
    Enum.reject(cands, fn x -> x in Enum.concat(Enum.concat(row, col), square) end)
  end

  def all_candidates(board, {m, n}) do
    next = Board.next_squares(board, {m, n})
    Enum.map(next, fn {x, y} -> {{x, y}, candidates(board, {x, y}, {m, n})} end)
  end

  def sort_constrained(candidates) do
    Enum.sort_by(candidates, fn {_, cands} -> Enum.count(cands) end)
  end

  def is_solution?(board) do
    Board.freecount(board) == 0
  end

  def solve(board, {m, n}) do
    case sort_constrained(all_candidates(board, {m, n})) do
      [] -> board
      [{coord, cands} | _] -> Enum.find_value(Enum.shuffle(cands), fn cand ->
          new_board = Board.update(board, coord, cand)
          solve(new_board, {m, n})
      end)
    end
  end

  def two_solutions(board, {m, n}) do
    case sort_constrained(all_candidates(board, {m, n})) do
      [] -> 1
      [{coord, cands} | _] -> List.foldl(cands, 0, fn cand, acc -> 
          if acc >= 2 do
            2
          else
            new_board = Board.update(board, coord, cand)
            min(acc + two_solutions(new_board, {m, n}), 2)
          end
        end) 
    end
  end
end
