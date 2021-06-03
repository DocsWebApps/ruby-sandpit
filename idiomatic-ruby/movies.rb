 # Open a File and read the contents 
  # Procedural Ruby
  #file_handle=File.open("movies.csv","r")
  #begin
  #  lines=file_handle.readlines
  #ensure
  #  file_handle.close
  #end
  #p lines

  # Using a lambda
  #read_all_lines=lambda {|file_handle| file_handle.readlines}
  #lines=File.open("movies.csv","r",&read_all_lines)
  #p lines

  # Using a block
  lines=File.open("movies.csv","r") do |file_handle|
    file_handle.readlines
  end

  rows=[]
  lines.each do |line|
    rows << line.chomp.split(",")
  end

  p rows.first