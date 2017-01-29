defmodule ModuleAttributesTest do
  use ExUnit.Case

  defmodule MyServer do
    @version 42
    def first_version, do: @version
    @version 44
    def second_version, do: @version
  end

  test "attrs are read at compilation time" do
    assert MyServer.first_version == 42
    assert MyServer.second_version == 44
  end
end

