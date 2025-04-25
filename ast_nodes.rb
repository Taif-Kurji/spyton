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

    def run()
        @num
    end
end


class AdditionNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run + @rhs.run
    end
end

class ExpressionNode
    def initialize(nn)
        @next_node = nn
    end

    def run()
        @next_node.run
    end
end



class StringNode #gör denna
    def initialize(a)
        @value = a
    end

    def run()
        @value
    end
end


class SubtractionNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run - @rhs.run
    end
end


class MultiplicationNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run * @rhs.run
    end
end


class DivisionNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run / @rhs.run
    end
end


class ModuloNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run % @rhs.run
    end
end


class PowerNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run ** @rhs.run
    end
end


class EqualsNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run == @rhs.run
    end
end


class MoreEqualsNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run >= @rhs.run
    end
end


class LessEqualsNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run <= @rhs.run
    end
end


class MoreNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run > @rhs.run
    end
end


class LessNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run < @rhs.run
    end
end


class NotEqualsNode
    def initialize(a, b)
        @lhs = a 
        @rhs = b 
    end

    def run()
        @lhs.run != @rhs.run
    end
end


class PrintNode
    def initialize(a)
        @print_expr = a
    end

    def run()
        value = @print_expr.run
        puts value
        value #WEIRD maybe (puts)?
    end
end

        
class ConditionNode                   ##Man kanske borde göra om detta till en specifik if-node.  
    def initialize(a)                 ##Då hade man kunnat göra en specifik while-node som man hade använt type-of på för att vad den ska göra.
        @condition = a 
    end
    
    def run()
        @condition.run
    end
end


class BlockNode
    def initialize(a, b)
        @condition = a 
        @statement = b 
    end

    def run()
        if @condition.run == true
            @statement.run
        end
    end
end


class StatementNode
    def initialize(a)
        @statement = a
    end
    
    def run()
        @statement.run
    end
end


#class AssignNode ##IMPLEMENTERA

#class VariableNode ##implementera för att skilja på string och variabler.


    


        