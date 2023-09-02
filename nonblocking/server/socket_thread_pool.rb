require 'socket'

socket = Socket.new(:INET, :STREAM)
addr = Socket.sockaddr_in(3000, '0.0.0.0')

socket.bind(addr)
socket.listen(Socket::SOMAXCONN)

at_exit { socket.close }

@queue = Queue.new

50.times.map do
  Thread.new do
    loop do
      client = @queue.pop
      sleep rand(0.01..1)
      client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
      client.close
    end
  end
end

puts "Server started..."

loop do
  client, _ = socket.accept

  @queue.push(client)
end
