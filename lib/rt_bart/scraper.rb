require "pry"
require "open-uri"
require "Nokogiri"

class Scraper

KEY = "ZKZB-PQE6-92VT-DWE9" #BART.gov API Developer Key required to access its APIs

  def self.scrape_api(station_code) #used by self.get_line_destinations & self.get_train_status
    edt_api = "http://api.bart.gov/api/etd.aspx?cmd=etd&orig=#{station_code}&key=#{KEY}"
    doc = Nokogiri::HTML(open(edt_api))
  end

  def self.get_line_destinations(station_code) #gets the real time updates
    doc = Scraper.scrape_api(station_code)
    doc.css("station etd").css("abbreviation").collect {|x| x.text}
  end

  def self.get_train_status(station_code) #gets real time departure times
    doc = Scraper.scrape_api(station_code)
    output = doc.css('station etd').map do |etd|
      {
        destination: etd.css('destination').text,
        abbreviation: etd.css('abbreviation').text,
        arrivals: reformat(etd.css('estimate').map { |e| e.css('minutes').text.to_i }),
        cars: (etd.css('estimate').map { |e| e.css('length').text.to_i }).join(', ')
      }
    end
    output
  end

  def self.reformat(eta) #reformats the minutes data to show 'now' when it is 0
     eta.map do |time|
       time == 0 ? 'now' : "#{time}"
     end.join(', ')
  end

  def self.get_station_info(station_code) #get station info as provided by BART
    stnt_info_api = "http://api.bart.gov/api/stn.aspx?cmd=stnaccess&orig=#{station_code}&l=1&key=#{KEY}"
    doc = Nokogiri::HTML(open(stnt_info_api))
    output = doc.css("//stations").text
    output
  end

  def self.scrape_advisory(station_code) #gets system advisories
    adv_api = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&orig=#{station_code}&key=#{KEY}"
    doc = Nokogiri::XML(open(adv_api))
    advisories = doc.search('description').children.find{|e| e.cdata?}.text
  end

  def self.scrape_train_count #gets the current count of the trains currently running in the system
    tc_api = "http://api.bart.gov/api/bsa.aspx?cmd=count&key=#{KEY}"
    doc = Nokogiri::HTML(open(tc_api))
    count = doc.css("traincount").text
  end

end
