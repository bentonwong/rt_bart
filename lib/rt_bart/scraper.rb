require "pry"
require "open-uri"
require "Nokogiri"

class Scraper

KEY = "MW9S-E7SL-26DU-VV8V"

  def scrape_etd(station_code)

    edt_api = "http://api.bart.gov/api/etd.aspx?cmd=etd&orig=#{station_code}&key=#{KEY}"
    doc = Nokogiri::HTML(open(edt_api))
    #destination_array = doc.css("station").css("etd").css("abbreviation").each do |dest| dest.text
    #minutes_array = doc.css("station").css("etd").css("estimate").css("minutes").collect {|x| x.text}


    binding.pry
  end

  def self.scrape_adv(station_code)

    adv_api = "http://api.bart.gov/api/bsa.aspx?cmd=bsa&orig=#{station_code}&key=#{KEY}"

    doc = Nokogiri::HTML(open(adv_api))
    binding.pry
  end

  def self.scrape_tc

    tc_api = "http://api.bart.gov/api/bsa.aspx?cmd=count&key=#{KEY}"

    doc = Nokogiri::HTML(open(adv_api))
    binding.pry
  end

end

Scraper.new.scrape_etd("wdub")
#doc.css("station").css("etd").css("abbreviation").collect {|x| x.text} <-collects the STATIONS
#doc.css("station").css("etd").css("estimate").css("minutes").collect {|x| x.text} collects the eta
#doc.css("station").css("etd").css("estimate").css("length").collect {|x| x.text} collects the car length
