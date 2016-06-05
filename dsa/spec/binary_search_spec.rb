require_relative '../examples/binary_search'

describe BinarySearch do
  it 'searches' do
    array = []
    array.push('ABC')
    array.push('DEF')
    array.push('GHI')
    array.push('JKL')
    array.push('MNO')
    array.push('PQR')
    array.push('STU')
    array.push('VXZ')

    expect(subject.search(array, 'PQR')).to eq('PQR')
    expect(subject.search(array, 'JKL')).to eq('JKL')
    expect(subject.search(array, 'ABC')).to eq('ABC')
    expect(subject.search(array, 'not found')).to be_nil
  end
end
