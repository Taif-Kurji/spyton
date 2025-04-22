#!/usr/bin/env ruby

# This file is called rdparse.rb because it implements a Recursive
# Descent Parser. Read more about the theory on e.g.
# http://en.wikipedia.org/wiki/Recursive_descent_parser

# 2010-02-11 New version of this file for the 2010 instance of TDP007
#   which handles false return values during parsing, and has an easy way
#   of turning on and off debug messages.
# 2014-02-16 New version that handles { false } blocks and :empty tokens.

require 'logger'
require './parseclass.rb'
require './ruleclass.rb'



##############################################################################
#
# This part defines the dice language
#
##############################################################################

class Spyton
        
  # def Spyton.program(times, sides)
  #   (1..times).inject(0) {|sum, _| sum + rand(sides) + 1 }
  # end
  
  def initialize

    @@variables = {}
    @diceParser = Parser.new("dice roller") do
      token(/\s+/)
      token(/if/) {|m| m}
      token(/==/) {|m| m}
      token(/<=/) {|m| m}
      token(/>=/) {|m| m}
      token(/!=/) {|m| m}
      token(/\d+/) {|m| m.to_i }
      token(/./) {|m| m }
      
      # start :program do
      #   match(:block)
      # end

      start :block do
        match(:condition, :statement ) {|a, b| puts a}
        match(:statement) #{ }CONDITION
      end

      rule :condition do
        match('if', '(', :bool, ')')
        # match('while', :bool)
        # match('for', :bool)
      end
      
      rule :statement do
        match(:assign)
        match(:expr)
      end

      rule :assign do
        match(String, '=', :expr) {|a,_,b| @@variables[a] = b }
        match(String, '=', :bool) {|a,_,b| @@variables[a] = b }
        match(:expr)
        match(:bool)
      end
      
      rule :bool do
        match(:expr, '==', :term) {|a, _, b| a == b}
        match(:expr, '>', :term) {|a, _, b| a > b}
        match(:expr, '>=', :term) {|a, _, b| a >= b}
        match(:expr, '<', :term) {|a, _, b| a < b}
        match(:expr, '<=', :term) {|a, _, b| a <= b}
        match(:expr, '!=', :term) {|a, _, b| a != b}

        match(:term)
      end


      rule :expr do 
        match(:expr, '+', :term) {|a, _, b| a + b }
        match(:expr, '-', :term) {|a, _, b| a - b }

        match(:term)
      end
      
      rule :term do 
        match(:term, '*', :next) {|a, _, b| a * b }
        match(:term, '/', :next) {|a, _, b| a / b }
        match(:term, '%', :next) {|a, _, b| a % b }
        
        match(:next)
      end
      
      rule :next do
        match(:next, '^', :atom) {|a, _, b| a ** b }
        match(:atom)
      end


      rule :atom do
        # Match the result of evaluating an integer expression, which
        # should be an Integer
        match(Integer)

        match('(', :expr, ')') {|_, a, _| a }
        match(String) {|a| @@variables[a]}


      end
    end
  end
  
  def done(str)
    ["quit","exit","bye","done",""].include?(str.chomp)
  end
  
  def program
    print "[Spyton] "
    str = gets
    if done(str) then
      puts "Bye."
    else
      puts "=> #{@diceParser.parse str}"
      program
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




# Examples of use

# irb(main):1696:0> DiceRoller.new.roll
# [diceroller] 1+3
# => 4
# [diceroller] 1+1d4
# => 2
# [diceroller] 1+1d4
# => 3
# [diceroller] (2+8*1d20)*3d6
# => 306

#DiceRoller.new.roll

