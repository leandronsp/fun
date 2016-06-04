require_relative '../examples/simple_set'
require 'pry-byebug'

describe SimpleSet do
  it 'adds' do
    subject.add('First')
    subject.add('Second')
    subject.add('Second')

    expect(subject.to_s[6]).to eq(['First'])
    expect(subject.to_s[19]).to eq(['Second'])
    expect(subject.empty?).to be_falsy
  end

  it 'removes' do
    subject.add('First')
    subject.add('Second')
    subject.add('Third')

    subject.remove('First')

    expect(subject.to_s[19]).to eq(['Second'])

    subject.remove('Third')
    expect(subject.to_s[20]).to be_empty

    subject.remove('Second')
    expect(subject.empty?).to be_truthy
  end
end
