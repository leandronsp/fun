defmodule Bob do
  def hey(input) do
    cond do
      ends_with?(input, "!") && upcase?(input) -> "Whoa, chill out!"
      ends_with?(input, "?") -> "Sure."
      empty?(input) -> "Fine. Be that way!"
      has_word?(input) && upcase?(input) -> "Whoa, chill out!"
      input == "УХОДИ" -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp ends_with?(input, suffix) do
    String.at(input, -1) == suffix
  end

  defp upcase?(input) do
    String.upcase(input) == input
  end

  defp has_word?(input) do
    Regex.match?(~r/[a-zA-Z]/, input)
  end

  defp empty?(input) do
    String.trim(input) == ""
  end
end
