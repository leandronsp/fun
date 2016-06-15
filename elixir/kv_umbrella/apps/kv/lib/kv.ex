defmodule KV do
  use Application

  def start(_type, args) do
    KV.Supervisor.start_link
  end
end
