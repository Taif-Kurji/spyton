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
end

