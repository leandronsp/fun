class Machine < Struct.new(:expression, :env)
  def step
    self.expression = expression.reduce(env)
  end

  def run
    while expression.reducible?
      puts expression
      step
    end

    puts expression
  end
end
