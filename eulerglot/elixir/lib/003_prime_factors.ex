defmodule PrimeFactors do

  @moduledoc """
  The prime factors of 13195 are 5, 7, 13 and 29.
  What is the largest prime factor of the number 600851475143 ?
  """

  def largest(ceil) do
    prime_factors(2, ceil, [])
    |> Enum.max
  end

  defp prime_factors(start, start, acc) do
    acc ++ [start]
  end

  defp prime_factors(start, number, acc) when rem(number, start) == 0 do
    prime_factors(start, (number / start) |> round, acc ++ [start])
  end

  defp prime_factors(start, number, acc) do
    prime_factors(start + 1, number, acc)
  end

end
