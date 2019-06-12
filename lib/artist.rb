class Artist
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
    Artist.new(name).tap(&:save)
  end

  def add_song(song)
    song.artist ||= self
    self.songs.include?(song) || self.songs << song
  end

  def genres
    self.songs.map {|song| song.genre}.uniq
  end

end
