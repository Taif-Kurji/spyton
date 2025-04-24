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
    def intialize(a)
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
        puts @print_expr.run
    end
end
        
