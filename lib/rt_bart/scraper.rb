require "pry"
require "open-uri"
require "Nokogiri"

class Scraper

KEY = "MW9S-E7SL-26DU-VV8V"

  def self.scrape_api(station_code)
    edt_api = "http://api.bart.gov/api/etd.aspx?cmd=etd&orig=#{station_code}&key=#{KEY}"
    doc = Nokogiri::HTML(open(edt_api))
  end

  def self.get_line_destination(station_code)
    doc = scrape_api(station_code)
    doc.css("station").css("etd").css("abbreviation").collect {|x| x.text}
  end

  def self.get_minutes(station_code)
    doc = scrape_api(station_code)
    doc.css("station").css("etd").css("estimate").css("minutes").collect {|x| x.text}
  end

  def self.get_length(station_code)
    doc = scrape_api(station_code)
    doc.css("station").css("etd").css("estimate").css("length").collect {|x| x.text}
  end

  def self.scrape_adv(station_code)
    adv_api = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&orig=#{station_code}&key=#{KEY}"
    doc = Nokogiri::XML(open(adv_api))
    advisories = doc.search('description').children.find{|e| e.cdata?}.text
  end

  def self.scrape_tc
    tc_api = "http://api.bart.gov/api/bsa.aspx?cmd=count&key=#{KEY}"
    doc = Nokogiri::HTML(open(tc_api))
    count = doc.css("traincount").text
  end

end
