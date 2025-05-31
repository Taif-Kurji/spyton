class IntegerNode
    def initialize(i)
        @num = i 
    end

    def run(scope)
        @num
    end
end

class FloatNode
    def initialize(i)
        @value = i
    end

    def run(scope)
        @value
    end
end



class AdditionNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) + @rhs.run(scope)
    end
end

class ExpressionNode
    def initialize(nn)
        @next_node = nn
    end

    def run(scope)
        @next_node.run(scope)
    end
end



class StringNode
    def initialize(value)
      @value = value
    end
  
    def run(scope)
      @value
    end
  end  


class SubtractionNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) - @rhs.run(scope)
    end
end


class MultiplicationNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) * @rhs.run(scope)
    end
end


class DivisionNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) / @rhs.run(scope)
    end
end


class ModuloNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) % @rhs.run(scope)
    end
end


class PowerNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) ** @rhs.run(scope)
    end
end


class EqualsNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) == @rhs.run(scope)
    end
end


class MoreEqualsNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) >= @rhs.run(scope)
    end
end


class LessEqualsNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) <= @rhs.run(scope)
    end
end


class MoreNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) > @rhs.run(scope)
    end
end


class LessNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) < @rhs.run(scope)
    end
end


class NotEqualsNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run(scope)
        @lhs.run(scope) != @rhs.run(scope)
    end
end


class PrintNode
    def initialize(a)
        @print_expr = a
    end

    def run(scope)
        @value = @print_expr.run(scope)
        puts @value
        @value
    end
end

        
class ConditionNode
    def initialize(a)
        @condition = a
    end
    
    def run(scope)
        @condition.run(scope)
    end
end


class BlockNode
    def initialize(a, b)
        @condition = a 
        @statement = b 
    end

    def run(scope)
        if @condition.is_a?(ConditionNode)
            if @condition.run(scope)
                @statement.run(scope)
            end
        elsif @condition.is_a?(WhileConditionNode)
            WhileNode.new(@condition.condition, @statement).run(scope)
        elsif @condition.is_a?(ForHeaderNode)
            ForNode.new(@condition.init, @condition.condition, @condition.step, @statement).run(scope)
        end
    end
end


class StatementNode
    def initialize(a)
        @statement = a
    end
    
    def run(scope)
        @statement.run(scope)
    end
end

class IfElseChainNode
    def initialize(condition, then_block, else_part)
      @condition = condition
      @then_block = then_block
      @else_part = else_part
    end
  
    def run(scope)
      if @condition.run(scope)
        @then_block.run(scope)
      elsif @else_part
        @else_part.run(scope)
      end
    end
end
  
class ElseNode
    def initialize(block)
      @block = block
    end
  
    def run(scope)
      @block.run(scope)
    end
end

class VariableNode
    def initialize(a)
        @name = a
    end
    
    def run(scope)
        scope.get_var(@name.strip)
    end
end




class AssignNode
    def initialize(a, b)
        @name = a
        @expr = b
    end

    def run(scope)
        value = @expr.run(scope)
        scope.set_var(@name, value)
        value
    end
end

class StatementListNode
    def initialize(a, b)
      @first = a
      @second = b
    end
  
    def run(scope)
      @first.run(scope)
      @second.run(scope)
    end
  end

class WhileConditionNode
    attr_reader :condition
    
    def initialize(condition)
        @condition = condition
    end

    def run(scope)
        @condition.run(scope)
    end
end

class WhileNode
    def initialize(condition, body)
        @condition = condition
        @body = body
    end

    def run(scope)
        while @condition.run(scope)
            @body.run(scope)
        end
    end
end

class ForHeaderNode
    attr_reader :init, :condition, :step

    def initialize(init, condition, step)
        @init = init
        @condition = condition
        @step = step
    end

    def run(scope)
        self
    end
end

class ForNode
    def initialize(init, condition, step, body)
        @init = init
        @condition = condition
        @step = step
        @body = body
    end

    def run(scope)
        @init.run(scope)
        while @condition.run(scope)
            @body.run(scope)
            @step.run(scope)
        end
        nil
    end
end

class FunctionDefNode
    attr_reader :params, :body

    def initialize(name, params, body)
        @name = name.to_s
        @params = params
        @body = body
    end

    def call(scope, args)
        inner_scope = scope.new_scope
        if params != nil or args != nil
            params.zip(args).each do |param, arg_node|
                inner_scope.set_var(param, arg_node.run(scope))
            end 
        end
        # @body.run(inner_scope)
        begin
            @body.run(inner_scope)
            nil
        rescue ReturnException => e
            e.value
        end
    end

    
    def run(scope)
        scope.set_func(@name, self)
        @name
    end

end



class FunctionCallNode
    def initialize(name, args)
        @name = name.to_s
        @args = args
    end

    def run(scope)
        func = scope.get_func(@name)
        func.call(scope, @args)
    end
end

class ReturnNode
    def initialize(in_statement)
        @statement = in_statement
    end

    def run(scope)
        value = @statement.run(scope)
        raise ReturnException.new(value)
    end
end

class ReturnException < StandardError
    attr_reader :value

    def initialize(value)
        @value = value
    end
end



