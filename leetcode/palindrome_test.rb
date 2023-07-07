require 'test/unit'
require 'byebug'

require_relative 'lib/palindrome'

class PalindromeTest < Test::Unit::TestCase
  include Palindrome

  def test_palindrome
    assert_equal(true, palindrome?(121))
    assert_equal(true, palindrome?(9339))
    assert_equal(false, palindrome?(9334))
    assert_equal(false, palindrome?(1101))
    assert_equal(false, palindrome?(10))
    assert_equal(true, palindrome?(0))
    assert_equal(true, palindrome?(1))
    assert_equal(true, palindrome?(11))
    assert_equal(false, palindrome?(1234))
    assert_equal(false, palindrome?(9900))
    assert_equal(true, palindrome?(14541))
    assert_equal(false, palindrome?(1000021))
    assert_equal(true, palindrome?(1001))
    assert_equal(true, palindrome?(1000110001))
  end
end
