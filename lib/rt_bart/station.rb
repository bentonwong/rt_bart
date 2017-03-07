require 'pry'

class Station

  attr_accessor :name, :info, :status, :advisories

  @@all =[]

  def initialize(station) #creates a new instance of a station
    @name = station
    @info = Scraper.get_station_info(station)
    @@all << self
  end

  def call(station) #initiates instance methods after initialization of the instance
    get_train_status(station)
    update_advisories(station)
  end

  def get_train_status(station) #triggers a call to the BART api for train status and returns that data
    @status = Scraper.get_train_status(station)
  end

  def update_advisories(station) #triggers a call to the BART api for system advisories and returns that data
    @advisories = Scraper.scrape_advisory(station)
  end

  def self.all #displays all the created instance for stations which is used to display search history; future development could include using this to suggest to the user nearby stations to search
    @@all
  end

end
