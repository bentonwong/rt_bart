require_relative "../rt_bart/scraper.rb"
require_relative "../rt_bart/station.rb"
require 'nokogiri'
require 'pry'

class Controller

  attr_accessor :name, :advisories, :station_instance

  STATIONS = [{:code => "12th", :station => "12th St. Oakland City Center"},
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

  def display_stations #displays stations and codes upon request by user
    STATIONS.each do |info|
      puts "#{info[:station]} (#{info[:code]})"
    end
  end

#--------------------------------------------------------

  def run #entry point into the controller from the bin file
    welcome
    handle_request
    goodbye
  end

#--------------------------------------------------------

  def welcome #provides a nice welcome message with the current time.
    puts "\nReal Time BART.gov Train Departures"
    puts "\nCurrent time is #{Time.now}"
  end

  def get_input #returns valid BART station code; for complete list, go to http://api.bart.gov/docs/overview/abbrev.aspx
    if !Station.all.empty?
      print "\n(Recent searches: #{Station.all.collect {|stn| stn.name}})\n"
    end

    valid_station = false #sets the flag for the loop below

    while valid_station == false #checks to make sure the user is entering a valid station
      puts "\nEnter departure station code (e.g. \'woak\' for West Oakland) for real time departure information (type 'list' for codes):"
      station = gets.strip.downcase
        if station == "list"
          display_stations
        elsif STATIONS.detect {|stn| stn[:code] == station} #validates response using chart above
          valid_station = true
        else
          puts "\n ALERT! Invalid station code -> try again"
        end
    end

    station #returns the station value
  end

#-----------------------------------------------------------
  def handle_request #controls the fulfillment of the query; because the fulfillment process is complex, this method was written to simplify and better manage the calls to the various processes.
    done = false
    while done == false
      station = get_input
      process_request(station)
      display_results(station)
      done = check_if_done
    end
  end
#--------------------------------------------------------

  def process_request(station) #determines if the station request already has an instance; if it does, it does not create another one. regardless of the outcome, a call is made to the station class to get updates from the BART api
    if !Station.all.detect {|instance| instance.instance_variable_get("@name") == station}
      @station_instance = Station.new(station) #creates a new station instance if it does not already exist in the Station.all
    else
      @station_instance = Station.all.detect {|instance| instance.instance_variable_get("@name") == station}
    end
      station_instance.call(station)
  end

#----------------------------------------------------------------------

  def display_results(station) #displays real time station data returned from the station instance
    puts "\n#{station.upcase} departures as of #{Time.now}\n"
    converter(station_instance.status)
    puts "\n*** Station Advisory ***\n"
    puts station_instance.advisories
    puts "\nThere are #{Scraper.scrape_train_count} trains running systemwide at this time.\n"
    puts ""
    puts "Data provided by BART.gov. Real time train departure data available at https://www.bart.gov/schedules/eta."
  end

  def converter(status_data) #converts the status data into a more user friendly, easier to read format
    status_data.each do |values|
      puts ">>Destination: #{values[:destination]} (#{values[:abbreviation]})" #displays destination info
      combined_array = values[:arrivals].zip(values[:cars]) #combines the arrivals and cars arrays so they can be displayed together below
      combined_array.each do |data|
        puts "#{data[0]} min (#{data[1]} cars)" #displays the arrivals and cars information
      end
    end
  end

  def check_if_done #checks if the user is done with this session and checks for valid responses
    input_check = false
    while input_check == false
      puts "\nCheck another station? [\'y\'/\'n\' or \'i\' for above station information]"
      check = gets.strip.downcase

      if ['y', 'n'].include?(check)
        input_check = true
      elsif check == 'i'
        puts "\n#{station_instance.info}"
      else
        puts "\nALERT! Invalid response --> type \'y\'/\'n\' or \'i\'"
      end

    end

    if check == 'y'
      done = false
    else
      done = true
    end

  end

#----------------------------------------------------------------------

  def goodbye #prints search history for the session and leaves user with pleasant wishes

    if !Station.all.empty?
      print "\n(Search history for this session: #{Station.all.collect {|x| x.name}})\n"
    end

    puts "\nHave a safe and pleasant journey!\n"
  end

#-----------------------------------------------------------------------

end
