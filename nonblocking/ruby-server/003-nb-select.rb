require 'socket'

socket = Socket.new(:INET, :STREAM)
socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, true)
addr = Socket.sockaddr_in(3000, '0.0.0.0')

socket.bind(addr)
socket.listen(Socket::SOMAXCONN)

at_exit { socket.close }

puts "Server started..."

@queue = []

loop do
  clients = @queue.map(&:first)

  ready_to_read, _, _ = 
    IO.select([socket] + clients, nil, nil, 0.1)

  ready_to_read&.each do |io|
    if io == socket 
      begin
        client, _ = socket.accept_nonblock
        @queue << [client, Time.now + rand(0.01..1)]
      rescue IO::WaitReadable, Errno::EINTR, IO::EAGAINWaitReadable
      end
    else 
      client, delay_until = 
        @queue
        .find { |_, delay_until| Time.now >= delay_until }

      next unless client

      @queue.delete([client, delay_until])

      client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
      client.close
    end
  end
end
