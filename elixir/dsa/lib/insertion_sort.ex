defmodule InsertionSort do
  @moduledoc """
  Documentation for InsertionSort.
  """

  @doc """
  Algorithm:
  WHILE:CURRENT < PREVIOUS
    REPLACE WITH PREVIOUS

  Complexity:
  O(n) -> O(n^2)

  ## Examples

      iex> InsertionSort.sort([])
      []

      iex> InsertionSort.sort([2])
      [2]

      iex> InsertionSort.sort([1, 2])
      [1, 2]

      iex> InsertionSort.sort([2, 1])
      [1, 2]

      iex> InsertionSort.sort([2, 3, 1])
      [1, 2, 3]

      iex> InsertionSort.sort([3, 1, 2])
      [1, 2, 3]

      iex> InsertionSort.sort([2, 1, 3])
      [1, 2, 3]

      iex> InsertionSort.sort([2, 4, 1, 3])
      [1, 2, 3, 4]

      iex> InsertionSort.sort([8, 2, 4, 1, 3])
      [1, 2, 3, 4, 8]

      iex> InsertionSort.sort([1, 2, 4, 8, 3])
      [1, 2, 3, 4, 8]

      iex> InsertionSort.sort([6, 7, 5, 1, 9, 8, 10, 2, 4, 11, 22, 15])
      [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 15, 22]

      iex> InsertionSort.sort([300, 200, 1, 2, 3])
      [1, 2, 3, 200, 300]

  """

  def sort([]), do: []
  def sort([current|[]]), do: [current]

  def sort([previous|[current|[]]]) do
    cond do
      current < previous -> [current] ++ [previous]
      previous < current -> [previous] ++ [current]
    end
  end

  def sort([previous|[current|tail]]) do
    cond do
      current < previous -> sort(tail, [current] ++ [previous])
      previous < current -> sort(tail, [previous] ++ [current])
    end
  end

  def sort([], right), do: right

  def sort([head|[]], right) do
    insert(head, right)
  end

  def sort([head|tail], right) do
    sort(tail, insert(head, right))
  end

  defp insert(previous, [current|tail]) do
    cond do
      previous < current -> [previous] ++ [current] ++ tail
      current < previous -> [current] ++ insert(previous, tail)
    end
  end

  defp insert(previous, []), do: [previous]

end
