class Scope
  def initialize()
    @vars = {}
    @funcs = {}
  end

  def set_var(name, value)
    puts("value has been set)", value)
    @vars[name] = value
    puts(@vars[name])
  end

  def get_var(name)
    puts(@vars[name])
    return @vars[name] if @vars.key?(name)
    raise "Variabeln finns inte"
  end

  def set_func(name, func)
    @funcs[name] = func
  end

  def get_func(name)
    return @funcs[name] if @funcs.key?(name)
    return @parent.get_func(name) if @parent
    raise "Function '#{name}' not found"
  end
end

