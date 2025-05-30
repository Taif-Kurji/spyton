class Scope
  def initialize()
    @vars = {}
    @funcs = {}
  end

  def set_var(name, value)
    @vars[name] = value
  end

  def get_var(name)
    return @vars[name] if @vars.key?(name)
    raise "Variabeln finns inte"
  end

  def set_func(name, func)
    @funcs[name] = func
  end

  def get_func(name)
    return @funcs[name] if @funcs.key?(name)
    raise "Funktionen finns inte"
  end
end

