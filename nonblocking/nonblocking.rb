require 'fileutils'

def cleanup
  puts "Cleaning up..."
  FileUtils.rm_f(["client0", "client1"])
  puts "Bye!"
end

at_exit { cleanup }

File.mkfifo("client0")
File.mkfifo("client1")

puts "Server started..."

fd0 = File.open("client0", File::RDONLY | File::NONBLOCK)
fd1 = File.open("client1", File::RDONLY | File::NONBLOCK)

loop do
  line0 = fd0.gets

  if line0
    puts "Message from client0: #{line0.chomp}"
  end

  line1 = fd1.gets

  if line1
    puts "Message from client1: #{line1.chomp}"
  end

  sleep 0.5
end
