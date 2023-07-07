require 'test/unit'
require 'byebug'

require_relative 'lib/integer_to_roman'

class IntegerToRomanTest < Test::Unit::TestCase
  include IntegerToRoman

  def test_integer_to_roman
    assert_equal('I', integer_to_roman(1))
    assert_equal('II', integer_to_roman(2))
    assert_equal('III', integer_to_roman(3))
    assert_equal('IV', integer_to_roman(4))
    assert_equal('V', integer_to_roman(5))
    assert_equal('VIII', integer_to_roman(8))
    assert_equal('IX', integer_to_roman(9))
    assert_equal('X', integer_to_roman(10))
    assert_equal('XIII', integer_to_roman(13))
    assert_equal('XIV', integer_to_roman(14))
    assert_equal('XV', integer_to_roman(15))
    assert_equal('XVIII', integer_to_roman(18))
    assert_equal('XIX', integer_to_roman(19))
    assert_equal('XX', integer_to_roman(20))
    assert_equal('XXIII', integer_to_roman(23))
    assert_equal('XXIV', integer_to_roman(24))
    assert_equal('XXV', integer_to_roman(25))
    assert_equal('XXIX', integer_to_roman(29))
    assert_equal('XXX', integer_to_roman(30))
    assert_equal('XL', integer_to_roman(40))
    assert_equal('XLIV', integer_to_roman(44))
    assert_equal('XLIX', integer_to_roman(49))
    assert_equal('L', integer_to_roman(50))
    assert_equal('CD', integer_to_roman(400))

    assert_equal('LVIII', integer_to_roman(58))
    assert_equal('MCMXCIV', integer_to_roman(1994))
  end
end
