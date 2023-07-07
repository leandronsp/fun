require 'test/unit'
require 'byebug'

require_relative 'lib/roman_to_integer'

class RomanToIntegerTest < Test::Unit::TestCase
  include RomanToInteger

  def test_roman_to_integer
    assert_equal(1, roman_to_integer('I'))
    assert_equal(3, roman_to_integer('III'))
    assert_equal(5, roman_to_integer('V'))
    assert_equal(10, roman_to_integer('X'))
    assert_equal(500, roman_to_integer('D'))

    assert_equal(4, roman_to_integer('IV'))
    assert_equal(9, roman_to_integer('IX'))

    assert_equal(58, roman_to_integer('LVIII'))
    assert_equal(1994, roman_to_integer('MCMXCIV'))
  end
end
