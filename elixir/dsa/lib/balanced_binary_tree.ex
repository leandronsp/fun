require IEx

defmodule BalancedBinaryTree do
  @moduledoc """
  Documentation for BalancedBinaryTree.
  """

  @doc """
  ## Examples

      iex> BalancedBinaryTree.empty
      {:node, nil}
  """

  def empty, do: {:node, nil}

  def insert({:node, nil}, key, value) do
    {:node, {key, value, empty(), empty()}}
  end

  def insert({:node, {pk, pv, {:node, nil}, {:node, nil}}}, k, v) do
    cond do
      pk > k -> {:node, {pk, pv, insert(empty(), k, v), empty()}}
      pk < k -> {:node, {pk, pv, empty(), insert(empty(), k, v)}}
    end
  end

  def insert({:node, {pk, pv, {:node, nil}, {:node, {rk, rv, rl, rr}}}}, k, v) do
    cond do
      pk > k -> {:node, {pk, pv, insert(empty(), k, v), {:node, {rk, rv, rl, rr}}}}
      pk < k -> {:node, {rk, rv, insert(rl, pk, pv), insert(rr, k, v)}}
    end
  end

  def insert({:node, {pk, pv, {:node, {lk, lv, ll, lr}, {:node, nil}}}}, k, v) do
    cond do
      pk > k -> {:node, {lk, lv, insert(ll, pk, pv), insert(lr, k, v)}}
      pk < k -> {:node, {pk, pv, {:node, {lk, lv, ll, lr}}, insert(empty(), k, v)}}
    end
  end

  def insert({:node, {pk, pv, {:node, {lk, lv, ll, lr}}, {:node, {rk, rv, rl, rr}}}}, k, v) do
    cond do
      pk > k -> {:node, {pk, pv, {:node, {lk, lv, insert(ll, k, v), lr}}, {:node, {rk, rv, rl, rr}}}}
      pk < k ->
        if ll == {:node, nil} do
          {:node, {rk, rv, {:node, {pk, pv, insert(ll, lk, lv), lr}}, insert(rl, k, v)}}
        else
          {:node, {pk, pv, {:node, {lk, lv, ll, lr}}, {:node, {rk, rv, rl, insert(rr, k, v)}}}}
        end
    end
  end

end
