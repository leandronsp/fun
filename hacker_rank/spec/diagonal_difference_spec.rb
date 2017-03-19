require 'rspec'

def diagonal_difference(matrix, size)
  sum = lambda do |matrix, size|
    idx = 0
    _sum = 0

    while idx < size do
      _sum += matrix[idx][idx]
      idx += 1
    end

    _sum
  end

  (sum.call(matrix, size) - sum.call(matrix.reverse, size)).abs
end

describe 'diagonal difference' do
  it 'calculates the absolute difference between the sum of square diagonals' do
    input = [[11, 2, 4], [4, 5, 6], [10, 8, -12]]
    expect(diagonal_difference(input, 3)).to eq(15)

    input = [[11, 2, 4, 6], [4, 5, 6, 7], [10, 8, -12, -1], [6, 2, 1, 9]]
    expect(diagonal_difference(input, 4)).to eq(13)
  end
end
