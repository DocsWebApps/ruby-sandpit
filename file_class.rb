# The File class is in the core ruby library
puts __FILE__ # __FILE__ = current filename

file1=File.dirname(__FILE__) # print the files relative directory path but without the filename
puts file1

file2=File.expand_path(__FILE__) # Converts the path name to an absolute path
puts file2

file3=File.expand_path('../config/application', __FILE__) # If your in /usr/bin - the above command will return /usr/bin/config/application
puts file3