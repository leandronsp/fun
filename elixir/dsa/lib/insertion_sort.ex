defmodule InsertionSort do
  @moduledoc """
  Complexity:
  O(n^2)

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
  def sort([current | []]), do: [current]
  def sort([previous |[current | tail]]) do
    cond do
      current < previous -> do_sort(tail, [current, previous])
      previous < current -> do_sort(tail, [previous, current])
    end
  end

  defp do_sort([], right), do: right
  defp do_sort([head], right), do: insert(head, right)
  defp do_sort([head | tail], right) do
    do_sort(tail, insert(head, right))
  end

  defp insert(previous, []), do: [previous]
  defp insert(previous, [current | tail]) do
    cond do
      previous < current -> [previous, current | tail]
      current < previous -> [current | insert(previous, tail)]
    end
  end

end
