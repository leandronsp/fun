defmodule LcQuickSort do
  @moduledoc """
  Complexity:
  O(nlongn)

  ## Examples
      iex> LcQuickSort.sort([])
      []

      iex> LcQuickSort.sort([2])
      [2]

      iex> LcQuickSort.sort([1, 2])
      [1, 2]

      iex> LcQuickSort.sort([2, 1])
      [1, 2]

      iex> LcQuickSort.sort([2, 3, 1])
      [1, 2, 3]

      iex> LcQuickSort.sort([3, 1, 2])
      [1, 2, 3]

      iex> LcQuickSort.sort([2, 1, 3])
      [1, 2, 3]

      iex> LcQuickSort.sort([2, 4, 1, 3])
      [1, 2, 3, 4]

      iex> LcQuickSort.sort([8, 2, 4, 1, 3])
      [1, 2, 3, 4, 8]

      iex> LcQuickSort.sort([1, 2, 4, 8, 3])
      [1, 2, 3, 4, 8]

      iex> LcQuickSort.sort([6, 7, 5, 1, 9, 8, 10, 2, 4, 11, 22, 15])
      [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 15, 22]

      iex> LcQuickSort.sort([300, 200, 1, 2, 3])
      [1, 2, 3, 200, 300]
  """

  def sort([]), do: []
  def sort([head]), do: [head]
  def sort([pivot | tail]) do
    sort(for smaller <- tail, smaller <= pivot, do: smaller)
    ++ [pivot] ++
    sort(for larger <- tail, larger > pivot, do: larger)
  end

end
