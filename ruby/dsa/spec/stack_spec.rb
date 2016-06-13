require_relative '../examples/stack'

describe Stack do
  it 'pushs' do
    subject.push('First')
    subject.push('Second')

    expect(subject.to_s).to eq ['First', 'Second']
  end

  it 'pops' do
    subject.push('First')
    subject.push('Second')

    expect(subject.length).to eq(2)
    expect(subject.empty?).to be_falsy

    subject.pop
    expect(subject.to_s).to eq ['First']

    subject.pop
    expect(subject.to_s).to eq []
    expect(subject.length).to eq(0)
    expect(subject.empty?).to be_truthy
  end

  describe '#peek' do
    it 'peeks' do
      subject.push('First')
      subject.push('Second')

      expect(subject.peek).to eq('Second')
      expect(subject.to_s).to eq ['First', 'Second']
    end

    it 'returns nil if is empty' do
      expect(subject.peek).to be_nil
      expect(subject.to_s).to eq []
    end
  end
end
