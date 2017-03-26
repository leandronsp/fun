defmodule RotationalCipher do
  @letter_to_idx String.split("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "")
    |> Enum.zip(0..25)
    |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, elem(x, 0), elem(x, 1)) end)

  @idx_to_letter String.split("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "")
    |> Enum.zip(0..25)
    |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, elem(x, 1), elem(x, 0)) end)

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    size = String.length(text)
    rotate(text, shift, 0, size, "")
  end

  def rotate(_, _, size, size, acc), do: acc
  def rotate(text, shift, count, size, acc) do
    char = String.at(text, count)
    idx = @letter_to_idx[String.upcase(char)]

    cond do
      idx == nil -> rotate(text, shift, count + 1, size, "#{acc}#{char}")
      idx != nil ->
        lookup = (idx + shift) |> rem(26)
        replace = @idx_to_letter[lookup] |> convert(char)
        rotate(text, shift, count + 1, size, "#{acc}#{replace}")
    end
  end

  defp convert(replace, char) do
    cond do
      String.downcase(char) == char -> String.downcase(replace)
      String.upcase(char)   == char -> String.upcase(replace)
    end
  end

end

