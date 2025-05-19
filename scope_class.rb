class Scope
  def initialize()
    @vars = {}
    @funcs = {}
    #@parent
  end

  def set_var(name, value)
    puts("Variabel har skapats", value)
    @vars[name] = value
    puts(@vars[name])
  end

  def get_var(name)
    puts(@vars[name])
    return @vars[name] if @vars.key?(name)
    #return @parent.get_func(name) if @parent
    raise "Variabeln finns inte"
  end

  def set_func(name, func)
    @funcs[name] = func
  end

  def get_func(name)
    return @funcs[name] if @funcs.key?(name)
    #return @parent.get_func(name) if @parent 
    raise "Funktionen finns inte"
  end
end

