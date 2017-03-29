defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    rna
    |> translation([])
  end

  @proteins %{
    "AUG" => "Methionine",
    "UGG" => "Tryptophan",
    "UGU" => "Cysteine",      "UGC" => "Cysteine",
    "UUA" => "Leucine",       "UUG" => "Leucine",
    "UUU" => "Phenylalanine", "UUC" => "Phenylalanine",
    "UAU" => "Tyrosine",      "UAC" => "Tyrosine",
    "UCU" => "Serine",        "UCC" => "Serine",        "UCA" => "Serine", "UCG" => "Serine",
    "UAA" => "STOP",          "UAG" => "STOP",          "UGA" => "STOP"
  }

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    @proteins
    |> Map.get(codon)
    |> protein_please
  end

  # OMG, really loved Kernel.SpecialForms <3
  defp translation(<<>>, acc), do: {:ok, acc}
  defp translation(<<char::binary-size(3), tail::binary>>, acc) do
    char
    |> of_codon
    |> translate_please(tail, acc)
  end

  defp translate_please({:error, _}, _tail, _acc), do: {:error, "invalid RNA"}
  defp translate_please({:ok, "STOP"}, _tail, acc), do: {:ok, acc}
  defp translate_please({:ok, protein}, tail, acc) do
    translation(tail, acc ++ [protein])
  end

  defp protein_please(nil), do: {:error, "invalid codon"}
  defp protein_please(yay), do: {:ok, yay}
end

