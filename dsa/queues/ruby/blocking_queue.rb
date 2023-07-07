## Data race ##
puts 'Simulate a data race:'
@queue = []
n = 1_000

# Producer
producer = Thread.new do
  sleep(rand(0.0001..0.0005))
  n.times.map do |i|
    @queue.push(i+1)
  end
end

# Consumer
consumer = Thread.new do
  result = n.times.map do
    sleep(rand(0.0001..0.0005))
    @queue.shift
  end

  puts result.compact.length
end

consumer.join
producer.join

## Mutual exclusion ##
puts 'Using mutual exclusion:'
@queue = []
@mutex = Mutex.new

# Producer
producer = Thread.new do
  n.times.map do |i|
    sleep(rand(0.0001..0.0005))

    @mutex.synchronize do
      @queue.push(i+1)
    end
  end
end

# Consumer
consumer = Thread.new do
  result = n.times.map do
    sleep(rand(0.0001..0.0005))

    @mutex.synchronize do
      @queue.shift
    end
  end

  puts result.compact.length
end

consumer.join
producer.join

## Condition variable ##
puts 'Using condition variable:'
@queue = []
@mutex = Mutex.new
@emitter = ConditionVariable.new

# Producer
producer = Thread.new do
  n.times.map do |i|
    sleep(rand(0.0001..0.0005))

    @mutex.synchronize do
      @queue.push(i+1)
      @emitter.signal
    end
  end
end

# Consumer
consumer = Thread.new do
  result = n.times.map do
    sleep(rand(0.0001..0.0005))

    @mutex.synchronize do
      @emitter.wait(@mutex) while @queue.empty?
      @queue.shift
    end
  end

  puts result.compact.length
end

consumer.join
producer.join

## Using thread-safe Queue ##
puts 'Using thread-safe Queue:'
@queue = Queue.new
@mutex = Mutex.new

# Producer
producer = Thread.new do
  n.times.map do |i|
    sleep(rand(0.0001..0.0005))

    @queue.push(i+1)
  end
end

# Consumer
consumer = Thread.new do
  result = n.times.map do
    sleep(rand(0.0001..0.0005))

    @queue.shift
  end

  puts result.compact.length
end

consumer.join
producer.join
