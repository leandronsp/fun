require_relative '../examples/linked_list'

describe LinkedList do
  it 'adds to the beginning' do
    subject.add_into_beginning('First')
    expect(subject.to_s).to eq ['First']

    subject.add_into_beginning('Second')
    expect(subject.to_s).to eq ['Second', 'First']

    subject.add_into_beginning('Third')
    expect(subject.to_s).to eq ['Third', 'Second', 'First']
  end

  it 'adds to the end' do
    subject.add('First')
    expect(subject.to_s).to eq ['First']

    subject.add('Second')
    expect(subject.to_s).to eq ['First', 'Second']

    subject.add('Third')
    expect(subject.to_s).to eq ['First', 'Second', 'Third']

    # just adding to the beginning
    subject.add_into_beginning('Fourth')
    expect(subject.to_s).to eq ['Fourth', 'First', 'Second', 'Third']
  end

  it 'adds to the middle' do
    subject.add('First')
    subject.add('Third')
    subject.add('Fourth')

    expect(subject.to_s).to eq ['First', 'Third', 'Fourth']

    subject.add_to(1, 'Second')
    expect(subject.to_s).to eq ['First', 'Second', 'Third', 'Fourth']

    subject.add_to(2, 'Virus')
    expect(subject.to_s).to eq ['First', 'Second', 'Virus', 'Third', 'Fourth']
  end

  it 'prints the length' do
    subject.add('First')
    subject.add('Third')
    subject.add('Fourth')

    expect(subject.length).to eq(3)
  end

  it 'removes from beginning' do
    subject.add('First')
    subject.add('Second')
    subject.add('Third')

    subject.remove_from_beginning

    expect(subject.to_s).to eq ['Second', 'Third']
    expect(subject.length).to eq(2)
  end

  it 'removes from end' do
    subject.add('First')
    subject.add('Second')
    subject.add('Third')

    subject.remove_from_end

    expect(subject.to_s).to eq ['First', 'Second']
    expect(subject.length).to eq(2)
  end

  it 'removes from the middle' do
    subject.add('First')
    subject.add('Second')
    subject.add('Third')

    subject.remove(1)

    expect(subject.to_s).to eq ['First', 'Third']
    expect(subject.length).to eq(2)
  end

  it 'checks if contains' do
    subject.add('First')
    subject.add('Second')
    subject.add('Third')

    expect(subject.contains?('Second')).to be_truthy
    expect(subject.contains?('Virus')).to be_falsy
  end
end
