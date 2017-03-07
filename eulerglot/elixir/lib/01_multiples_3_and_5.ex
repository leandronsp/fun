defmodule Multiples3And5 do

  def sum_under(ceil) do
    1..(ceil - 1) |> Enum.to_list |> sum(0)
  end

  defp sum([], acc), do: acc

  defp sum([head|tail], acc) do
    cond do
      multiple_of_3_or_5?(head) -> sum(tail, head + acc)
      true -> sum(tail, acc)
    end
  end

  defp multiple_of_3_or_5?(number) do
    Integer.mod(number, 3) == 0 || Integer.mod(number, 5) == 0
  end
end
