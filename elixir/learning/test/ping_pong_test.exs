defmodule PingPong do
  def start do
    IO.puts "#{__MODULE__} is running"
    loop()
  end

  def loop do
    receive do
      {:ping, caller} -> send(caller, :pong)
    end

    loop()
  end
end

defmodule PingPongTest do
  use ExUnit.Case
  import Mock

  @io_mock {IO, [:passthrough], []}

  setup_with_mocks([@io_mock]) do
    :ok
  end

  test "initial message" do
    spawn(PingPong, :start, [])
    assert_called IO.puts("Elixir.PingPong is running")
  end

  test "responding to pings" do
    pid = spawn(PingPong, :start, [])
    send(pid, {:ping, self()})

    assert_receive :pong
  end
end
