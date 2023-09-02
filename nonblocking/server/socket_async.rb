require 'socket'
require 'async'
require 'async/scheduler'

scheduler = Async::Scheduler.new
Fiber.set_scheduler(scheduler)

socket = Socket.new(:INET, :STREAM)

addr = Socket.sockaddr_in(3000, '0.0.0.0')
socket.bind(addr)

socket.listen(Socket::SOMAXCONN)

at_exit { socket.close }

puts "Server started..."

Async do |task|
  loop do
    begin
      client, _ = socket.accept

      task.async do
        sleep rand(0.01..1)
        client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
        client.close
      end
    rescue IO::WaitReadable, Errno::EINTR
    end
  end
end
