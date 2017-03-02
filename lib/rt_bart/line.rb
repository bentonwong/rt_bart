class Line

  def initialize(destination)
    @name = destination
    @arrivals = []
    @@all << self
  end

  def arrivals(line)
    @arrivals = [{:minutes => "8", :cars => "10"},
                {:minutes => "18", :cars => "10"},
                {:minutes => "28", :cars => "10"}]
  end

  def self.all
    @@all
  end



end
