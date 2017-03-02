require "pry"
require "open-uri"

class Scraper

  def self.scrape_bart_website(bart_url)

    doc = Nokogiri::HTML(open(bart_url))
    binding.pry

  end

end

Scraper.scrape_bart_website.new(https://m.bart.gov/schedules/eta?stn=12th)
