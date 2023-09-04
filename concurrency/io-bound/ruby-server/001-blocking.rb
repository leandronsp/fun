###############################################
# File: 001-bsocket.rb
# A blocking socket server
###############################################
# Run Apache AB to test: 
# ab -c 20 -t 3 http://localhost:3000/
# ab -c 100 -t 10 http://localhost:3000/
###############################################
# fortio load -qps 100 -t 10s -a http://localhost:3000/
###############################################
require 'socket'

socket = Socket.new(:INET, :STREAM)
socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, true)
addr = Socket.sockaddr_in(3000, '0.0.0.0')

socket.bind(addr)
socket.listen(Socket::SOMAXCONN)

at_exit { socket.close }

puts "Server started..."

loop do
  client, _ = socket.accept

  sleep rand(0.01..1)

  client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
  client.close
end
