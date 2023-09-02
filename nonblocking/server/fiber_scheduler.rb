class FiberScheduler
  def initialize
    @readable = {}
    @sleep_queue = []
    @fibers = []
  end

  def register(fiber)
    @fibers << fiber
  end

  def io_wait(io, events, duration)
    if events & IO::READABLE != 0
      @readable[io] = Fiber.current
    end

    Fiber.yield
  end

  def block(*args)
    Fiber.yield
  end

  def unblock(fiber, *args)
    fiber&.resume if fiber.is_a?(Fiber)
  end

  def kernel_sleep(duration = nil)
    if duration
      delay_until = Time.now + duration
      @sleep_queue << [Fiber.current, delay_until]
      @sleep_queue.sort_by! { |_, time| time }
    end

    Fiber.yield
  end

  def run
    @fibers.each(&:resume)

    loop do
      while @sleep_queue.any? && @sleep_queue.first.last <= Time.now
        fiber, _ = @sleep_queue.shift
        fiber.resume if fiber.alive?
      end

      ready_to_read, _, _ = IO.select(@readable.keys, nil, nil, 0.1)

      ready_to_read&.each do |io|
        fiber = @readable.delete(io)
        fiber.resume
      end
    end
  end
end
