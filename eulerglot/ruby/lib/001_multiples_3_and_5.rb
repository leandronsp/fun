class Multiples3And5

  def self.sum_under(ceil)
    sum((1..ceil - 1).to_a, 0)
  end

  private

  def self.sum(array, acc)
    return acc if array == []
    number = array.at(-1)

    if number % 3 == 0 || number % 5 == 0
      return sum(tail(array), number + acc)
    end

    sum(tail(array), acc)
  end

  def self.tail(array)
    array.slice(0, array.length - 1)
  end

end
