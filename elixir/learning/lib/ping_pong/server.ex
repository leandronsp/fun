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
    count
  end
end
