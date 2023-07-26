class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end
end

node = Node.new(1)
node.next = Node.new(2)
node.next.next = Node.new(3)

while node
  puts node.value

  node = node.next
end
