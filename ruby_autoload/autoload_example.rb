# Autoload module ModuleTestClasses, this loads the module but does not do any initialisation
autoload :ModuleTestClasses, './module_test_classes.rb'
puts "Module autoloaded...."

# Try to create a class and catch the exception
begin
  dave=TestClass1.new
  dave.print1('Hi')
rescue Exception => ex
  puts "Can't create a class yet, errors below...."
  puts ex.class
  puts ex.message
end

# Now initialise the classes using include, "Classes loaded..." message gets printed
include ModuleTestClasses
puts "Module now included .... 'Classes loaded...' message should be above !"

#puts "Press return"
#gets.chomp

# Create an object from MyTestClasses
dave=TestClass1.new
dave.print1('Hi')
puts "Object created OK ...."