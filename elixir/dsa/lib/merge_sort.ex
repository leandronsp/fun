defmodule MergeSort do
  @moduledoc """
  Complexity:
  O(nlongn)

  ## Examples
      iex> MergeSort.sort([])
      []

      iex> MergeSort.sort([2])
      [2]

      iex> MergeSort.sort([1, 2])
      [1, 2]

      iex> MergeSort.sort([2, 1])
      [1, 2]

      iex> MergeSort.sort([2, 3, 1])
      [1, 2, 3]

      iex> MergeSort.sort([3, 1, 2])
      [1, 2, 3]

      iex> MergeSort.sort([2, 1, 3])
      [1, 2, 3]

      iex> MergeSort.sort([2, 4, 1, 3])
      [1, 2, 3, 4]

      iex> MergeSort.sort([8, 2, 4, 1, 3])
      [1, 2, 3, 4, 8]

      iex> MergeSort.sort([1, 2, 4, 8, 3])
      [1, 2, 3, 4, 8]

      iex> MergeSort.sort([6, 7, 5, 1, 9, 8, 10, 2, 4, 11, 22, 15])
      [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 15, 22]

      iex> MergeSort.sort([300, 200, 1, 2, 3])
      [1, 2, 3, 200, 300]

  """

  def sort([]), do: []
  def sort([head]), do: [head]
  def sort(list) do
    {left, right} = partition(list)
    merge(sort(left), sort(right))
  end

  defp partition(list), do: partition(list, {[], []})
  defp partition([], {left, right}), do: {left, right}
  defp partition([head | tail], {left, right}) do
    partition(tail, {right, [head | left]})
  end

  defp merge(left, right), do: merge(left, right, [])
  defp merge([], [], l3), do: l3
  defp merge([], l2, l3), do: l3 ++ l2
  defp merge(l1, [], l3), do: l3 ++ l1
  defp merge([h1 | t1], [h2 | t2], l3) when h1 >= h2, do: merge([h1 | t1], t2, l3 ++ [h2])
  defp merge([h1 | t1], [h2 | t2], l3) do
    merge(t1, [h2 | t2], l3 ++ [h1])
  end
end
