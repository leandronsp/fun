class EvenFiboNumbers

  def self.sum_under(ceil)
    return 0  if ceil < 2
    return 2  if ceil < 10

    acc      = 0
    previous = 2
    current  = 8
    sum      = previous + current

    while current < ceil
      sum += acc
      acc = (4 * current) + previous
      previous = current
      current = acc
    end

    sum
  end

end
