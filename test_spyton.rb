require 'test/unit'
require 'stringio'
require_relative 'spyton'

class TestSpyton < Test::Unit::TestCase
  def setup
    @spyton = Spyton.new
    @scope = Scope.new 
    @spyton.log(false)
  end

  def parse(str)
    root_node = @spyton.instance_variable_get(:@diceParser).parse(str)
    root_node.run(@scope)
  end
 

  def test_addition
    result = parse("3 + 5")
    assert_equal(8, result)
  end

  def test_subtraction
    result = parse("10 - 6")
    assert_equal(4, result)
  end

  def test_multiplication
    result = parse("6 * 7")
    assert_equal(42, result)
  end

  def test_division
    result = parse("20 / 4")
    assert_equal(5, result)
  end

  def test_modulo
    result = parse("10 % 3")
    assert_equal(1, result)
  end

  def test_power
    result = parse("2 ^ 3")
    assert_equal(8, result)
  end

  def test_boolean_equal
    result = parse("5 == 5")
    assert_equal(true, result)
  end

  def test_boolean_not_equal
    result = parse("5 != 4")
    assert_equal(true, result)
  end

  def test_boolean_greater
    result = parse("10 > 5")
    assert_equal(true, result)
  end

  def test_boolean_less
    result = parse("3 < 5")
    assert_equal(true, result)
  end

  def test_variable
    parse("x = 10")
    result = parse("x")
    assert_equal(10, result)
  end
  



  #def test_if_statement
  #  result = parse("if (1 > 0) { }")
  #  output = capture_stdout { result }
  #  assert_equal("1\n", output)
  #end
# fixar sen enkel fix expect true  men allt annat funkar

  def capture_stdout
    original_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original_stdout
  end

  def test_variable
    result =parse("x = 5")
    assert_equal(5, result)
  end

  def test_variable2
    result =parse("x = 10")
    result = parse("x")
    assert_equal(10, result)
  end
         

end