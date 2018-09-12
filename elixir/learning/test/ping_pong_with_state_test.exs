defmodule PingPongWithState do
  def start_link do
    spawn(__MODULE__, :init, [0])
  end

  def init(count), do: loop(count)

  def loop(count) do
    new_count = receive do
      {:ping, caller} ->
        send(caller, :pong)
        count + 1
      {:stats, caller} ->
        send(caller, {:stats, count})
    end

    loop(new_count)
  end
end

defmodule PingPongWithStateTest do
  use ExUnit.Case

  test "responding to pings" do
    pid = PingPongWithState.start_link()
    send(pid, {:ping, self()})

    assert_receive :pong
  end

  test "receiving stats" do
    pid = PingPongWithState.start_link()
    send(pid, {:ping, self()})
    send(pid, {:ping, self()})
    send(pid, {:ping, self()})

    send(pid, {:stats, self()})

    assert_receive {:stats, 3}
  end
end
