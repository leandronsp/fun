defmodule TupleBinarySearch do
  @moduledoc """
  Documentation for TupleBinarySearch.
  """

  @doc """
  Since Binary search in linked lists are not in logarithmic time and Erlang
  lists are linked lists, we have to transform a list into a tuple prior searching.

  We can instead transform List into SkipList or apply the "Two Pointer" algorithm,
  but that wouldn't give us exact logarithmic time.

  Complexity:
  O(logn)

  ## Examples

      iex> TupleBinarySearch.search({}, 7)
      nil

      iex> TupleBinarySearch.search({2}, 7)
      nil

      iex> TupleBinarySearch.search({2, 3, 4}, 7)
      nil

      iex> TupleBinarySearch.search({1, 2, 3, 4}, 1)
      1

      iex> TupleBinarySearch.search({1, 2, 3, 4}, 4)
      4

      iex> TupleBinarySearch.search({300, 400, 500, 1000}, 500)
      500

  """

  def search({}, _), do: nil
  def search({head}, term) when head != term, do: nil

  def search(tuple, term) do
    start = 0
    size  = tuple_size(tuple) - 1
    search(tuple, term, start, size)
  end

  def search(_, _, start, size) when size < start, do: nil

  def search(tuple, term, start, size) do
    mid   = start + size |> div(2) |> round
    pivot = elem(tuple, mid)

    cond do
      term == pivot -> pivot
      term < pivot  -> search(tuple, term, start, mid - 1)
      term > pivot  -> search(tuple, term, mid + 1, size)
    end
  end

end
