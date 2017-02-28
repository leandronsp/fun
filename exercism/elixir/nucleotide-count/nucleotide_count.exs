defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    count(strand, nucleotide, 0)
  end

  def count([], _, acc), do: acc

  def count([head|tail], nucleotide, acc) when head == nucleotide do
    count(tail, nucleotide, acc + 1)
  end

  def count([head|tail], nucleotide, acc), do: count(tail, nucleotide, acc)

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    histogram(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0})
  end

  def histogram([], acc), do: acc

  def histogram([head|tail], acc) do
    histogram(tail, %{acc | head => acc[head] + 1})
  end
end
