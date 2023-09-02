class FiberQueue
  def initialize
    @queue = []
    @waiting_fibers = []
  end

  def push(item)
    @queue.push(item)
    fiber = @waiting_fibers.shift

    fiber&.resume
  end

  def pop
    if @queue.empty?
      @waiting_fibers << Fiber.current
      Fiber.yield
    end

    @queue.shift
  end
end
