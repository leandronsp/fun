class Account
  def initialize(name, balance)
    @name    = name
    @balance = balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

leandro = Account.new('Leandro', 42)
leandro.name = "Jose"

jose = Account.new('Jose', 42)

jose.send(:deposit, 100)
