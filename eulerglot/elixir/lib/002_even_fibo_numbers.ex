require IEx

defmodule EvenFiboNumbers do

  def sum_under(0), do: 0

  def sum_under(ceil) do
    sum_fibo(1, 0, ceil, 0)
  end

  defp sum_fibo(_, _, ceil, acc) when ceil <= 0, do: acc

  defp sum_fibo(current, previous, ceil, acc) do
    number = current + previous

    case Integer.mod(number, 2) == 0 do
      true  -> sum_fibo(number, current, ceil - current, acc + number)
      false -> sum_fibo(number, current, ceil - current, acc)
    end
  end

end
