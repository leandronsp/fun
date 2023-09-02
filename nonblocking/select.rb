require 'fileutils'

def cleanup
  puts "Cleaning up..."
  FileUtils.rm_f(["client0", "client1"])
  puts "Bye!"
end

at_exit { cleanup }

# Create FIFO files
File.mkfifo("client0")
File.mkfifo("client1")

puts "Server started..."

fd0 = File.open("client0", File::RDONLY | File::NONBLOCK)
fd1 = File.open("client1", File::RDONLY | File::NONBLOCK)

loop do
  # Wait for activity on the file descriptors using IO.select
  ready_fds = IO.select([fd0, fd1])

  # Loop through each ready file descriptor and read data
  ready_fds[0].each do |fd|
    line = fd.readpartial(128)
    
    if fd == fd0
      puts "Message from client0: #{line}"
    elsif fd == fd1
      puts "Message from client1: #{line}"
    end
  rescue EOFError
  end
end
