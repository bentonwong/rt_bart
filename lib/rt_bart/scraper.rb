require "pry"
require "open-uri"
require "Nokogiri"

class Scraper

KEY = "ZKZB-PQE6-92VT-DWE9" #BART.gov API Developer Key

  def self.scrape_api(station_code)
    edt_api = "http://api.bart.gov/api/etd.aspx?cmd=etd&orig=#{station_code}&key=#{KEY}"
    doc = Nokogiri::HTML(open(edt_api))
  end

  def self.get_line_destinations(station_code)
    doc = Scraper.scrape_api(station_code)
    doc.css("station etd").css("abbreviation").collect {|x| x.text}#doc.css("station").css("etd").css("abbreviation").collect {|x| x.text}
  end

  def self.get_rt_dept(station_code)
    #edt_api = #{}"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=#{station_code}&key=#{KEY}"
    #doc = Nokogiri::HTML(open(edt_api))
    doc = Scraper.scrape_api(station_code)
    output = doc.css('station etd').map do |etd|
      {
        destination: etd.css('destination').text,
        abbreviation: etd.css('abbreviation').text,
        arrivals: reformat(etd.css('estimate').map { |e| e.css('minutes').text.to_i }),
        cars: reformated(etd.css('estimate').map { |e| e.css('length').text.to_i })
      }
    end
    output
  end

  def self.reformatted(times)
     times.map do |time|
       time == 0 ? 'now' : "#{time}"
     end.join(', ')
  end

  def self.get_station_info(station)
    "Nothing here yet"
  end

  def self.scrape_advisory(station_code)
    adv_api = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&orig=#{station_code}&key=#{KEY}"
    doc = Nokogiri::XML(open(adv_api))
    advisories = doc.search('description').children.find{|e| e.cdata?}.text
  end

  def self.scrape_train_count
    tc_api = "http://api.bart.gov/api/bsa.aspx?cmd=count&key=#{KEY}"
    doc = Nokogiri::HTML(open(tc_api))
    count = doc.css("traincount").text
  end

end

#Scraper.new.get_minutes("woak")
