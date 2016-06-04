require_relative '../examples/queue'

describe Queue do
  it 'adds' do
    subject.add('First')
    subject.add('Second')

    expect(subject.to_s).to eq ['First', 'Second']
  end

  it 'removes' do
    subject.add('First')
    subject.add('Second')

    expect(subject.length).to eq(2)
    expect(subject.empty?).to be_falsy

    subject.remove
    expect(subject.to_s).to eq ['Second']

    subject.remove
    expect(subject.to_s).to eq []
    expect(subject.length).to eq(0)
    expect(subject.empty?).to be_truthy
  end
end
