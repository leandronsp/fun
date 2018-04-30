defmodule YatsTest do
  use ExUnit.Case
  doctest Yats

  test "greets the world" do
    assert Yats.hello() == :world
  end
end
