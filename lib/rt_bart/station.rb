require 'pry'

class Station

attr_accessor :name, :info, :status, :advisories

@@all =[]

  def initialize(station)
    @name = station
    @info = Scraper.get_station_info(station)
    @status = {}
    @advisories = ""
    @@all << self
  end

  def call(station)
    get_train_status(station)
    update_advisories(station)
    #@status
  end

  def get_train_status(station)
    @status = Scraper.get_train_status(station)
  end

  #def get_train_status
    #@status
  #end

  def update_advisories(station)
    @advisories = Scraper.scrape_advisory(station)
  end

  def self.all
    @@all
  end

end
