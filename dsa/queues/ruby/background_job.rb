require 'test/unit'
require 'net/http'
require 'uri'
require 'byebug'

class Node
  attr_accessor :value, :next, :prev

  def initialize(value)
    @value = value
    @next = nil
    @prev = nil
  end
end

class Deque
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def rpush(value)
    node = Node.new(value)

    if @tail.nil?
      @tail = node
      @head = node
      return
    end

    node.prev = @tail
    @tail.next = node
    @tail = node
  end

  def lpush(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
      @tail = node
      return
    end

    node.next = @head
    @head.prev = node
    @head = node
  end

  def rpop
    return unless @tail

    @tail.value.tap do
      @tail = @tail.prev
      @tail.next = nil if @tail
      @head = nil unless @tail
    end
  end

  def lpop
    return unless @head

    @head.value.tap do
      @head = @head.next
      @head.prev = nil if @head
      @tail = nil unless @head
    end
  end

  def rpoplpush(other)
    rpop.tap do |value|
      other.lpush(value) if value
    end
  end

  # O(n)
  def to_a
    array = []

    pointer = @head

    while pointer
      array << pointer.value

      pointer = pointer.next
    end

    array
  end
end

class BlockingDeque
  def initialize
    @deque = Deque.new
    @mutex = Mutex.new
    @emitter = ConditionVariable.new
  end

  def rpush(value)
    @mutex.synchronize do
      @deque.rpush(value)
      @emitter.signal
    end

    nil
  end

  def lpush(value)
    @mutex.synchronize do
      @deque.lpush(value)
      @emitter.signal
    end

    nil
  end

  def brpop
    @mutex.synchronize do
      @emitter.wait(@mutex) unless @deque.tail

      @deque.rpop
    end
  end

  def blpop
    @mutex.synchronize do
      @emitter.wait(@mutex) unless @deque.head

      @deque.lpop
    end
  end

  def brpoplpush(other)
    brpop.tap do |value|
      other.lpush(value) if value
    end
  end

  def lpop = @deque.lpop
  def rpop = @deque.rpop
  def rpoplpush(other) = @deque.rpoplpush(other)
  def to_a = @deque.to_a
end

class Worker
  MAX_RETRIES = 3

  attr_reader :task_queue, :processing_queue, :dlq

  def initialize(task_queue)
    @task_queue = task_queue
    @processing_queue = BlockingDeque.new
    @dlq = BlockingDeque.new

    @retries = Hash.new(0)
  end

  def start!
    Thread.new do
      wid = Thread.current.object_id
      puts "Worker #{wid} started. Waiting for tasks..."

      loop do
        task = @task_queue.brpoplpush(@processing_queue)

        process(wid, task)
      end
    end
  end

  def process(wid, task)
    puts "[worker-#{wid}] Processing task #{task}..."

    begin
      Net::HTTP.get(URI(task))
      @processing_queue.lpop

      puts "[worker-#{wid}] Task #{task} processed successfully!"
    rescue => e
      puts "Error processing task #{task}: #{e.message}"
      @retries[task] += 1

      if @retries[task] > MAX_RETRIES
        puts "[worker-#{wid}] Max retries reached for task #{task}. Moving to DLQ..."
        @processing_queue.rpoplpush(@dlq)
      else
        puts "[worker-#{wid}] Retrying task #{task}..."
        @processing_queue.rpoplpush(@task_queue)
      end
    end
  end
end

class SidequicoTest < Test::Unit::TestCase
  def test_complex
    task_queue = BlockingDeque.new

    task_queue.lpush('https://hub.dummyapis.com/delay?seconds=1')

    worker = Worker.new(task_queue)

    assert_equal(1, worker.task_queue.to_a.size)

    worker.start!

    sleep 0.1 while worker.processing_queue.to_a.size.zero?
    assert_equal(1, worker.processing_queue.to_a.size)
    assert_equal(0, worker.task_queue.to_a.size)

    sleep 0.1 until worker.processing_queue.to_a.size.zero?
    assert_equal(0, worker.processing_queue.to_a.size)
    assert_equal(0, worker.task_queue.to_a.size)

    task_queue.lpush('https://wroooong.coms')

    sleep 0.1 while worker.dlq.to_a.size.zero?
    assert_equal(1, worker.dlq.to_a.size)
    assert_equal(0, worker.processing_queue.to_a.size)
    assert_equal(0, worker.task_queue.to_a.size)
  end
end

class Sidequico
  def initialize
    @task_queue = BlockingDeque.new
    @worker = Worker.new(@task_queue)
  end

  def run!
    @worker.start!

    loop do
      option = menu

      case option
      when 1
        print 'Digite a URL: '
        url = gets.chomp

        @task_queue.rpush(url)
      when 2
        puts @worker.task_queue.to_a
      when 3
        puts @worker.processing_queue.to_a
      when 4
        puts @worker.dlq.to_a
      when 5
        break
      else
        puts 'Opção inválida'
      end
    end

    puts 'Bye'
  end

  def menu
    sleep 0.05
    puts "====== Sidequico ======"

    puts '## Menu ##'
    puts '#1 - Enfileirar'
    puts '#2 - Ver fila'
    puts '#3 - Ver processamento'
    puts '#4 - Ver DLQ'
    puts '#5 - Sair'
    puts

    print 'Escolha uma opção: '
    gets.to_i
  end
end

#Sidequico.new.run!
