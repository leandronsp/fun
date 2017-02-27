require 'pry-byebug'
require_relative 'queue'

class BinaryTree

  def initialize
    @root = Node.new
  end

  def insert(key, value)
    @root.insert(key, value)
  end

  def invert!
    @root.invert!
  end

  def print
    @root.print
  end
end

class Node
  attr_reader :value

  def initialize
    @value = nil
  end

  def build_value(key, value)
    @value = NodeValue.new(key, value, Node.new, Node.new)
  end

  def empty?
    !value
  end

  def left
    @value.left
  end

  def right
    @value.right
  end

  def insert(key, value)
    return build_value(key, value) if empty?
    return left.insert(key, value) if @value.key > key

    right.insert(key, value)
  end

  def invert!
    return self if empty?

    temp         = @value.left
    @value.left  = @value.right.invert!
    @value.right = temp.invert!

    self
  end

  def print
    return [:node, nil] unless @value
    [:node, @value.print]
  end

end

class NodeValue
  attr_accessor :key, :value, :left, :right

  def initialize(key, value, left, right)
    @key = key
    @value = value
    @left = left
    @right = right
  end

  def print
    [key, value, left.print, right.print]
  end
end
