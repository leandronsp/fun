defmodule EvenFiboNumbers do
  @moduledoc """
  Each new term in the Fibonacci sequence is generated by adding the previous two terms.
  By starting with 1 and 2, the first 10 terms will be:

    1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

  By considering the terms in the Fibonacci sequence whose values do not exceed
  four million, find the sum of the even-valued terms.
  """

  def sum_under(ceil) when ceil < 2,  do: 0
  def sum_under(ceil) when ceil < 10, do: 2
  def sum_under(ceil) do
    acc = 0
    previous = 2
    current = 8
    sum = previous + current

    do_sum(previous, current, sum, acc, ceil)
  end

  defp do_sum(previous, current, sum, acc, ceil) do
    case current < ceil do
      true ->
        sum = sum + acc
        acc = (4 * current) + previous

        do_sum(current, acc, sum, acc, ceil)
      false -> sum
    end
  end

end
