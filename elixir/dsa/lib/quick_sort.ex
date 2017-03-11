defmodule QuickSort do
  @moduledoc """
  Complexity:
  O(nlongn)

  ## Examples
      iex> QuickSort.sort([])
      []

      iex> QuickSort.sort([2])
      [2]

      iex> QuickSort.sort([1, 2])
      [1, 2]

      iex> QuickSort.sort([2, 1])
      [1, 2]

      iex> QuickSort.sort([2, 3, 1])
      [1, 2, 3]

      iex> QuickSort.sort([3, 1, 2])
      [1, 2, 3]

      iex> QuickSort.sort([2, 1, 3])
      [1, 2, 3]

      iex> QuickSort.sort([2, 4, 1, 3])
      [1, 2, 3, 4]

      iex> QuickSort.sort([8, 2, 4, 1, 3])
      [1, 2, 3, 4, 8]

      iex> QuickSort.sort([1, 2, 4, 8, 3])
      [1, 2, 3, 4, 8]

      iex> QuickSort.sort([6, 7, 5, 1, 9, 8, 10, 2, 4, 11, 22, 15])
      [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 15, 22]

      iex> QuickSort.sort([300, 200, 1, 2, 3])
      [1, 2, 3, 200, 300]
  """

  def sort([]), do: []
  def sort([head]), do: [head]

  def sort([pivot | tail]) do
    {smaller, larger} = partition(pivot, tail, [], [])
    sort(smaller) ++ [pivot] ++ sort(larger)
  end

  @doc """
  ## Examples
      iex> QuickSort.partition(4, [2, 1, 6, 3, 5, 7], [], [])
      {[3, 1, 2], [7, 5, 6]}
  """
  def partition(_, [], smaller, larger), do: {smaller, larger}
  def partition(pivot, [head | tail], smaller, larger) do
    cond do
      head <= pivot -> partition(pivot, tail, [head | smaller], larger)
      pivot < head  -> partition(pivot, tail, smaller, [head | larger])
    end
  end

end
