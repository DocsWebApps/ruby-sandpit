require 'socket'
require 'rack'
 
# Simple, rack-compliant web server
class MyServer
  STATUS_CODES = {
    200 => 'OK',
    500 => 'Internal Server Error'
  }
 
  attr_reader :app, :tcp_server
 
  def initialize(app)
    @app = app
  end
 
  def start
    @tcp_server = TCPServer.new('localhost', 8080)
    puts 'Listening on 8080...'
 
    loop do
      socket   = tcp_server.accept
      request  = socket.gets
      response = ''
 
      puts request
 
      env = new_env(*request.split)
      status, headers, body = app.call(env)
 
      response << "HTTP/1.1 #{status} #{STATUS_CODES[status]}\r\n"
      headers.each do |k, v|
        response << "#{k}: #{v}\r\n"
      end
      response << "Connection: close\r\n"
 
      socket.print response
      socket.print "\r\n"
 
      if body.is_a?(String)
        socket.print body
      else
        body.each do |chunk|
          socket.print chunk
        end
      end
 
      socket.close
    end
  end
 
  def new_env(method, location, *args)
    {
      'REQUEST_METHOD'   => method,
      'SCRIPT_NAME'      => '',
      'PATH_INFO'        => location,
      'QUERY_STRING'     => location.split('?').last,
      'SERVER_NAME'      => 'localhost',
      'SERVER_PORT'      => '8080',
      'rack.version'     => Rack.version.split('.'),
      'rack.url_scheme'  => 'http',
      'rack.multithread' => false,
      'rack.run_once'    => false
    }
  end
end
 
# Rack needs to know how to start the server
module Rack
  module Handler
    class MyServer 
      def self.run(app, options = {})
        server = ::MyServer.new(app)
        server.start
      end
    end
  end
end
Rack::Handler.register('my_server', 'Rack::Handler::MyServer')

# My Rack compliant application, has a call method that takes an env parameter and returns and array
# consisting of status, headers hash and body.
class MyRackApp
  def self.call(env)
    [200,{},"Yeah Baby !!!!!"]
  end
end

# Start the server !!
#Rack::Handler::MyServer.run(MyRackApp)

# Try WEBrick server !!
Rack::Handler::WEBrick.run(MyRackApp)