require 'socket'

socket = Socket.new(:UNIX, :STREAM)

addr = Socket.sockaddr_un('server.sock')
socket.bind(addr)

socket.listen(2)
puts "Listening to `server.sock`..."

client, _ = socket.accept

puts client.gets
client.puts("Response: Yo!")

client.close
socket.close

system('rm server.sock')
