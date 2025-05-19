# class Node
#     def initialize()
#         Node* @lhs 
#         Node* @rhs
#     end 
# end

class IntegerNode
    def initialize(i)
        @num = i 
    end

    def run(scope)
        @num
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



class StringNode #gör denna
    def initialize(a)
        @value = a
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
        @value #WEIRD maybe (puts)?
    end
end

        
class ConditionNode                   ##Man kanske borde göra om detta till en specifik if-node.  
    def initialize(a)                 ##Då hade man kunnat göra en specifik while-node som man hade använt type-of på för att vad den ska göra.
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
        if @condition.run(scope) == true
            @statement.run(scope)
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

# class FunctionNode
#     def initialize(a, b)
#         @variables = a
#         @statement = b
        
#     end
    
#     def run()
#         puts("FUNCTION FOUND")
#     end
# end

class VariableNode
    def initialize(a)
        @name = a
    end
    
    def run(scope)
        puts("Tar '#{@name}'")
        scope.get_var(@name.strip)
    end
end


class FunctionNode
    def initialize(a, b, c)
        @name = a
        @body = b
        @args = c
    end

    # def run(scope)
    #     scope.set_func(@name, self) WTF ÄR DET HÄR
    # end

    # def call(arg_values, calling_scope)
    #     func_scope = Scope.new(calling_scope) WTF ÄR DET HÄR
    
    #     @args.each_with_index do |arg_name, i|
    #       func_scope.set_var(arg_name, arg_values[i])
    #     end
    
    #     @body.run(func_scope)
    # end
end


class FunctionCallNode
    def initialize(name, args)
      @name = name
      @args = args
    end
  
    def run(scope)
      func = scope.get_func(@name)
      #arg_values = @args.map { |arg| arg.run(scope) }
      #func.call(arg_values, scope)
    end
  end      
    



class AssignNode
    def initialize(a, b)
        @name = a
        @expr = b
    end

    def run(scope)
        value = @expr.run(scope)
        puts("Sätter '#{@name}' = #{value}")
        scope.set_var(@name.strip, value) #TAR BORT whitespace 
        value
    end
end

# #class VariableNode ##implementera för att skilja på string och variabler.









        