require "pry"
require "open-uri"
require "Nokogiri"

class Scraper

  KEY = "ZKZB-PQE6-92VT-DWE9" #BART.gov API Developer Key required to access its APIs

  def self.scrape_api(suffix) #used by self.get_line_destinations & self.get_train_status
    api_url = "http://api.bart.gov/api/#{suffix}"
    doc = Nokogiri::HTML(open(api_url))
  end

  def self.get_line_destinations(station_code) #gets the real time updates
    suffix = "etd.aspx?cmd=etd&orig=#{station_code}&key=#{KEY}"
    doc = Scraper.scrape_api(uffix)
    doc.css("station etd").css("abbreviation").collect {|code| code.text}
  end
  
#------------------------------------------------------
  def self.get_train_status(station_code) #gets real time departure times
    suffix = "etd.aspx?cmd=etd&orig=#{station_code}&key=#{KEY}"
    doc = Scraper.scrape_api(suffix)
    doc.css('station etd').map do |values|
      {
        destination: values.css('destination').text,
        abbreviation: values.css('abbreviation').text,
        arrivals: reformat(values.css('estimate').map { |minute| minute.css('minutes').text.to_i }),
        cars: (values.css('estimate').map { |length| length.css('length').text.to_i })
      }
    end
  end

  def self.reformat(etd) #reformats the minutes data to show 'now' when it is 0
    etd.map do |time|
      time == 0 ? 'now' : "#{time}"
    end
  end

#------------------------------------------------------

  def self.get_station_info(station_code) #get station info as provided by BART
    suffix = "stn.aspx?cmd=stnaccess&orig=#{station_code}&l=1&key=#{KEY}"
    doc = Scraper.scrape_api(suffix)
    doc.css("//stations").text
  end

  def self.scrape_advisory(station_code) #gets system advisories; uses XML
    advisory_url = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&orig=#{station_code}&key=#{KEY}"
    doc = Nokogiri::XML(open(advisory_url))
    doc.search('description').children.find{|adv| adv.cdata?}.text
  end

  def self.scrape_train_count #gets the current count of the trains currently running in the system
    suffix = "bsa.aspx?cmd=count&key=#{KEY}"
    doc = Scraper.scrape_api(suffix)
    doc.css("traincount").text
  end

end
