defmodule MySigils do
  def sigil_i(string, []), do: String.to_integer(string)
  def sigil_i(string, [?n]), do: -String.to_integer(string)
end

defmodule SigilsTest do
  use ExUnit.Case

  test "regular expressions" do
    regex = ~r/foo|bar/
    assert "foo" =~ regex
    assert "bar" =~ regex
    refute "baz" =~ regex
  end

  test "strings" do
    ~s(this is a string with "double" quotes and 'single' quotes)
    doc = ~s"""
I'm a here doc string.
Check out the documentation "bro"
"""
    assert doc == "I'm a here doc string.\nCheck out the documentation \"bro\"\n"
  end

  test "lists" do
    assert ~w(1 2 3) == ["1", "2", "3"]
    assert ~w(name age)a == [:name, :age]
  end

  test "custom Sigil" do
    import MySigils
    assert ~i(13) == 13
    assert ~i(42)n == -42
  end
end
