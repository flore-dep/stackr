require_relative "../../config/environment"
require 'feedjira'
require 'httparty'
require 'nokogiri'
require "open-uri"


url = "https://www.notion.com/releases/rss.xml"
xml = HTTParty.get(url).body
feed = Feedjira.parse(xml)

first = feed.entries.first
p first.title
p first.url
url2 = first.url
html = URI.open(url)
doc = Nokogiri::HTML.parse(html)
