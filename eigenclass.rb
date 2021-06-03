# "Eigenclass". 
# This is effectively an anonymous class that Ruby creates and 
# inserts into the inheritance hierarchy to hold class and singleton methods 
# (thus not interfering with the instances that are created from the class).


class Foo
  # Public instance method
  def public_hello
    puts "public hello"
  end

  # Public class method
  def self.public_goodbye
    puts "public goodbye"
  end

  private
    # Private instance method
    def private_hello
      puts "private hello"
    end

    # Private class method - you'd think!
    def self.private_goodbye
      puts "private goodbye"
    end
end

myfoo=Foo.new
myfoo.public_hello # Should print "public hello"
#myfoo.private_hello # Should error as its a private method
Foo.public_goodbye # Should print "public goodbye"
Foo.private_goodbye # Should error as its a private method, but doesn't

# What gives?
# The private method makes all methods defined below it in the Foo class private.
# However class methods although written in the class Foo are in fact defined in a eigneclass 
# thats inserted into the Foo class heirarchy - similar to singleton classes.
# To declare private class methods either use the << syntax to declare the class method
# or use the method :private_class_method to make it private

class Bar
  class << self
    private
      def private_hello
        puts "private hello"
      end
  end

  def self.private_goodbye
    puts "goodbye"
  end

  private_class_method :private_goodbye
end

#Bar.private_hello # Should error out, method is now private
#Bar.private_goodbye # Should error out, method is now private

# Same idea also works for singletons

class MyClass; end

myclass=MyClass.new

class << myclass
  def public_hello
    puts "public hello"
  end

  private
    def priivate_goodbye
      puts "private goodbye"
    end
end

myclass.public_hello # Should work, public method
myclass.priivate_goodbye # Should fail, private singleton method