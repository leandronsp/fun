defmodule ProcessesTest do
  use ExUnit.Case

  test "creating a ping/pong process" do
    pid = spawn(fn ->
      receive do
        {:ping, caller} -> send(caller, :pong)
      end
    end)

    send(pid, {:ping, self()})

    assert_receive :pong
  end
end
