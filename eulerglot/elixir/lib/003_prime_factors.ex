defmodule PrimeFactors do

  @moduledoc """
  The prime factors of 13195 are 5, 7, 13 and 29.
  What is the largest prime factor of the number 600851475143 ?
  """

  def largest(number) when number < 1, do: 0
  def largest(number) do
    {number, largest} = div_by(number, 2, 0)

    cond do
      number == 1 -> 2
      true ->
        {number, largest} = div_by_prime(number, 3, largest)
        if number > 2, do: number, else: largest
    end
  end

  defp div_by_prime(number, prime, largest) do
    case prime <= :math.sqrt(number) do
      true ->
        {number, _} = div_by(number, prime, largest)
        div_by_prime(number, prime + 2, prime)
      false ->
        {number, largest}
    end
  end

  defp div_by(number, multiple, largest) do
    case rem(number, multiple) == 0 do
      true  -> (number / multiple) |> round |> div_by(multiple, multiple)
      false -> {number, largest}
    end
  end

end
