defmodule HashTable do
  @moduledoc """
  Documentation for HashTable.
  """

  @doc """
  ## Examples

      iex> HashTable.index("name")
      417

      iex> hash = HashTable.insert({}, "name", "Leandro")
      iex> HashTable.get(hash, "name")
      "Leandro"

  """

  def index([]), do: 0

  def index(str) do
    [char|tail] = to_charlist(str)
    char + index(tail)
  end

  def expand(hash, 0), do: hash

  def expand(hash, iterator) do
    expand(Tuple.append(hash, nil), iterator - 1)
  end

  def insert(hash, key, value) do
    idx  = index(key)
    size = tuple_size(hash)

    case size > idx do
      true  ->
        hash
        |> put_elem(idx, value)
      false ->
        hash
        |> expand(idx - size + 1)
        |> put_elem(idx, value)
    end
  end

  def get(hash, key) do
    idx = index(key)
    elem(hash, idx)
  end
end
