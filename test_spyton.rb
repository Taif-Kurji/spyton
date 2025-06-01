require 'test/unit'
require 'stringio'
require_relative 'spyton'

class TestSpyton < Test::Unit::TestCase
  def setup
    @spyton = Spyton.new
    @scope = Scope.new 
    @spyton.log(true)
  end

  def parse(str)
    root_node = @spyton.instance_variable_get(:@diceParser).parse(str)
    return nil if root_node.nil? 
    root_node.run(@scope)
  end
 

  def test_addition
    result = parse("3 + 5")
    assert_equal(8, result)
  end
  
  def test_float_addition
    result = parse("3.5 + 2.1")
    assert_equal(5.6, result)
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

  def test_bool_greater_equal
    result = parse("5 >= 5")
    assert_equal(true, result)
  end

  def test_bool_less_equal
    result = parse("4 <= 5")
    assert_equal(true, result)
  end


  def test_variable
    parse("x = 10")
    result = parse("x")
    assert_equal(10, result)
  end
  
  def test_variable_returnal
    parse("y = 20")
    result = parse("y")
    assert_equal(20, result)
  end

  def test_flera_variabel
    parse("a = 5")
    parse("b = 10")
    result = parse("a + b")
    assert_equal(15, result)
  end


  def test_if_statement
    result = parse("om (1 > 0) {5}")
    assert_equal(5, result)
  end

  def test_if_statement2
    result = parse("om (1 < 0) {5}")
    assert_nil(result)
  end

  def test_if_else_statement
    result = parse("om (1 > 0) {10} annars {20}")
    assert_equal(10, result)
  end

  def test_if_else_statement2
    result = parse("om (1 < 0) {10} annars {20}")
    assert_equal(20, result)
  end

  def test_while
    parse("counter = 0")
    parse("medans (counter < 5) {counter = counter + 1}")
    result = parse("counter")
    assert_equal(5, result)
  end

  def test_for
    parse("sum = 0")
    parse("för (i = 0; i < 5; i = i + 1) {sum = sum + i}")
    result = parse("sum")
    assert_equal(10, result)
  end

  def capture_stdout
    original_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original_stdout
  end
  





  def test_print
    output = capture_stdout do
      parse("skriv(42)")
    end
    assert_equal("42\n", output)
  end

  def test_print_variable
    parse("msg = \"Hello\"")
    output = capture_stdout do
      parse("skriv(msg)")
    end
    assert_equal("Hello\n", output)
  end
  
  def test_string1
    result = parse("\"test\"")
    assert_equal("test", result)
  end

  def test_string_variable
    parse("greeting = \"hello\"")
    result = parse("greeting")
    assert_equal("hello", result)
  end


  def test_function_def
    result = parse("funktion square(x) {x * x}")
    assert_equal("square", result)
  end
  
  def test_function_return
    parse("funktion greet() { returnera(\"Hello\") }")
    result = parse("bruka greet()")
    assert_equal("Hello", result)
  end
  def test_function_calling
    parse("funktion square(x) {x * x}")
    result = parse("bruka square(5)")
    assert_equal(25, result)
  end

  def test_function_parameters
    parse("funktion add(a, b) {a + b}")
    result = parse("bruka add(3, 4)")
    assert_equal(7, result)
  end

  def test_recursive_fun
    parse("funktion factorial(n) {
      om (n <= 1) {1} annars {n * bruka factorial(n - 1)}
    }")
    result = parse("bruka factorial(5)")
    assert_equal(120, result)
  end

  def test_aritmatik
    result = parse("(2 + 3) * 4 - 5")
    assert_equal(15, result)
  end

  def test_expression_variables
    parse("a = 10")
    parse("b = 2")
    result = parse("a ^ b + a / b - a % b")
    assert_equal(105, result)
  end

  
  def test_statement_list
    result = parse("x = 5; y = 10; x + y")
    assert_equal(15, result)
  end

  def test_statement_list2
    code = <<-CODE
      x = 0;
      om (x < 5) {
        x = x + 1;
        skriv(x)
      };
      x
    CODE
    result = parse(code)
    assert_equal(1, result)
  end

  
  def test_gränsfall1
    assert_nil(parse(""))
  end

  def test_gränsfall2
    code = <<-CODE
      x = 10;
      om (x > 5) {
        om (x < 15) {
          x = x * 2
        }
      };
      x
    CODE
    result = parse(code)
    assert_equal(20, result)
  end

  def test_scope
    parse("funktion test() {x = 10}")
    parse("bruka test()")
    assert_raise(RuntimeError) { parse("x") }
  end

end