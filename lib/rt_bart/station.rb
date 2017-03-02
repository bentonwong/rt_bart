class station

attr_accessor :destinations

  def initialize(station)
    @name = station
    @destinations = []
    @advisories = []
    @trains =[]
  end

end
