class Cractor
  attr_reader :inbox, :outbox

  def initialize(state)
    @inbox = Queue.new
    @outbox = Queue.new

    Thread.new(state) do 
      yield(state, @inbox, @outbox)
    end
  end
end

account = Cractor.new(0) do |state, inbox, outbox|
  loop do
    message = inbox.pop

    case message
    in [:increment, amount]; state += amount
    in [:decrement, amount]; state -= amount
    in [:balance]; outbox.push(state)
    else puts "Unkown message #{message}"
    end
  end
end

account.inbox.push([:increment, 100])
account.inbox.push([:decrement, 20])
account.inbox.push([:balance])

puts "Balance is #{account.outbox.pop}"
