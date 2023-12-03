class Account 
  def initialize
    @inbox = Queue.new
    @outbox = Queue.new

    # Actor
    Thread.new do 
      balance = 0

      loop do 
        message = @inbox.pop

        case message
        in [:increment, amount]; balance += amount
        in [:decrement, amount]; balance -= amount
        in [:balance]; @outbox.push(balance)
        else puts "Unkown message #{message}"
        end
      end
    end
  end

  def increment(amount)
    @inbox.push([:increment, amount])
  end

  def decrement(amount)
    @inbox.push([:decrement, amount])
  end

  def balance
    @inbox.push([:balance])
    @outbox.pop
  end
end

account = Account.new

account.increment(100)
account.decrement(20)

puts "Balance is #{account.balance}"
