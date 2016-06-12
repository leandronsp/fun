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

  test "KeyValueStore as Task" do
    {:ok, pid} = KeyValueStore.start_link
    send pid, {:put, :name, "Leandro"}
    send pid, {:get, :name, self()}
  end

  test "key value store as Agent" do
    {:ok, pid} = Agent.start_link fn -> %{} end

    Agent.update pid, fn(map) ->
      Map.put map, :name, "Leandro"
    end

    result = Agent.get pid, fn(map) ->
      Map.get map, :name
    end

    assert result == "Leandro"
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

