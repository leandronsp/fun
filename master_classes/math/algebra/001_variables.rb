require 'test/unit'

def evaluate_expression
  x = 5
  y = 3
  result = x + 2 * y

  return result
end

class TestAlgebra < Test::Unit::TestCase
  def test_evaluate_expression
    assert_equal(11, evaluate_expression)
  end
end
