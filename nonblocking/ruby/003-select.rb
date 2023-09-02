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

fd_store = { fd0 => "client0", fd1 => "client1" }

loop do
  ready_fds, _, _ = IO.select([fd0, fd1])

  ready_fds.each do |fd|
    line = fd.readpartial(128)
    
    name = fd_store[fd]
    puts "Message from #{name}: #{line}"
  rescue EOFError
  end
end
