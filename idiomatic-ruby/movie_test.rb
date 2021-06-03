require 'minitest/autorun'
require_relative 'movie'

class MoviTest < MiniTest::Test
  def setup
    @movie=Movie.new({
      title: 'Star Wars IV',
      genre: 'Science Fiction',
      director: 'George Lucas'
      })
  end

  def test_director
    assert_equal 'George Lucas', @movie.director
  end

  def test_genre
    assert_equal 'Star Wars IV', @movie.title
  end

  def test_title
    assert_equal 'Science Fiction', @movie.genre
  end
end