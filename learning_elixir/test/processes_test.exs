defmodule Processes do
  use ExUnit.Case

  test "sending messages" do
    send self(), {:hello, "Leandro"}

    received = receive do
      {:hello, name} -> "My name is #{name}"
      "fompila" -> "won't match"
    end

    assert received == "My name is Leandro"
  end

  test "KeyValueStore" do
    {:ok, pid} = KeyValueStore.start_link
    send pid, {:put, :name, "Leandro"}
    send pid, {:get, :name, self()}
  end

end

defmodule KeyValueStore do
  def start_link do
    Task.start_link fn ->
      loop(%{})
    end
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop map
      {:put, key, value} ->
        loop Map.put(map, key, value)
    end
  end
end

