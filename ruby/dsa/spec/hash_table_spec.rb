require_relative '../examples/hash_table'

describe HashTable do

  it 'inserts' do
    hash = HashTable.new
    hash.put(:name, 'Leandro')

    expect(hash.get(:name)).to eq('Leandro')
  end

  it 'deletes' do
    hash = HashTable.new
    hash.put(:name, 'Leandro')

    hash.delete(:name)

    expect(hash.get(:name)).to eq(nil)
  end

  it 'overrides values' do
    hash = HashTable.new
    hash.put(:name, 'Leandro')
    expect(hash.get(:name)).to eq('Leandro')

    hash.put(:name, 'Mara')
    expect(hash.get(:name)).to eq('Mara')
  end

  it 'works with indifferent access' do
    hash = HashTable.new
    hash.put(:name, 'Leandro')

    expect(hash.get('name')).to eq('Leandro')
  end

end
