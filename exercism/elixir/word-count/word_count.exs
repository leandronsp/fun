defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """

  @pattern ~r/\w+-?\w*/u

  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.split
    |> do_count(%{})
  end

  defp do_count([], acc) do
    acc
  end

  defp do_count([word | tail], acc) do
    word
    |> apply_pattern
    |> sanitize
    |> reduce(acc)
    |> (&do_count(tail, &1)).()
  end

  defp apply_pattern(word) do
    case Regex.run(@pattern, word) do
      [valid] -> valid
      nil     -> nil
    end
  end

  defp sanitize(nil) do
    []
  end

  defp sanitize(word) do
    word
    |> String.downcase
    |> String.replace("_", " ")
    |> String.split
  end

  defp reduce([], acc) do
    acc
  end

  defp reduce([word | tail], acc) do
    tail |> reduce(Map.update(acc, word, 1, &inc/1))
  end

  defp inc(n), do: n + 1

end
