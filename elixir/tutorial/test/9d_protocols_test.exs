defmodule ProtocolsTest do
  use ExUnit.Case
  defprotocol Blank do
    @doc "Returns true if data is considered blank/empty"
    def blank?(data)
  end

  defimpl Blank, for: List do
    def blank?([]), do: true
    def blank?(_), do: false
  end

  defimpl Blank, for: Map do
    def blank?(map), do: map_size(map) == 0
  end

  defimpl Blank, for: Tuple do
    def blank?({}), do: true
    def blank?(_), do: false
  end

  defimpl Blank, for: Integer do
    def blank?(_), do: false
  end

  defimpl Blank, for: Any do
    def blank?(_), do: false
  end

  defmodule User do
    @derive Blank
    defstruct name: "Leandro", age: 29
  end

  test "checks for integer, list and map" do
    assert Blank.blank?(1) == false
    assert Blank.blank?([1, 2]) == false
    assert Blank.blank?([]) == true
    assert Blank.blank?(%{}) == true
    assert Blank.blank?({}) == true
  end

  test "checks for User" do
    assert Blank.blank?(%User{}) == false
  end
end
