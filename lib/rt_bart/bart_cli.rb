class RtBartCLI

  def call
    welcome
    get_station
    scrape
    display
  end

  def welcome
    puts "Real Time BART.gov Departures\n"
    puts "The current time is: " + Time.now
  end

  def station_codes
    station_codes = {12th=>"12th St. Oakland City Center",
16th=>"16th St. Mission (SF)",
19th=>"19th St. Oakland",
24th=>"24th St. Mission (SF)",
ashb=>"Ashby (Berkeley)",
balb=>"Balboa Park (SF)",
bayf=>"Bay Fair (San Leandro)",
cast=>"Castro Valley",
civc=>"Civic Center (SF)",
cols=>"Coliseum",
colm=>"Colma",
conc=>"Concord",
daly=>"Daly City",
dbrk=>"Downtown Berkeley",
dubl=>"Dublin/Pleasanton",
deln=>"El Cerrito del Norte",
plza=>"El Cerrito Plaza",
embr=>"Embarcadero (SF)",
frmt=>"Fremont",
ftvl=>"Fruitvale (Oakland)",
glen=>"Glen Park (SF)",
hayw=>"Hayward",
lafy=>"Lafayette",
lake=>"Lake Merritt (Oakland)",
mcar=>"MacArthur (Oakland)",
mlbr=>"Millbrae",
mont=>"Montgomery St. (SF)",
nbrk=>"North Berkeley",
ncon=>"North Concord/Martinez",
oakl=>"Oakland Int'l Airport",
orin=>"Orinda",
pitt=>"Pittsburg/Bay Point",
phil=>"Pleasant Hill",
powl=>"Powell St. (SF)",
rich=>"Richmond",
rock=>"Rockridge (Oakland)",
sbrn=>"San Bruno",
sfia=>"San Francisco Int'l Airport",
sanl=>"San Leandro",
shay=>"South Hayward",
ssan=>"South San Francisco",
ucty=>"Union City",
warm=>"Warm Springs/South Fremont",
wcrk=>"Walnut Creek",
wdub=>"West Dublin",
woak=>"West Oakland"}

  end

end
