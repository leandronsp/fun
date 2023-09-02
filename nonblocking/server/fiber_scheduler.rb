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
      wake_time = Time.now + duration
      @sleep_queue << [Fiber.current, wake_time]
      @sleep_queue.sort_by! { |_, time| time }
    end

    Fiber.yield
  end

  def run
    @fibers.each(&:resume)

    loop do
      now = Time.now
      
      # Wake up sleeping fibers
      while @sleep_queue.any? && @sleep_queue.first[1] <= now
        fiber, _ = @sleep_queue.shift
        fiber.resume
      end

      # IO handling
      if @readable.any?
        ready_to_read, = IO.select(@readable.keys, nil, nil, 0)
        ready_to_read&.each do |io|
          fiber = @readable.delete(io)
          fiber.resume
        end
      else
        # Sleep for a bit if there's nothing to do, to avoid busy-looping
        sleep 0.1
      end
    end
  end
end
