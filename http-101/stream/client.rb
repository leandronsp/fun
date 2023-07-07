require 'socket'

socket = Socket.new(:UNIX, :STREAM)

addr = Socket.sockaddr_un('server.sock')
socket.connect(addr)

socket.puts('hello from Ruby client')
puts socket.gets

socket.close
