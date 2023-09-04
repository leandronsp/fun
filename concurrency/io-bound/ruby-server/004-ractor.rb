require 'socket'

@queue = Ractor.new do
  loop do
    Ractor.yield(Ractor.receive, move: true)
  end
end

listener = Ractor.new(@queue) do |queue|
  socket = Socket.new(:INET, :STREAM)
  addr = Socket.sockaddr_in(3000, '0.0.0.0')

  socket.bind(addr)
  socket.listen(Socket::SOMAXCONN)
  
  puts "Server started..."

  loop do
    client, _ = socket.accept

    queue.send(client, move: true)
  end
end

workers = 8.times.map do
  Ractor.new(@queue) do |queue|
    loop do
      client = queue.take

      sleep rand(0.01..1)
      client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
      client.close
    end
  end
end

loop do
  Ractor.select(listener, *workers)
end
