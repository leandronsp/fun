require 'rack'
require 'rack/handler/falcon'
require 'rack/handler/puma'

App = -> (env) do
  sleep rand(0.01..1)
  [200, {'Content-Type' => 'text/html'}, ["<h1>Hello World</h1>"]]
end

Rack::Handler::Falcon.run(App, Port: 3000, Host: '0.0.0.0')
#Rack::Handler::Puma.run(App, Port: 3000, Threads: '0:8')
