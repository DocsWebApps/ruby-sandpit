require "greeter"

use Rack::Reloader, 0

run Greeter # Greeter must have a "call" method that accepts one param, the env object

# To start use: rackup -Ilib