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
