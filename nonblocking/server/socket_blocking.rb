require 'socket'

socket = Socket.new(:INET, :STREAM)
socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, true)
addr = Socket.sockaddr_in(3000, '0.0.0.0')

socket.bind(addr)
socket.listen(Socket::SOMAXCONN)

at_exit { socket.close }

puts "Server started..."

def delay(_client, sleep_time)
  sleep sleep_time
end

loop do
  client, _ = socket.accept

  delay(client, rand(0.01..1))

  client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
  client.close
end
