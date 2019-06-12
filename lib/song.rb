class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) unless artist == nil
    self.genre=(genre) unless genre == nil
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    Song.new(name).tap(&:save)
  end

  def artist=(artist)
    @artist = artist
    self.artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    self.genre.songs.include?(self) || self.genre.songs << self
  end

  def self.find_by_name(name)
    self.all.detect{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(file_name)
    attributes = file_name.split(" - ")
    Song.find_or_create_by_name(attributes[1]).tap do |song|
      song.artist = Artist.find_or_create_by_name(attributes[0])
      song.genre = Genre.find_or_create_by_name(attributes[2].chomp(".mp3"))
    end
  end

  def self.create_from_filename(file_name)
    Song.new_from_filename(file_name).tap{|song| song.save}
  end
end
