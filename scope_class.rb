class Scope
  def initialize(parent = nil)
    @vars = {}
    @funcs = {}
    @parent = parent
  end

  def set_var(name, value)
    @vars[name] = value
  end

  def get_var(name)
    if @vars.key?(name)
      @vars[name]
    elsif @parent 
      @parent.get_var(name)
    else
      raise "Variabeln finns inte"
    end
  end

  def set_func(name, func)
    @funcs[name] = func
  end

  def get_func(name)
    if @funcs.key?(name)
      @funcs[name]
    elsif @parent 
      @parent.get_func(name)
    else
      raise "Funktionen finns inte"
    end
  end

  def new_scope()
    Scope.new(self)
  end
end

