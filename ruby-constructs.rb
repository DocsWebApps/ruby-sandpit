# Overide the inspect method for a particular object
a='foo'
class << a
  def inspect
    "bar"
  end
end
puts a.inspect
# returns bar
a='foo'
puts a.inspect
# returns foo

# Define a class method using << self
class MyTestClass
  class << self
    def my_static_method
      puts "Class method: my_static_method"
    end
    # same as using def self.my_static_method; end
  end
end
MyTestClass.my_static_method
# returns Class method: my_static_method