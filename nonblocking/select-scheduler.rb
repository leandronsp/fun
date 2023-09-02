require 'fileutils'

class MyScheduler
  def initialize
    @readable = {}
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
    fiber&.resume
  end

  def kernel_sleep(duration = nil)
    sleep(duration) if duration
    Fiber.yield
  end

  def run
    @fibers.each(&:resume)

    loop do
      ready_to_read, _ = IO.select(@readable.keys)

      ready_to_read.each do |io|
        fiber = @readable.delete(io)
        fiber&.resume
      end
    end
  end
end

def cleanup
  puts "Cleaning up..."
  FileUtils.rm_f(["client0", "client1"])
  puts "Bye!"
end

def register_handler(fd, client_name, scheduler)
  Fiber.new do
    loop do
      scheduler.io_wait(fd, IO::READABLE, nil)
      line = fd.readpartial(128) rescue nil
      puts "Message from #{client_name}: #{line.chomp}" if line
    end
  end
end

at_exit { cleanup }

File.mkfifo("client0")
File.mkfifo("client1")

puts "Server started..."

fd0 = File.open("client0", File::RDONLY | File::NONBLOCK)
fd1 = File.open("client1", File::RDONLY | File::NONBLOCK)

scheduler = MyScheduler.new
Fiber.set_scheduler(scheduler)

fiber0 = register_handler(fd0, "client0", scheduler)
fiber1 = register_handler(fd1, "client1", scheduler)

scheduler.register(fiber0)
scheduler.register(fiber1)

scheduler.run
