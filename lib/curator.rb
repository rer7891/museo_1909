class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id_num)
    @artists.find { |artist| artist.id == id_num}
  end

  def find_photograph_by_id(id)
    @photographs.find { |photo| photo.id == id }
  end

  def find_photographs_by_artist(artist)
    artists_photos = @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
    artists_photos
  end

  def artists_with_multiple_photographs
    @artists.find do |artist|
       find_photographs_by_artist(artist).size > 1
    end
  end

  def photographs_taken_by_artist_from(country)
    photos_by_country = []
    @artists.each do |artist|
        if artist.country == country
          photos_by_country << find_photographs_by_artist(artist)
        end
      end
    photos_by_country.flatten
  end
end
