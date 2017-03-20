require 'rspec'

def plus_minus(arr, size)
  positives = 0
  negatives  = 0
  zeroes     = 0

  arr.inject([0, 0, 0]) do |memo, elem|
    if elem > 0
      positives += 1
      memo[0] = (positives / size.round(1)).round(6)
    elsif elem < 0
      negatives += 1
      memo[1] = (negatives / size.round(1)).round(6)
    else
      zeroes += 1
      memo[2] = (zeroes / size.round(1)).round(6)
    end

    memo
  end
end

describe 'plus minus' do
  it 'prints the fraction of occurences' do
    input = [-4, 3, -9, 0, 4, 1]
    expect(plus_minus(input, 6)).to eq([0.500000, 0.333333, 0.166667])

    input = [1, 2, 3, -1, -2, -3, 0, 10]
    expect(plus_minus(input, 8)).to eq([0.5, 0.375, 0.125])
  end
end
