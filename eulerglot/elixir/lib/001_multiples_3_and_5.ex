defmodule Multiples3And5 do
  @moduledoc """
  ## Problem
    If we list all the natural numbers below 10 that are multiples of 3 or 5,
    we get 3, 5, 6 and 9. The sum of these multiples is 23.
    Find the sum of all the multiples of 3 or 5 below 1000.

  ## Solution
    By using arithmetic progression our time complexity is O(1).
    Sum all multiples of 3 by multiples of 5, and to avoid repetition on 15 (because
    3 x 5), subtract the multiples of 15:
      Count = Floor(n / m), where n is the max and m is the multiple
      Sum = ((1 + Count) / 2) * Count
  """

  def sum_under(ceil) do
    number = ceil - 1
    sum_multiples_of(3, number) + sum_multiples_of(5, number) - sum_multiples_of(15, number)
  end

  defp sum_multiples_of(multiple, number) do
    count = ((number / multiple) |> Float.floor)
    ((multiple + (count * multiple)) / 2.0) * count
  end
end
