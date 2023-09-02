require 'socket'
require 'nio'

socket = Socket.new(:INET, :STREAM)
socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, true)
addr = Socket.sockaddr_in(3000, '0.0.0.0')

socket.bind(addr)
socket.listen(Socket::SOMAXCONN)

at_exit { socket.close }

puts "Server started..."

selector = NIO::Selector.new

monitor = selector.register(socket, :r)
monitor.value  = :server

@delays = []

# Delay a client for a given amount of time 
# Using Kernel.sleep would block the entire process
def delay(client, sleep_time)
  @delays << [client, Time.now + sleep_time]
end

def ready_to_respond
  @delays.find { |_, delay_until| Time.now >= delay_until }
end

loop do
  selector.select do |selectable|
    if selectable.value == :client
      client, delay_until = ready_to_respond
      next unless client 

      @delays.delete([client, delay_until])
      selector.deregister(client)

      client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<h1>Hello!</h1>"
      client.close

      next
    end

    begin
      client, _ = socket.accept_nonblock

      client_monitor = selector.register(client, :r)
      client_monitor.value = :client

      delay(client, rand(0.01..1))
    rescue IO::WaitReadable, Errno::EINTR, IO::EAGAINWaitReadable
    end
  end
end
