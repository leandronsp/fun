defmodule Fibonacci do
  @moduledoc """
  Fibonacci number given a nth sequence.
  Uses tail call optimization.

  ## Examples

      iex> Fibonacci.of_nth(1)
      1

      iex> Fibonacci.of_nth(2)
      1

      iex> Fibonacci.of_nth(7)
      13
  """

  def of_nth(nth),               do: of_nth(nth, 1, 0)
  def of_nth(0, _next, result),  do: result
  def of_nth(nth, next, result), do: of_nth(nth - 1, next + result, next)
end
