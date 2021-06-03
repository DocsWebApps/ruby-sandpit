require 'socket'

class AppServer
  attr_reader :connection, :view

  def initialize(connection:, view:)
    @connection=connection
    @view=view
  end

  def run
    while true
      connection.on_request do |socket|
        while (line=socket.readline) != "\r\n"
          puts line
        end
        socket.write view.render
      end
    end
  end
end

class Connection
  attr_reader :path

  def initialize(path:)
    @path=path
    File.unlink(path) if File.exist?(path)
  end

  def server
    @server||=UNIXServer.new path
  end

  def on_request
    socket=server.accept
    yield(socket)
    socket.close
  end
end

class TimeView
  def render
<<-EOF
%[HTTP/1.1 200 OK

Content-Length: 36
Content_type: text/plain

The current timestamp is: #{Time.now.to_s}
EOF
  end
end


AppServer.new(connection: Connection.new(path: "/tmp/socktest.sock"), view: TimeView.new).run