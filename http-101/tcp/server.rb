require 'socket'

socket = Socket.new(:INET, :STREAM) # TCP
addr   = Socket.sockaddr_in(3000, '0.0.0.0')

socket.bind(addr)
socket.listen(2)

puts "Listening to the port 3000..."

client, _ = socket.accept
request   = client.gets

puts request
client.print("Hello from server!")

client.close
socket.close
