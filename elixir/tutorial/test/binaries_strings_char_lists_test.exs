defmodule BinariesStringsCharListsTest do
  use ExUnit.Case

  test "codepoints" do
    assert ?a == 97
    assert ?h == 104

    assert String.codepoints("hello") == ["h", "e", "l", "l", "o"]
  end

  test "binaries" do
    assert byte_size(<<0, 1, 2, 3>>) == 4

    code_points = [?l, ?e, ?a, ?n, ?d, ?r, ?o]
    binary = <<?l, ?e, ?a, ?n, ?d, ?r, ?o>>

    assert byte_size("leandro") == byte_size(binary)

    assert code_points == [108, 101, 97, 110, 100, 114, 111]
    assert 'leandro' == [108, 101, 97, 110, 100, 114, 111]
  end
end
