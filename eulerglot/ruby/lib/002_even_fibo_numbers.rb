class EvenFiboNumbers

  def self.sum_under(ceil)
    raise ArgumentError if ceil > 4_000_000
    sum_fibo(1, 0, ceil, 0)
  end

  def self.sum_fibo(current, previous, ceil, acc)
    return acc if ceil <= 0
    number = current + previous

    if number % 2 == 0
      sum_fibo(number, current, ceil - current, acc + number)
    else
      sum_fibo(number, current, ceil - current, acc)
    end
  end

end
