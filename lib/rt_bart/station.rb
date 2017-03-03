class Station

attr_accessor :name, :info, :status, :advisories,

@@all =[]

  def initialize(station)
    @name = station
    @info = Scraper.get_station_info(station)
    @status = {}
    @advisories = []
    @@all << self
  end

  def call(station)
    @status = get_train_status(station)
    add_advisories
  end

  def get_train_status(station)
    @status = Scraper.get_rt_dept(station)
  end

  def get_train_status
    @status
  end

  def add_advisories(station)
    @advisories << Scraper.scrape_advisory(station)
  end

  def advisories
    @advisories
  end

  def self.all
    @@all
  end

end
