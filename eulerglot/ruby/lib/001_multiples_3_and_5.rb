class Multiples3And5

  def self.sum_under(ceil)
    sum((1..ceil - 1).to_a, 0)
  end

  private

  def self.sum(array, acc)
    return acc if array == []

    number = array.pop

    if number % 3 == 0 || number % 5 == 0
      result = number + acc
    else
      result = acc
    end

    sum(array, result)
  end

end
