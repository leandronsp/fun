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
