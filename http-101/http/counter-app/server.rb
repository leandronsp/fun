require 'socket'

socket = Socket.new(:INET, :STREAM)

addr = Socket.sockaddr_in(3000, '0.0.0.0')
socket.bind(addr)

socket.listen(2)

puts "Listening to the port 3000..."

trap("SIGINT") do
  socket.close
  exit(0)
end

loop do
  # fica a espera de um novo client (nova mensagem no socket)
  client, _ = socket.accept

  counter = 0

  # le mensagem do socket client
  while line = client.gets
    break if line == "\r\n"
    puts line

    if line.match(/Cookie: (.*?)$/)
      _key, value = line.split
      cookie_name, cookie_value = value.split('=')

      if cookie_name == 'counter'
        counter = cookie_value.to_i + 1
      end
    end
  end

  response = <<-HTTP
HTTP/2 200\r
Content-Type: text/html\r
Expires: Mon, 25 Jun 2021 21:31:12 GMT\r
Set-Cookie: counter=#{counter}; path=/; HttpOnly\r
\r
<h1>Counter: #{counter}</h1>
<a href="javascript:location.reload(true)">Reload with refresh</a>
<br>
<a href="/">Reload without refresh</a>
    HTTP

  # escreve mensagem no socket client
  client.puts(response)

  # fecha socket client
  client.close
end
