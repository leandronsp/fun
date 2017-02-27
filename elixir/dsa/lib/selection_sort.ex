defmodule SelectionSort do
  @moduledoc """
  Documentation for SelectionSort.
  """

  @doc """
  Algorithm:
  FIND:EACH
    FIND:SMALLER FROM CURRENT UNTIL END
    REPLACE WITH SMALLER

  Complexity:
  O(n^2)

  ## Examples

      iex> SelectionSort.sort([])
      []

      iex> SelectionSort.sort([2])
      [2]

      iex> SelectionSort.sort([1, 2])
      [1, 2]

      iex> SelectionSort.sort([2, 1])
      [1, 2]

      iex> SelectionSort.sort([2, 3, 1])
      [1, 2, 3]

      iex> SelectionSort.sort([2, 1, 3])
      [1, 2, 3]

      iex> SelectionSort.sort([2, 4, 1, 3])
      [1, 2, 3, 4]

      iex> SelectionSort.sort([8, 2, 4, 1, 3])
      [1, 2, 3, 4, 8]

      iex> SelectionSort.sort([1, 2, 4, 8, 3])
      [1, 2, 3, 4, 8]

      iex> SelectionSort.sort([6, 7, 5, 1, 9, 8, 10, 2, 4, 11, 22, 15])
      [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 15, 22]

      iex> SelectionSort.sort([300, 200, 1, 2, 3])
      [1, 2, 3, 200, 300]

  """

  def sort([]), do: []

  def sort([current]), do: [current]

  def sort([current|tail]) do
    smaller = search_smaller(tail)

    cond do
      current > smaller -> sort([smaller], [current | tail] -- [smaller])
      current < smaller -> sort([current, smaller], tail -- [smaller])
    end
  end

  defp sort(left, []), do: left

  defp sort(left, [current]), do: left ++ [current]

  defp sort(left, [current|tail]) do
    smaller = search_smaller(tail)

    cond do
      current > smaller -> sort(left ++ [smaller], [current | tail] -- [smaller])
      current < smaller -> sort(left ++ [current, smaller], tail -- [smaller])
    end
  end

  defp search_smaller([current]), do: current

  defp search_smaller([current, next]) do
    if current < next, do: current, else: next
  end

  defp search_smaller([current|[next|tail]]) do
    cond do
      current < next -> search_smaller([current | tail])
      current > next -> search_smaller([next | tail])
    end
  end

end
