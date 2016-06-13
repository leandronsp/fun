class Add < Struct.new(:left, :right)
  include Inspectable
  include Operations

  OPERATOR    = '+'
  OUTPUT_TYPE = Number

  def to_s
    "#{left} + #{right}"
  end

  def reducible?
    true
  end

end
