require "socket"

socket=UNIXSocket.new "/tmp/socktest.sock"

socket.write "Hi there"
socket.write "\n"

puts socket.readline

socket.close