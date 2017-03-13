defmodule PrimeFactors do

  @moduledoc """
  The prime factors of 13195 are 5, 7, 13 and 29.
  What is the largest prime factor of the number 600851475143 ?
  """

  def largest(number) when number < 1, do: 0
  def largest(number) do
    div_by(number, 2)
    |> factor_prime(3)
  end

  defp factor_prime(1, _), do: 2
  defp factor_prime(number, prime) do
    {number, largest} = factor_prime(number, prime, 0)
    if number > 2, do: number, else: largest
  end

  defp factor_prime(number, prime, largest) do
    if prime > :math.sqrt(number) do
      {number, largest}
    else
      number = div_by(number, prime)
      factor_prime(number, prime + 2, prime)
    end
  end

  defp div_by(number, multiple) when rem(number, multiple) != 0, do: number
  defp div_by(number, multiple) do
    (number / multiple) |> round |> div_by(multiple)
  end

end
