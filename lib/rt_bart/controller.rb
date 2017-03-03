require_relative "../rt_bart/scraper.rb"
require_relative "../rt_bart/station.rb"
require_relative "../rt_bart/line.rb"
require 'nokogiri'
require 'pry'

class Controller

  attr_accessor :name, :advisories

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


  def welcome
    puts "\nReal Time BART.gov Train Departures"
    puts "\nCurrent time is #{Time.now}"
  end

  def display_stations
    STATIONS.each do |info|
      puts "#{info[:station]} (#{info[:code]})"
    end
  end

  def get_input #returns valid BART station code; for complete list, go to http://api.bart.gov/docs/overview/abbrev.aspx
    valid_station = false
    while valid_station == false
      puts "\nEnter departure station code (e.g. \'woak\' for West Oakland) for real time departure information (type 'list' for codes):"
      station = gets.strip.downcase
      if station == "list"
        display_stations
      end
      if STATIONS.detect {|x| x[:code] == station} #validate response
        valid_station = true
      else
        puts "\n ALERT! Invalid station code -> try again"
      end
    end
    station
  end

  def handle_request
    done = false
    while done == false
      station = get_input
      process_request(station)
      display_results(station)
      done = check_if_done
    end
  end

  def process_request(station)
    if !Station.all.detect {|station| station.name == station}
      Station.new(station)
      Station.call(station)
    else
      Station.call(station)
    end
  end

  def display_results(station)
    puts "\n#{station.upcase} departures as of #{Time.now}"

    #Displays results


    puts "\n*** Station Advisory ***\n"
    puts Scraper.scrape_adv(station)
    puts "\nThere are #{Scraper.scrape_train_count} trains running systemwide at this time."
  end

  def check_if_done
    input_validator = false

    while input_validator == false
      puts "\nCheck another station? \'y\'/\'n\' or \'i\' for above station information"
      check = gets.strip.downcase
      if check == 'y' || check == 'n' || check == 'i'
        input_validator = true
      else
        puts "\nALERT! Invalid response --> type \'y\' or \'n\'"
      end
    end

    if check == 'y'
      done = false
    elsif check == 'i'
      station.info
    else
      done = true
    end

    done
  end

  def goodbye
    puts "\nHave a safe and pleasant journey!"
  end

  def run
    welcome
    handle_request
    goodbye
  end


end
