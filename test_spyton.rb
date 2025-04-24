
require 'test/unit'
require_relative 'spyton'
class TestSpyton < Test::Unit::TestCase
  def setup
    @spyton = Spyton.new
  end

  def test_integer_addition
    result = @spyton.parse("3 + 5")
    assert_equal(8, result.run)
  end
end
 # def test_bool
 #   assert_equal(true, @parser.parse("true"))
 #   assert_equal(false, @parser.parse("false"))
 # end
 # def test_not
  #assert_equal(false, @parser.parse("(!=)"))
 #  # assert_equal(true, @parser.parse("(not false)"))
  #end
  #def test_and
  #  assert_equal(true, @parser.parse("(and true true)"))
  #  assert_equal(false, @parser.parse("(and true false)"))
  #  assert_equal(false, @parser.parse("(and false true)"))
 #   assert_equal(false, @parser.parse("(and false false)"))
  #end
  #def test_or
  #  assert_equal(true, @parser.parse("(or true true)"))
  #  assert_equal(true, @parser.parse("(or true false)"))
  #  assert_equal(true, @parser.parse("(or false true)"))
 #   assert_equal(false, @parser.parse("(or false false)"))
  #end
  #def test_variabel
  #  assert_nothing_raised do
  #    @parser.parse("(set x true)")
  #  end
 #   assert_equal(true, @parser.parse("x"))
  #end
  #def test_olika_ops
  #  assert_equal(true, @parser.parse("(and true (or false true))"))
 #   assert_equal(false, @parser.parse("(and (not true) (or false true))"))
  #end
  #def test_fler_variabler
  #  @parser.parse("(set x true)")
  #  @parser.parse("(set y false)")
  #  assert_equal(false, @parser.parse("(and x y)"))
 #   assert_equal(true, @parser.parse("(or x y)"))
  #end
  #def test_set
  #  @parser.parse("(set a true)")
  #  @parser.parse("(set b false)")
#    @parser.parse("(set c true)")
#    
  #  
  #  result = @parser.parse("(not (and a (or b c)))")
#    assert_equal(false, result)
  #  
  #  result = @parser.parse("(or (and a b) (and (not b) c))")
 #   assert_equal(true, result)
#  end
#end