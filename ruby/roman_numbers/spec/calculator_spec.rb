def calculate(roman)
  _map = {
    'I' => 1,
    'IV' => 4,
    'V' => 5,
    'IX' => 9,
    'X' => 10,
    'XL' => 40,
    'L' => 50,
    'XC' => 90,
    'C' => 100,
    'CD' => 400,
    'D' => 500,
    'CM' => 900,
    'M' => 1000
  }

  return _map[roman] if _map[roman]

  iterate_keys(_map, roman, 0)
end

def iterate_keys(_map, input, acc)
  return acc if input == '' || input == nil
  return acc + _map[input] if _map[input]

  sorted = _map.sort do |(k1,v1), (k2,v2)|
    v2 <=> v1
  end.to_h

  sorted.keys.each do |key|
    if input.start_with?(key)
      acc += _map[key]
      return iterate_keys(_map, input[key.length..-1], acc)
    end
  end
end

shared_examples_for 'roman converter' do |roman, expectation|
  it 'converts' do
    expect(calculate(roman)).to eq(expectation)
  end
end

describe 'Roman Numbers' do
  it_behaves_like 'roman converter', 'I', 1
  it_behaves_like 'roman converter', 'II', 2
  it_behaves_like 'roman converter', 'III', 3
  it_behaves_like 'roman converter', 'IV', 4
  it_behaves_like 'roman converter', 'V', 5
  it_behaves_like 'roman converter', 'VI', 6
  it_behaves_like 'roman converter', 'VII', 7
  it_behaves_like 'roman converter', 'VIII', 8
  it_behaves_like 'roman converter', 'IX', 9
  it_behaves_like 'roman converter', 'X', 10
  it_behaves_like 'roman converter', 'XI', 11
  it_behaves_like 'roman converter', 'XIV', 14
  it_behaves_like 'roman converter', 'XV', 15
  it_behaves_like 'roman converter', 'XIX', 19
  it_behaves_like 'roman converter', 'XX', 20
  it_behaves_like 'roman converter', 'XL', 40
  it_behaves_like 'roman converter', 'L', 50
  it_behaves_like 'roman converter', 'XC', 90
  it_behaves_like 'roman converter', 'C', 100
  it_behaves_like 'roman converter', 'CL', 150
  it_behaves_like 'roman converter', 'CD', 400
  it_behaves_like 'roman converter', 'D', 500
  it_behaves_like 'roman converter', 'CM', 900
  it_behaves_like 'roman converter', 'M', 1000
  it_behaves_like 'roman converter', 'CDXL', 440
  it_behaves_like 'roman converter', 'MCMXCIII', 1993
end
