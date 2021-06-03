require 'socket'

server=UNIXServer.new "/tmp/socktest.sock"

loop do
  Thread.start(server.accept) do |client|
    puts client.readline
    client.write "Hello"
    client.write "Time now is #{Time.now}\n"
    client.close
  end
end