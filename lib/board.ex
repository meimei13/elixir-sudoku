defmodule Board do
  @moduledoc """
  Representation of a Sudoku board. Enumerates rows, cols, and squares.
  """

  @doc """
  Gives some basic information about our board.

  ### Examples
    
    iex> Board.cols(board)
  """

  def cell(board, {x, y}) do
    # do it lazy
    row(board, y)
    |> Enum.at(x)
  end

  def row(board, y) do 
    Enum.at(board, y)
  end

  def rows(board) do
    board
  end

  def col(board, x) do 
    Enum.map(board, fn(row) -> Enum.at(row, x) end)
  end

  def cols(board) do
    for x <- 0..(Enum.count(row(board, 0))-1), do: col(board, x)
  end

  def square(board, num, {m, n}) do
    x_size = div(Enum.count(row(board, 0)), m)
    y_size = div(Enum.count(col(board, 0)), n)

    if num > (m * n), do: throw(num)

    x_pos = (rem(num, n)) * m
    y_pos = (div(num, n)) * n

    for y <- y_pos..(y_pos + y_size - 1),
      x <- x_pos..(x_pos + x_size - 1),
      do: cell(board, {x, y})
  end

  def square_by_cell(board, {x, y}, {m, n}) do
    x_pos = x - (rem(x, m))
    y_pos = y - (rem(y, n))
    
    for y <- y_pos..(y_pos + n - 1),
      x <- x_pos..(x_pos + m - 1),
      do: cell(board, {x, y})
  end

  def squares(board, {m, n}) do
    for s <- 0..((m * n) - 1), do: square(board, s, {m, n})
  end

  def is_empty?(board, {x, y}) do
    cell(board, {x, y}) == 0
  end

  def is_unique?(vals) do
    Enum.uniq(vals) == vals
  end

  def freecount(board) do
    board = Enum.concat(board)
    Enum.count(board, fn(c) -> c == 0 end)
  end

  def next_squares(board, {m, n}) do
    for y <- 0..(m*n-1), x <- 0..(m*n-1) do 
      if is_empty?(board, {x, y}) do
        {x, y}
      end
    end 
    |>Enum.filter(fn x -> x != nil end)
  end

  def update(board, {x, y}, val) do
    row = List.replace_at(row(board, y), x, val)
    List.replace_at(board, y, row)    
  end
end
