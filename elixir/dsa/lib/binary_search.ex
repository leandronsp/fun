defmodule BinarySearch do

  @moduledoc """
  Since Binary search in linked lists are not in logarithmic time and Erlang
  lists are linked lists, we have to transform a list into a tuple prior searching.

  We can instead transform List into SkipList or apply the "Two Pointer" algorithm,
  but that wouldn't give us exact logarithmic time.

  Complexity:
  O(nlogn)

  ## Examples
      iex> BinarySearch.search([], 7)
      nil

      iex> BinarySearch.search([2], 7)
      nil

      iex> BinarySearch.search([2], 2)
      2

      iex> BinarySearch.search([1, 2], 2)
      2

      iex> BinarySearch.search([1, 2], 7)
      nil

      iex> BinarySearch.search([2, 3, 4, 5], 1)
      nil

      iex> BinarySearch.search([1, 2, 3, 4, 5], 6)
      nil

      iex> BinarySearch.search([1, 2, 3, 4, 5], 5)
      5

      iex> BinarySearch.search([10, 22, 33, 300], 35)
      nil

      iex> BinarySearch.search([10, 22, 33, 300], 33)
      33
  """

  def search([], _), do: nil
  def search([head], term) when head != term, do: nil
  def search([head | tail], term) do
    cond do
      head == term -> head
      term < head  -> nil
      head != term -> [head | tail]
        |> List.to_tuple
        |> TupleBinarySearch.search(term)
    end
  end

end
