require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < Minitest::Test
  def setup
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
    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end
end
