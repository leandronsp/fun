require 'test/unit'

def solve_equation
  # Solve the equation: 3x + 5 = 17
  # Subtract 5 from both sides
  # Divide by 3 to isolate x
  x = (17 - 5) / 3
  return x
end

# Test case for solving the equation
class TestAlgebra < Test::Unit::TestCase
  def test_solve_equation
    assert_equal(4, solve_equation)
  end
end
