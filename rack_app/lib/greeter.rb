require 'erb'

class Greeter

  def self.call(env)
    new(env).response.finish # Create new Greeter object nad call response method then finish method
  end

  def initialize(env)
    @request=Rack::Request.new(env)
  end

  def response
    #[200, {"Content-Type" => "text/plain"}, ['Hello World!, really - hey hey']] # Basic Rack response array [status, headers, body]
    #Rack::Response.new("Hello") # Using Rack::Response object
    case @request.path
    when "/" 
      Rack::Response.new(render("index.html.erb")) # Render ruby template
    else
      Rack::Response.new("Page not found, 404") # Render ruby template
    end
  end

  def render(template)
    path=File.expand_path("../../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
  
end