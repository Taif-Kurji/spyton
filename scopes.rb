class Scope
    #@next_scope #pekar till ett inre scope
    @previous_scope #pekar till yttre scope
    @variables = previous_scope.variable
    @conditions = [] #detta är för while och for loopar. de här raderna kod ska köras varenda "tick"?
