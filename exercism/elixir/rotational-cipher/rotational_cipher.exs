defmodule RotationalCipher do
  @start_lower ?a
  @stop_lower  ?z
  @start_upper ?A
  @stop_upper  ?Z
  @alphabet_length 26

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&do_rotate(&1, shift))
    |> to_string
  end

  defp do_rotate(code, shift) when code >= @start_lower and code <= @stop_lower do
    @start_lower + ((code + shift - @start_lower) |> rem(@alphabet_length))
  end

  defp do_rotate(code, shift) when code >= @start_upper and code <= @stop_upper do
    @start_upper + ((code + shift - @start_upper) |> rem(@alphabet_length))
  end

  defp do_rotate(code, _shift) do
    code
  end
end

