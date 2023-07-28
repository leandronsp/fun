require 'test/unit'

class BlockingQueue
  def initialize
    @store = []
    @mutex = Mutex.new
    @emitter = ConditionVariable.new
  end

  def push(value)
    @mutex.synchronize do
      @store.push(value)
      @emitter.signal
    end
  end

  def pop
    @mutex.synchronize do
      @emitter.wait(@mutex) if @store.empty?
      @store.shift
    end
  end
end
