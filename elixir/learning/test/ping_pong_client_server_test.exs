defmodule PingPong.Server do
  def init(count), do: loop(count)

  def loop(count) do
    new_count = receive do
      message -> handle_receive(message, count)
    end

    loop(new_count)
  end

  def handle_receive({:ping, caller}, count) do
    send(caller, :pong)
    count + 1
  end

  def handle_receive({:stats, caller}, count) do
    send(caller, {:stats, count})
  end
end

defmodule PingPong.Client do
  def start_link do
    spawn(PingPong.Server, :init, [0])
  end

  def ping(pid) do
    send(pid, {:ping, self()})
  end

  def stats(pid) do
    send(pid, {:stats, self()})
  end

  def fetch_stats(pid) do
    stats(pid)

    receive do
      {:stats, count} -> count
    end
  end
end

defmodule PingPongClientServerTest do
  use ExUnit.Case

  test "client fetching stats" do
    pid = PingPong.Client.start_link()

    PingPong.Client.ping(pid)
    PingPong.Client.ping(pid)
    PingPong.Client.ping(pid)
    PingPong.Client.ping(pid)

    assert PingPong.Client.fetch_stats(pid) == 4
  end
end
