require 'socket'

socket = TCPServer.new('0.0.0.0', 3000)

puts "Listening to the port 3000..."

loop do
  client = socket.accept

  request = ''

  while line = client.gets
    break if line == "\r\n"

    request += line
  end

  puts request

  response = "HTTP/1.1 200\r\nContent-Type: text/html\r\n\r\n<h1>Hello World!</h1>"

  client.puts(response)

  client.close
end
