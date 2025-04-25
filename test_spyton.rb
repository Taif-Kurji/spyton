require 'test/unit'
require_relative 'spyton'

class TestSpyton < Test::Unit::TestCase
  def setup
    @spyton = Spyton.new
  end
#
#  def test_addition
#    result = @spyton.parse("3 + 5")
#    assert_equal(8, result.run)
#  end
#
#  def test_subtraction
#    result = @spyton.parse("10 - 6")
#    assert_equal(4, result.run)
#  end
#
#  def test_multiplication
#    result = @spyton.parse("6 * 7")
#    assert_equal(42, result.run)
#  end
#
#  def test_division
#    result = @spyton.parse("20 / 4")
#    assert_equal(5, result.run)
#  end
#
#  def test_modulo
#    result = @spyton.parse("10 % 3")
#    assert_equal(1, result.run)
#  end
#
#  def test_power
#    result = @spyton.parse("2 ^ 3")
#    assert_equal(8, result.run)
#  end
#
#  def test_boolean_equal
#    result = @spyton.parse("5 == 5")
#    assert_equal(true, result.run)
#  end
#
#  def test_boolean_not_equal
#    result = @spyton.parse("5 != 4")
#    assert_equal(true, result.run)
#  end
#
#  def test_boolean_greater
#    result = @spyton.parse("10 > 5")
#    assert_equal(true, result.run)
#  end
#
#  def test_boolean_less
#    result = @spyton.parse("3 < 5")
#    assert_equal(true, result.run)
#  end
#
#  def test_variable
#    @spyton.parse("x = 10")
#    result = @spyton.parse("x")
#    assert_equal(10, result.run)
#  end
#
  def test_if_statement
    result = @spyton.parse("if (1 > 0) { print(1) }")
    output = capture_stdout { result.run }
    assert_equal("1\n", output)
  end

  


end