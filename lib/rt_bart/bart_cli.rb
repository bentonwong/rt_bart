class Controller

  STATIONS = stations = [{:code => "12th", :station => "12th St. Oakland City Center"},
          {:code => "16th", :station => "16th St. Mission (SF)"},
          {:code => "19th", :station => "19th St. Oakland"},
          {:code => "24th", :station => "24th St. Mission (SF)"},
          {:code => "ashb", :station => "Ashby (Berkeley)"},
          {:code => "balb", :station => "Balboa Park (SF)"},
          {:code => "bayf", :station => "Bay Fair (San Leandro)"},
          {:code => "cast", :station => "Castro Valley"},
          {:code => "civc", :station => "Civic Center (SF)"},
          {:code => "cols", :station => "Coliseum"},
          {:code => "colm", :station => "Colma"},
          {:code => "conc", :station => "Concord"},
          {:code => "daly", :station => "Daly City"},
          {:code => "dbrk", :station => "Downtown Berkeley"},
          {:code => "dubl", :station => "Dublin/Pleasanton"},
          {:code => "deln", :station => "El Cerrito del Norte"},
          {:code => "plza", :station => "El Cerrito Plaza"},
          {:code => "embr", :station => "Embarcadero (SF)"},
          {:code => "frmt", :station => "Fremont"},
          {:code => "ftvl", :station => "Fruitvale (Oakland)"},
          {:code => "glen", :station => "Glen Park (SF)"},
          {:code => "hayw", :station => "Hayward"},
          {:code => "lafy", :station => "Lafayette"},
          {:code => "lake", :station => "Lake Merritt (Oakland)"},
          {:code => "mcar", :station => "MacArthur (Oakland)"},
          {:code => "mlbr", :station => "Millbrae"},
          {:code => "mont", :station => "Montgomery St. (SF)"},
          {:code => "nbrk", :station => "North Berkeley"},
          {:code => "ncon", :station => "North Concord/Martinez"},
          {:code => "oakl", :station => "Oakland Int'l Airport"},
          {:code => "orin", :station => "Orinda"},
          {:code => "pitt", :station => "Pittsburg/Bay Point"},
          {:code => "phil", :station => "Pleasant Hill"},
          {:code => "powl", :station => "Powell St. (SF)"},
          {:code => "rich", :station => "Richmond"},
          {:code => "rock", :station => "Rockridge (Oakland)"},
          {:code => "sbrn", :station => "San Bruno"},
          {:code => "sfia", :station => "San Francisco Int'l Airport"},
          {:code => "sanl", :station => "San Leandro"},
          {:code => "shay", :station => "South Hayward"},
          {:code => "ssan", :station => "South San Francisco"},
          {:code => "ucty", :station => "Union City"},
          {:code => "warm", :station => "Warm Springs/South Fremont"},
          {:code => "wcrk", :station => "Walnut Creek"},
          {:code => "wdub", :station => "West Dublin"},
          {:code => "woak", :station => "West Oakland"}]

  def call
    welcome
    get_input
    process_request
    display
    goodbye
  end

  def welcome
    puts "Real Time BART.gov Train Departures\n"
    puts "Current time is #{Time.now}"
  end

  def get_input #returns valid BART station code; for complete list, go to http://api.bart.gov/docs/overview/abbrev.aspx
    valid_station = false
    while valid_station == false
      puts "\nEnter departure station code (e.g. \'woak\' for West Oakland) for real time departure information (type 'list' for codes):"
      station_req = gets.strip.downcase
      if input == "list"
        display_stations
      end
      if STATIONS.detect {|x| x[:code] == input} #validate response
        valid_station = true
      else
        puts "\n ALERT! Invalid station code -> try again"
      end
    end
    station_req
  end

  def process_request

  end


  def display

  end

  def goodbye

  end



  def display_stations
    STATIONS.each do |info|
      puts "#{info[:station]} (#{info[:code]})"
    end
  end



end
