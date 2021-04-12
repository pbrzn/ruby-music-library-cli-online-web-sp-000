class Genre
  extend Concerns::Findable
  attr_accessor :name
  @@all=[]
  
  def initialize(name)
    @name=name
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    Genre.new(name).tap do |genre|
      genre.save
    end
  end
  
  def songs
    @songs=[]
    Song.all.each {|song| @songs << song if song.genre==self && !@songs.include?(song)}
    @songs
  end
  
  def artists
    artist_array=[]
    self.songs.each {|song| artist_array << song.artist if !artist_array.include?(song.artist)}
    artist_array
  end
  
  def add_song(song)
    if song.genre != self
      song.genre=self
    end
    if !self.songs.include?(song)
      @songs << song
    end
  end
end