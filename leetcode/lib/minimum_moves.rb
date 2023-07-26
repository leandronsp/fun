module MinimumMoves
  def minimum_moves(numbers)
    moves = { table: {}, count: 0 }

    for idx in 0...numbers.length
      number = numbers[idx]
      previous = numbers[idx - 1]

      next unless previous

      moves[:table][number] ||= 0

      if number < previous
        moves[:table][number] += 1
      else
        moves[:table][number] -= 1
        moves[:count] += 1
      end
    end
  end

  def min(numbers)
    numbers.min
  end

  def max(numbers)
    numbers.max
  end
end
