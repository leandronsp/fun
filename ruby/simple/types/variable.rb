class Variable < Struct.new(:name)
  include Inspectable

  def to_s
    name.to_s
  end

  def reducible?
    true
  end

  def reduce(env)
    env[name]
  end

end
