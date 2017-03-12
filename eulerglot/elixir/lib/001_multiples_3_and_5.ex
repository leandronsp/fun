defmodule Multiples3And5 do
  def sum_under(ceil) do
    number = ceil - 1
    sum_multiples_of(3, number) + sum_multiples_of(5, number) - sum_multiples_of(15, number)
  end

  defp sum_multiples_of(multiple, number) do
    count = ((number / multiple) |> Float.floor)
    ((multiple + (count * multiple)) / 2.0) * count
  end
end
