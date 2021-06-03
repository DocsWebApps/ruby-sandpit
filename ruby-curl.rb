require 'socket'
require 'uri'

print "Enter a domain (default - www.docswebapps.com): "

input=gets.chomp

url=URI.parse("http://#{input.empty? ? 'www.docswebapps.com' : input}/")

puts "Downloading #{url.to_s}"

connection=TCPSocket.new url.host,80
connection.puts "GET / HTTP/1.1"
connection.puts "Host: #{url.host}"
connection.puts "Connection: close"
connection.puts "\n"

while line=connection.gets
  puts line
end

puts "Downloading from #{url.host}"
connection.close