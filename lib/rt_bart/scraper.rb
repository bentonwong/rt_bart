require "pry"
require "open-uri"
require "Nokogiri"

class Scraper

DEV_KEY = "MW9S-E7SL-26DU-VV8V"
ETD_API = "http://api.bart.gov/api/etd.aspx?cmd=etd&orig=#{station_code}&key=#{DEV_KEY}"
ADV_API = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&orig=#{station_code}&key=#{DEV_KEY}"
TC_API = "http://api.bart.gov/api/bsa.aspx?cmd=count&key=#{DEV_KEY}"


  def scrape_etd(station_code)

    doc = Nokogiri::HTML(open(ETD_API))
    binding.pry

  end

  def self.scrape_adv(station_code)
    doc = Nokogiri::HTML(open(ADV_API))
    binding.pry

  end

  def self.scrape_tc
    doc = Nokogiri::HTML(open(TC_API))
    binding.pry

  end

end

Scraper.new.scrape_bart_website("wdub")
#doc.css("station").css("etd").css("estimate").css("minutes").collect {|x| x.text} collects the eta

#doc.css("station").css("etd").css("abbreviation").collect {|x| x.text} <-collects the STATIONS
#doc.css("station").css("etd").css("estimate").css("length").collect {|x| x.text} collects the car length
