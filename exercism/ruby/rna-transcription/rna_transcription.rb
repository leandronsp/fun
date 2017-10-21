class Complement
  DNA_TO_RNA = {
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
  }

  def self.of_dna(strand)
    strand.chars.reduce("") do |acc, char|
      converted = fetch(char)
      return '' if converted == ''

      acc << converted
    end
  end

  def self.fetch(char)
    DNA_TO_RNA.fetch(char, '')
  end
end
