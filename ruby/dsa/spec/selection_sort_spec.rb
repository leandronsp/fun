require_relative '../examples/selection_sort'

describe SelectionSort do
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
end
