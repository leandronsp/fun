require 'fileutils'

def cleanup
  puts "Cleaning up..."
  FileUtils.rm_f(["client0", "client1"])
  puts "Bye!"
end

def register_handler(fd, client_name)
  Fiber.new do
    loop do
      line = fd.gets

      if line
        puts "Message from #{client_name}: #{line.chomp}"
      end

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

loop do
  [fiber0, fiber1].each(&:resume)

  sleep 0.5
end
