require_relative '../examples/binary_tree'

describe BinaryTree do

  it 'prints an empty tree' do
    tree = BinaryTree.new
    expect(tree.print).to eq([:node, nil])
  end

  it 'prints an empty with a single node' do
    tree = BinaryTree.new
    tree.insert('Jim', 'elixir')

    expected = [:node, ['Jim', 'elixir', [:node, nil], [:node, nil]]]
    expect(tree.print).to eq(expected)
  end

  it 'inserts multiple' do
    tree = BinaryTree.new
    tree.insert('Jim', 'elixir')
    tree.insert('Mark', 'ruby')
    tree.insert('Wilson', 'java')
    tree.insert('Kevin', 'php')
    tree.insert('Anita', 'javascript')

    expected = [:node, ['Jim', 'elixir',
      [:node, ['Anita', 'javascript', [:node, nil], [:node, nil]]],
      [:node, ['Mark', 'ruby',
        [:node, ['Kevin', 'php', [:node, nil], [:node, nil]]],
        [:node, ['Wilson', 'java', [:node, nil], [:node, nil]]]
      ]]
    ]]

    expect(tree.print).to eq(expected)
  end

  it 'inverts tree' do
    tree = BinaryTree.new
    tree.insert('Jim', 'elixir')
    tree.insert('Mark', 'ruby')
    tree.insert('Wilson', 'java')
    tree.insert('Kevin', 'php')
    tree.insert('Anita', 'javascript')

    expected = [:node, ['Jim', 'elixir',
      [:node, ['Mark', 'ruby',
        [:node, ['Wilson', 'java', [:node, nil], [:node, nil]]],
        [:node, ['Kevin', 'php', [:node, nil], [:node, nil]]]
      ]],
      [:node, ['Anita', 'javascript', [:node, nil], [:node, nil]]]
    ]]

    tree.invert!
    expect(tree.print).to eq(expected)
  end

end
