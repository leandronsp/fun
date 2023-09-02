require 'nio'
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

selector = NIO::Selector.new

monitor0 = selector.register(fd0, :r)
monitor0.value = "client0"

monitor1 = selector.register(fd1, :r)
monitor1.value = "client1"

loop do
  selector.select do |monitor|
    fd = monitor.io
    client_name = monitor.value
    line = fd.readpartial(128) rescue nil
    puts "Message from #{client_name}: #{line.chomp}" if line
  rescue EOFError
    selector.deregister(fd)
  end
end
