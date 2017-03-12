defmodule Multiples3And5 do
  @moduledoc """
  If we list all the natural numbers below 10 that are multiples of 3 or 5,
  we get 3, 5, 6 and 9. The sum of these multiples is 23.
  Find the sum of all the multiples of 3 or 5 below 1000.
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
