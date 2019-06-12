class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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
    Genre.new(name).tap(&:save)
  end

  def artists
    self.songs.map {|song| song.artist}.uniq
  end

end
