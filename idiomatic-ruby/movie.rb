class Movie

  attr_reader :title, :genre, :director

  def initialize(options)
    @title=options[:title]
    @genre=options[:genre]
    @director=options[:director]
  end
end