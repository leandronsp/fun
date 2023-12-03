account = Ractor.new(0) do |state|
  loop do
    message = Ractor.receive

    case message
    in [:increment, amount]; state += amount
    in [:decrement, amount]; state -= amount
    in [:balance]; Ractor.yield(state)
    else puts "Unkown message #{message}"
    end
  end
end

account.send([:increment, 100])
account.send([:decrement, 20])
account.send([:balance])

puts "Balance is #{account.take}"
