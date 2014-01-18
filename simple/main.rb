require_relative 'simple'
require_relative 'machine'

expression = Add.new(
  Multiply.new(Variable.new(:x), Variable.new(:y)), Number.new(1)
)

Machine.new(expression, { x: Number.new(4), y: Number.new(5) }).run

Machine.new(Add.new(
  Multiply.new(Number.new(1), Number.new(2)),
  Multiply.new(Number.new(3), Number.new(4))
)).run

Machine.new(LessThan.new(
  Number.new(5), Add.new(Number.new(2), Number.new(2))
)).run

