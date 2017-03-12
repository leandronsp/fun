class Multiples3And5

  def self.sum_under(ceil)
    number = ceil - 1
    sum_multiples_of(3, number) + sum_multiples_of(5, number) - sum_multiples_of(15, number)
  end

  private

  def self.sum_multiples_of(multiple, number)
    count = number / multiple
    ((multiple + (count * multiple)) / 2.0) * count
  end

end
