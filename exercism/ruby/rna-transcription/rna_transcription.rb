class Complement
  def self.of_dna(strand)
    strand.chars.reduce("") do |acc, char|
      converted = convert(char)
      return '' if converted == ''

      acc << converted
    end
  end

  def self.convert(char)
    case char
      when 'G' then 'C'
      when 'C' then 'G'
      when 'T' then 'A'
      when 'A' then 'U'
      else ''
    end
  end
end
