require_relative '../examples/vector'

describe Vector do
  before do
    subject.add('Fompila')
    subject.add('Fomps')
  end

  it 'checks the result and size' do
    expect(subject.to_s).to eq ['Fompila', 'Fomps']
    expect(subject.length).to eq(2)
  end

  it 'checks contains' do
    expect(subject.contains?('Fompila')).to be_truthy
    expect(subject.contains?('Haha')).to be_falsy
  end

  it 'gets an elment' do
    subject.add('Leandro')

    expect(subject.get(2)).to eq('Leandro')
    expect { subject.get(10) }.to raise_error(StandardError)
  end

  it 'adds to position' do
    subject.add('Warrior')
    subject.add_to(1, 'Gustavo')

    expect(subject.to_s).to eq ['Fompila', 'Gustavo', 'Fomps', 'Warrior']
    expect { subject.add_to(20, 'Element') }.to raise_error(StandardError)
  end

  it 'removes an element' do
    subject.add('Another')
    subject.remove(1)

    expect(subject.get(0)).to eq 'Fompila'
    expect(subject.get(1)).to eq 'Another'

    subject.remove(0)
    expect(subject.get(0)).to eq 'Another'
  end
end
