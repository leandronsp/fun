require_relative '../examples/quick_sort_linked_list'
require_relative '../examples/linked_list'

describe QuickSortLinkedList do
  let(:list) { LinkedList.new }

  it 'sorts none' do
    expect(subject.sort(list).to_s).to eq([])
  end

  it 'sorts one' do
    list.add(8)
    expect(subject.sort(list).to_s).to eq(['8'])
  end

  it 'sorts two' do
    list.add(8)
    list.add(2)
    expect(subject.sort(list).to_s).to eq(['2', '8'])
  end

  it 'sorts three or more' do
    list.add(8)
    list.add(2)
    list.add(6)
    list.add(3)
    list.add(1)
    list.add(4)
    list.add(5)
    list.add(7)
    list.add(10)
    list.add(9)
    expect(subject.sort(list).to_s).to eq(['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'])
  end
end
