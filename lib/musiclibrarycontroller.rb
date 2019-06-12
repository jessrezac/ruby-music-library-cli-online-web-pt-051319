class MusicLibraryController
  def initialize(path = './db/mp3s')
    MusicImporter.new(path).tap{|importer| importer.import}
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    user_input = gets.chomp

    until user_input == "exit"
      case user_input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
      end

      user_input = gets.chomp
    end
  end

  def list_songs
    songs = Song.all.sort {|left, right| left.name <=> right.name}.uniq

    binding.pry

      songs.each_with_index do |song, i|
        puts "#{i}. #{song.artist} - #{song.name} - #{song.genre}"
      end
    end

  end
end
