require 'socket'
require_relative 'fiber_scheduler'

scheduler = FiberScheduler.new
Fiber.set_scheduler(scheduler)

socket = Socket.new(:INET, :STREAM)

addr = Socket.sockaddr_in(3000, '0.0.0.0')
socket.bind(addr)

socket.listen(Socket::SOMAXCONN)

at_exit { socket.close }

puts "Server started..."

accept_fiber = Fiber.new do
  loop do
    begin
      client, _ = socket.accept_nonblock

      handler = Fiber.new do
        sleep rand(0.01..1)

        client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
        client.close
      end

      handler.resume
    rescue IO::WaitReadable, Errno::EINTR
      scheduler.io_wait(socket, IO::READABLE, nil)
    end
  end
end

scheduler.register(accept_fiber)
scheduler.run
