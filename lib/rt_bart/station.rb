class Station

attr_accessor :lines, :advisories, :trains, :arrivals

@@all =[]

  def initialize(station)
    @name = station
    @lines = []
    @advisories = []
    @@all << self
  end

  def add_lines(station)
    @lines << ["DUBL","DALY"] #placeholder until scraper running
  end

  def add_advisories(station)
    @advisories << ["No delays reported."]
  end

  def self.all
    @@all
  end

end
