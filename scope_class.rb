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
end

