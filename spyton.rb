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
  def initialize
    @@functions = {}
    @@variables = {}
    @diceParser = Parser.new("dice roller") do
      token(/\s+/)
      token(/"[^"]*"/) { |m| m }
      token(/skriv/) { |m| m }
      token(/om/) { |m| m }
      token(/medans/) { |m| m }
      token(/för/) { |m| m }
      token(/annars/) { |m| m }
      token(/funktion/) { |m| m }
      token(/bruka/) { |m| m }

      token(/==/) { |m| m }
      token(/!=/) { |m| m }
      token(/>=/) { |m| m }
      token(/<=/) { |m| m }
      token(/>/) { |m| m }
      token(/</) { |m| m }
      token(/=/) { |m| m }
      token(/\{/) { |m| m }
      token(/\}/) { |m| m }

      token(/\(/) { |m| m }
      token(/\)/) { |m| m }
      token(/;/) { |m| m }
      token(/,/) { |m| m }
      token(/\*/) { |m| m } 
      token(/\//) { |m| m }
      token(/%/) { |m| m }
      token(/\+/) { |m| m }
      token(/-/) { |m| m }
      token(/\^/) { |m| m }


      token(/\d+\.\d+/) { |m| m.to_f }
      token(/\d+/) { |m| m.to_i }
      token(/[a-zA-Z_]\w*/) { |m| m }



      start :program do
        match(:block) { |b| b }
      end

      rule :block do
        match(:if_chain) { |a| a }
        match(:statement_list) { |a| StatementNode.new(a) }
      end

      rule :condition do
        match('om', '(', :bool, ')') {|_, _, cond, _| ConditionNode.new(cond)}
        match('medans', '(', :bool, ')') { |_, _, cond, _| WhileConditionNode.new(cond) }
      end

      rule :if_chain do
        match(:condition, '{', :statement_list, '}', :else_if_chain) do |cond, _, if_block, _, else_part|
          IfElseChainNode.new(cond, if_block, else_part)
        end

        match(:condition, '{', :statement_list, '}') do |cond, _, if_block, _|
          BlockNode.new(cond, if_block)
        end
      end

      
      
      rule :loop_block do
        match('medans', '(', :bool, ')', '{', :statement_list, '}') do |_, _, cond, _, _, body, _|
          WhileNode.new(cond, body)
        end
        match('för', '(', :assign, ';', :bool, ';', :assign, ')', '{', :statement_list, '}') do |_, _, init, _, cond, _, step, _, _, body, _|
          ForNode.new(init, cond, step, body)
        end
      end

      rule :else_if_chain do
        match('annars', :if_chain) { |_, chained| chained }
        match('annars', '{', :statement_list, '}') { |_, _, block, _| ElseNode.new(block) }
      end

      rule :statement_list do
        match(:statement_list, ';', :block) { |a, _, b| StatementListNode.new(a, b) }
        match(:statement_list, ';', :statement) { |a, _, b| StatementListNode.new(a, b) }
        match(:statement)
      end

      rule :statement do
        match(:function_def)
        match(:function_call)
        match(:assign)
        match(:bool)
        match(:print)
        match(:loop_block) 
        match(:if_chain) 
       
        match(:expr)
      end

      rule :arg_list do
         match(:arg_list, ',', :expr) {|list, _, a| list + [a]}
         match(:expr) {|a| [a]}
      end

      rule :param_list do
        match(:param_list, ',', String) {|list, _, a| list + [a]}
        match(String) {|a| [a]}
      end


      rule :print do
        match('skriv', '(', :expr, ')') {|_, _, a, _| PrintNode.new(a) } 
      end

      rule :assign do
        match(String, '=', :expr) {|a,_,b| AssignNode.new(a, b) }
        match(String, '=', :bool) {|a,_,b| AssignNode.new(a, b) }
        match('funktion', String, '(', ')', '{', :statement_list, '}') {|_, name, _, _, _, body, _| FunctionDefNode.new(name, nil, body) }
        match('funktion', String, '(', :param_list,  ')', '{', :statement_list, '}') {|_, name, _, params, _, _, body, _| FunctionDefNode.new(name, params, body) }
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
        match(:expr, '+', :term) {|a, _, b| AdditionNode.new(a, b) }
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
        match('(', :expr, ')') { |_, a, _| ExpressionNode.new(a) }
        match(Float) { |a| FloatNode.new(a) }
        match(Integer) { |a| IntegerNode.new(a) }
        match('-', :atom) { |_, a| MultiplicationNode.new(IntegerNode.new(-1), a) }
        match('bruka', String, '(', ')') {|_, a, _, _| FunctionCallNode.new(a, nil)}
        match('bruka', String, '(', :arg_list, ')') {|_, a, _, b, _| FunctionCallNode.new(a, b)}
        match('returnera', '(', :statement, ')' ) {|_, _, a, _| ReturnNode.new(a)}
        match(String) do |a|
          if a.start_with?('"') && a.end_with?('"')
            StringNode.new(a[1..-2])
          else
            VariableNode.new(a)
          end
        end
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

  def program_from_string(code)
    global_scope = Scope.new
    root_node = @diceParser.parse(code)
    root_node.run(global_scope)
  end



  def log(state = true)
    if state
      @diceParser.logger.level = Logger::DEBUG
    else
      @diceParser.logger.level = Logger::WARN
    end
  end
end

spyton = Spyton.new

if ARGV.length > 0 && ARGV[0].end_with?(".sp")
  code = File.read(ARGV[0])
  spyton.program_from_string(code)
else
  spyton.program
end