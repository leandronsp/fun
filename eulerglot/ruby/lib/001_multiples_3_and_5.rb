class Multiples3And5
  def self.under(ceil)
    (1...ceil).select do |number|
      number % 5 == 0 || number % 3 == 0
    end
  end

  def self.sum_under(ceil)
    under(ceil).reduce(:+)
  end
end
