require 'rspec'

# Summation given a range with consecutive numbers
# Usage: `rspec summation.rb`

def sum(max)
  max * (1 + max) / 2
end

def sum_range(min, max)
  sum(max) - sum(min) + min
end

describe 'summation' do
  it 'sums consecutive numbers in a range' do
    expect(sum_range(1, 10)).to eq(55)
    expect(sum_range(1, 15)).to eq(120)
    expect(sum_range(10, 15)).to eq(75)
    expect(sum_range(1000000001, 1000000005)).to eq(5000000015)
  end
end
