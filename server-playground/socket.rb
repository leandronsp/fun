# A UNIX socket server written in pure Ruby

require 'socket'

socket_path = '/tmp/echo.sock'
File.unlink(socket_path) if File.exist?(socket_path)

server = UNIXServer.new(socket_path)

puts "Listening on socket #{socket_path}"
puts "===> Connect using netcat: `nc -U #{socket_path}`"
puts "===> Connect using curl: `curl -s --unix-socket #{socket_path} http://localhost/`"
puts "===> Press Ctrl+C to exit"

loop do
  begin
    client = server.accept

    data = client.recv(512)

    puts data

    client.close
  rescue => e
    puts "Error while accepting connection: #{e.message}"
  end
end
