defmodule SpecialFormsTest do
  use ExUnit.Case

  def split_string(<<>>, acc), do: acc
  def split_string(<<head, tail::binary>>, acc) do
    split_string(tail, acc ++ [<<head>>])
  end

  def split_string_in_chunks(<<>>, acc), do: acc
  def split_string_in_chunks(<<head::binary-size(3), tail::binary>>, acc) do
    split_string_in_chunks(tail, acc ++ [head])
  end

  test "split word" do
    assert split_string("abc", []) == ~w(a b c)
  end

  test "split word in chunks of 3" do
    assert split_string_in_chunks("abcdefghijkl", []) == ~w(abc def ghi jkl)
  end

end
