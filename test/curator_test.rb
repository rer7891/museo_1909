require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < Minitest::Test
  def setup
    @photo_data = './data/photographs.csv'
    @curator = Curator.new
    @photo_2 = Photograph.new({
     id: "2",
     name: "Moonrise, Hernandez",
     artist_id: "2",
     year: "1941"})
    @photo_1 = Photograph.new({
    id: "1",
    name: "Rue Mouffetard, Paris (Boy with Bottles)",
    artist_id: "1",
    year: "1954"})
    @photo_3 = Photograph.new({
     id: "3",
     name: "Identical Twins, Roselle, New Jersey",
     artist_id: "3",
     year: "1967"})
     @photo_4 = Photograph.new({
      id: "4",
      name: "Monolith, The Face of Half Dome",
      artist_id: "3",
      year: "1927"})
    @artist_1 = Artist.new({
    id: "1",
    name: "Henri Cartier-Bresson",
    born: "1908",
    died: "2004",
    country: "France"})
    @artist_2 = Artist.new({
    id: "2",
    name: "Ansel Adams",
    born: "1902",
    died: "1984",
    country: "United States"})
    @artist_3 = Artist.new({
     id: "3",
     name: "Diane Arbus",
     born: "1923",
     died: "1971",
     country: "United States"})
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_starts_with_no_photographs
    assert_equal [], @curator.photographs
  end

  def test_it_can_add_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal 2, @curator.photographs.size
    assert_equal true, @curator.photographs.include?(@photo_1)
    assert_equal true, @curator.photographs.include?(@photo_2)
  end

  def test_it_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal 2, @curator.artists.size
    assert_equal true, @curator.artists.include?(@artist_1)
    assert_equal true, @curator.artists.include?(@artist_2)
  end

  def test_you_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_you_can_find_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_find_photographs_by_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal true, @curator.find_photographs_by_artist(@artist_3).include?(@photo_3)
    assert_equal true, @curator.find_photographs_by_artist(@artist_3).include?(@photo_4)
    assert_equal 2, @curator.find_photographs_by_artist(@artist_3).size
  end

  def test_artists_with_multiple_photos
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal @artist_3, @curator.artists_with_multiple_photographs
  end

  def test_photographs_taken_by_artist_from_country
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal 3, @curator.photographs_taken_by_artist_from("United States").size
    assert_equal true, @curator.photographs_taken_by_artist_from("United States").include?(@photo_2)
    assert_equal true, @curator.photographs_taken_by_artist_from("United States").include?(@photo_3)
    assert_equal true, @curator.photographs_taken_by_artist_from("United States").include?(@photo_4)
    assert_equal [], @curator.photographs_taken_by_artist_from("Argentina")
  end
  def test_it_can_load_photographs
    assert_equal @photo_data, @curator.load_photographs('./data/photographs.csv')
  end

end
