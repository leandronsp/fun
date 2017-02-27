defmodule BinaryTree do
  @moduledoc """
  Documentation for BinaryTree.
  """

  @doc """
  ## Examples

      iex> BinaryTree.empty
      {:node, nil}

      iex> BinaryTree.insert(BinaryTree.empty(), "Jim", "elixir")
      {:node, {"Jim", "elixir", {:node, nil}, {:node, nil}}}

      iex> BinaryTree.search(BinaryTree.empty(), "Jim")
      nil

      iex> tree = BinaryTree.insert(BinaryTree.empty(), "Jim", "elixir")
      iex> BinaryTree.search(tree, "Jim")
      "elixir"

  """

  def empty, do: {:node, nil}

  def insert({:node, nil}, key, value) do
    {:node, {key, value, empty(), empty()}}
  end

  def insert({:node, {parent_key, parent_value, left, right}}, key, value) do
    cond do
      parent_key > key -> {:node, {parent_key, parent_value, insert(left, key, value), right}}
      parent_key < key -> {:node, {parent_key, parent_value, left, insert(right, key, value)}}
    end
  end

  def search({:node, nil}, _), do: nil

  def search({:node, {key, value, _, _}}, term) when term == key, do: value

  def search({:node, {key, _, left, right}}, term) do
    cond do
      key > term -> search(left, term)
      key < term -> search(right, term)
    end
  end

  def invert({:node, nil}), do: {:node, nil}

  def invert({:node, {key, value, left, right}}) do
    {:node, {key, value, invert(right), invert(left)}}
  end
end
