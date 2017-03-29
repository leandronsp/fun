defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    rna |> to_charlist |> translation([], '')
  end

  defp translation([char | tail], acc, buffer) when length(buffer) == 3 do
    codon = buffer |> to_string

    case of_codon(codon) do
      {:error, "invalid codon"} -> {:error, "invalid RNA"}
      {:ok, "STOP"} -> {:ok, acc}
      {:ok, protein} -> translation(tail, acc ++ [protein], [char])
    end
  end

  defp translation([], acc, buffer) do
    codon = buffer |> to_string

    case of_codon(codon) do
      {:error, "invalid codon"} -> {:error, "invalid RNA"}
      {:ok, "STOP"} -> {:ok, acc}
      {:ok, protein} -> {:ok, acc ++ [protein]}
    end
  end

  defp translation([char | tail], acc, buffer) do
    translation(tail, acc, buffer ++ [char])
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

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case Map.get(@proteins, codon) do
      nil     -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end
end

