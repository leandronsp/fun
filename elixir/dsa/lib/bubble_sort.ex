defmodule BubbleSort do
  @moduledoc """
  Documentation for BubbleSort.
  """

  @doc """
  Complexity:
  O(n^2)

  ## Examples

      iex> BubbleSort.sort([])
      []

      iex> BubbleSort.sort([2])
      [2]

      iex> BubbleSort.sort([1, 2])
      [1, 2]

      iex> BubbleSort.sort([2, 1])
      [1, 2]

      iex> BubbleSort.sort([2, 3, 1])
      [1, 2, 3]

      iex> BubbleSort.sort([2, 1, 3])
      [1, 2, 3]

      iex> BubbleSort.sort([2, 4, 1, 3])
      [1, 2, 3, 4]

      iex> BubbleSort.sort([8, 2, 4, 1, 3])
      [1, 2, 3, 4, 8]

      iex> BubbleSort.sort([1, 2, 4, 8, 3])
      [1, 2, 3, 4, 8]

      iex> BubbleSort.sort([6, 7, 5, 1, 9, 8, 10, 2, 4, 11, 22, 15])
      [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 15, 22]

      iex> BubbleSort.sort([300, 200, 1, 2, 3])
      [1, 2, 3, 200, 300]

  """

  def sort([]), do: []

  def sort([current]), do: [current]

  def sort([current|tail]) do
    larger = search_larger(tail)

    cond do
      current > larger -> sort(tail, [current])
      current < larger -> sort((tail -- [larger]) ++ [current], [larger])
    end
  end

  defp sort([], sorted), do: sorted

  defp sort([current], sorted), do: [current | sorted]

  defp sort([current|tail], sorted) do
    larger = search_larger(tail)

    cond do
      current > larger -> sort(tail, [current | sorted])
      current < larger -> sort((tail -- [larger]) ++ [current], [larger | sorted])
    end
  end

  defp search_larger([current]), do: current

  defp search_larger([current, next]) do
    if current < next, do: next, else: current
  end

  defp search_larger([current|[next|tail]]) do
    cond do
      current < next -> search_larger([next | tail])
      current > next -> search_larger([current | tail])
    end
  end
end
