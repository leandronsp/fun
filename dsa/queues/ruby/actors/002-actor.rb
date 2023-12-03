inbox = Queue.new
outbox = Queue.new

Thread.new do 
  balance = 0

  loop do 
    message = inbox.pop

    case message
    in [:increment, amount]; balance += amount
    in [:decrement, amount]; balance -= amount
    in [:balance]; outbox.push(balance)
    else puts "Unkown message #{message}"
    end
  end
end

inbox.push([:increment, 100])
inbox.push([:decrement, 20])
inbox.push([:balance])

puts "Balance is #{outbox.pop}"
