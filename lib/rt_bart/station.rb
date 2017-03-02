class Station

attr_accessor :name, :lines, :advisories, :trains, :arrivals

@@all =[]

  def initialize(station)
    @name = station
    @lines = []
    @advisories = []
    add_advisories(station)
    add_lines(station)
    @@all << self
  end

  def add_lines(station)
    lines_array = []
    lines_array = Scraper.get_line_destination(station)
    lines_array.each do |x|
      @lines << x
    end
  end

  def add_advisories(station)
    @advisories << Scraper.scrape_adv(station)
  end

  def self.all
    @@all
  end

end
