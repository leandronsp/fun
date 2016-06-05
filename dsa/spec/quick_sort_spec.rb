require_relative '../examples/quick_sort'

describe QuickSort do
  it 'sorts' do
    array = []
    array.push('VXZ')
    array.push('ABC')
    array.push('DEF')
    array.push('PQR')
    array.push('MNO')
    array.push('STU')
    array.push('JKL')
    array.push('GHI')

    expected = 'ABCDEFGHIJKLMNOPQRSTUVXZ'
    subject.sort!(array)

    expect(array.join(',').gsub(',', '')).to eq(expected)
  end

  it 'sorts one element' do
    array = []
    array.push('ABC')

    expected = 'ABC'
    subject.sort!(array)

    expect(array.join(',').gsub(',', '')).to eq(expected)
  end

  it 'sorts two elements' do
    array = []
    array.push('NDRO')
    array.push('LEA')

    expected = 'LEANDRO'
    subject.sort!(array)

    expect(array.join(',').gsub(',', '')).to eq(expected)
  end
end
