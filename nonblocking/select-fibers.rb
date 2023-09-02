require 'fileutils'

def cleanup
  puts "Cleaning up..."
  FileUtils.rm_f(["client0", "client1"])
  puts "Bye!"
end

def register_handler(fd, client_name)
  Fiber.new do
    loop do
      line = fd.readpartial(128) rescue nil
      puts "Message from #{client_name}: #{line.chomp}" if line

      Fiber.yield
    end
  end
end

at_exit { cleanup }

File.mkfifo("client0")
File.mkfifo("client1")

puts "Server started..."

fd0 = File.open("client0", File::RDONLY | File::NONBLOCK)
fd1 = File.open("client1", File::RDONLY | File::NONBLOCK)

fiber0 = register_handler(fd0, "client0")
fiber1 = register_handler(fd1, "client1")

fiber_store = {fd0 => fiber0, fd1 => fiber1}

loop do
  ready_fds = IO.select(fiber_store.keys)

  ready_fds[0].each do |fd|
    fiber_store[fd].resume
  rescue EOFError
    fiber_store.delete(fd)
  end
end
