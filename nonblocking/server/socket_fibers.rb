require 'socket'

socket = Socket.new(:INET, :STREAM)
socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, true)
addr = Socket.sockaddr_in(3000, '0.0.0.0')

socket.bind(addr)
socket.listen(Socket::SOMAXCONN)

at_exit { socket.close }

@queue = []
@readable = {}

puts "Server started..."

accept = Fiber.new do |io|
  loop do
    begin
      client, _ = io.accept_nonblock

      handler = Fiber.new do
        delay_until = Time.now + rand(0.01..1)
        @queue.push([Fiber.current, delay_until])
        @queue.sort_by! { |_, time| time }

        Fiber.yield

        client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
        client.close
      end

      handler.resume
    rescue IO::WaitReadable, Errno::EINTR
      @readable[io] = Fiber.current
      Fiber.yield
    end
  end
end

accept.resume(socket)

loop do
  while @queue.any? && @queue.first.last <= Time.now
    fiber, _ = @queue.shift
    fiber.resume if fiber.alive?
  end

  ready_to_read, _, _ = IO.select(@readable.keys, nil, nil, 0.1)

  ready_to_read&.each do |io|
    fiber = @readable.delete(io)
    fiber.resume
  end
end
