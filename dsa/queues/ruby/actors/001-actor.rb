class MyQueue
  def initialize
    @queue = []
    @mutex = Mutex.new
    @emitter = ConditionVariable.new
  end

  def push(element)
    @queue.push(element)
    @emitter.signal
  end

  def shift
    @mutex.synchronize do 
      if @queue.empty?
        @emitter.wait(@mutex)
      end

      @queue.shift
    end
  end
end

inbox = MyQueue.new
outbox = MyQueue.new

Thread.new do 
  balance = 0

  loop do 
    message = inbox.shift

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

puts "Balance is #{outbox.shift}"
