require 'socket'
require 'json'
require 'pg'

require_relative './search_service'
require_relative './search_form_view'
require_relative './search_results_view'

socket = TCPServer.new(3000)

trap("SIGINT") do
  socket.close
  exit(0)
end

puts 'Listening to the port 3000...'

loop do
  client     = socket.accept
  first_line = client.gets

  verb, path, _ = first_line.split(' ')

  request = ''
  headers = {}
  body    = ''
  params  = {}

  while line = client.gets
    break if line == "\r\n"
    request += line

    if line.match(/.*?:.*?/)
      hname, hvalue = line.split(': ')
      headers[hname] = hvalue.chomp
    end
  end

  if content_length = headers['Content-Length']
    body = client.read(content_length.to_i)
    params = JSON.parse(body)
    request += "\n#{body}"
  end

  puts first_line
  puts request
  puts

  if verb == 'GET' && path == '/'
    data = SearchFormView.render

    client.puts("HTTP/1.1 200\r\nContent-Type: text/html\r\n\r\n#{data}")
  elsif verb == 'POST' && path == '/search'
    results = SearchService.new.call(params['term'])
    data    = SearchResultsView.render(results)

    client.puts("HTTP/1.1 200\r\nContent-Type: text/html\r\n\r\n#{data}")
  else
    client.puts("HTTP/1.1 404\r\nContent-Type: text/html\r\n\r\n<p>Not Found</p>")
  end

  client.close
end
