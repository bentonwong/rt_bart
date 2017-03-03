class Line

  attr_accessor :name, :inbound
  @@all = []

  def initialize(line_destination,station)
    @name = line_destination
    @inbound = Scraper.get_minutes(station)
    @@all << self
  end

  def inbound_trains
    @inbound
  end

  def self.all
    @@all
  end

end
