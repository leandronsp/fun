module Operations
  def reduce(env)
    if left.reducible?
      self.class.new(left.reduce(env), right)
    elsif right.reducible?
      self.class.new(left, right.reduce(env))
    else
      result = eval("#{left.value} #{self.class::OPERATOR} #{right.value}")
      self.class::OUTPUT_TYPE.new result
    end
  end
end
