#!/usr/bin/env ruby


require 'logger'
require './parseclass.rb'
require './ruleclass.rb'
require './ast_nodes.rb'
require './scope_class.rb'



##############################################################################
#                                                                            #
# This part defines the Spyton language                                      # 
#                                                                            #   
##############################################################################

class Spyton
        
  # def Spyton.program(times, sides)
  #   (1..times).inject(0) {|sum, _| sum + rand(sides) + 1 }
  # end
  
  def initialize
    @@functions = {}
    @@variables = {}
    @diceParser = Parser.new("dice roller") do
      token(/\s+/)
      token(/[a-zA-Z]+/) {|m| m}
      token(/skriv/) {|m| m}
      token(/om/) {|m| m}
      token(/==/) {|m| m}
      token(/=/) {|m| m}
      token(/<=/) {|m| m}
      token(/>=/) {|m| m}
      token(/!=/) {|m| m}
      token(/\d+/) {|m| m.to_i }
      token(/./) {|m| m }
      
      # start :program do
      #   match(:block)
      # end

      start :block do
        match(:condition, '{', :statement, '}' ) {|a, _, b, _| BlockNode.new(a, b)} 
        match(:statement) {|a| StatementNode.new(a)} #LÄGG TILL PARANTESER SOM UTFÖRS FÖRE ANNAT.
      end

      rule :condition do
        match('om', '(', :bool, ')') {|_, _, a, _| ConditionNode.new(a)}
        #match('while', '(', :bool, ')') {|_, _, a, _| a} #FIXA DETTA (adda boolen till nuvarande scopes conditions.)
        # match('for', :bool)
      end
      
      rule :statement do
        match(:assign)
        match(:bool)
        match(:expr)
        match(:print)
      end

      rule :print do
        match('skriv', '(', :expr, ')') {|_, _, a, _| PrintNode.new(a) } #WEIRD
      end

      rule :assign do
        #match(String, '=', :expr) {|a,_,b| @@variables[a] = b } #NODE
        #match(String, '=', :bool) {|a,_,b| @@variables[a] = b } ##TA BORT !!
        match(String, '=', :expr) {|a,_,b| AssignNode.new(a, b) } #NODE
        match(String, '=', :bool) {|a,_,b| AssignNode.new(a, b) } ##TA BORT !!

        # match('funktion', String, '(', String, ')', '{', :statement, '}') {|_, a, _, b, _, _, c, _| FunctionNode.new(b, c) }  
      end
      
      rule :bool do
        match(:expr, '==', :term) {|a, _, b| EqualsNode.new(a, b) }
        match(:expr, '>', :term) {|a, _, b| MoreNode.new(a, b) }
        match(:expr, '>=', :term) {|a, _, b| MoreEqualsNode.new(a, b)}
        match(:expr, '<', :term) {|a, _, b| LessNode.new(a, b)}
        match(:expr, '<=', :term) {|a, _, b| LessEqualsNode.new(a, b)}
        match(:expr, '!=', :term) {|a, _, b| NotEqualsNode.new(a, b)}

      end


      rule :expr do 
        match(:expr, '+', :term) {|a, _, b| AdditionNode.new(a, b) } #STÄMMER DETTA???
        match(:expr, '-', :term) {|a, _, b| SubtractionNode.new(a, b) }

        match(:term)
      end
      
      rule :term do 
        match(:term, '*', :next) {|a, _, b| MultiplicationNode.new(a, b) }
        match(:term, '/', :next) {|a, _, b| DivisionNode.new(a, b) }
        match(:term, '%', :next) {|a, _, b| ModuloNode.new(a, b) }
        
        match(:next)
      end
      
      rule :next do
        match(:next, '^', :atom) {|a, _, b| PowerNode.new(a, b) }
        match(:atom)
      end


      rule :atom do
        # Match the result of evaluating an integer expression, which
        # should be an Integer
        match('(', :expr, ')') {|_, a, _| ExpressionNode.new(a)}
        match(Integer) {|a| IntegerNode.new(a)}

        
        match(String) {|a| VariableNode.new(a)}
        match('"', String, '"') {|_, a, _| StringNode.new(a)} ## DETTA FUNGERAR INTE
        


      end
    end
  end
  
  def done(str)
    ["quit","exit","bye","done",""].include?(str.chomp)
  end
  
  def program
    global_scope = Scope.new
    loop do
      print "[Spyton] "
      str = gets
      break if done(str)
      root_node = @diceParser.parse(str)
      puts "=> #{root_node.run(global_scope)}"
    end
  end



  def log(state = true)
    if state
      @diceParser.logger.level = Logger::DEBUG
    else
      @diceParser.logger.level = Logger::WARN
    end
  end
end

input = File.read("testrun.sp")
Spyton.new.program


