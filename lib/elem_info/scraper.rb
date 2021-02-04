# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

module ElemInfo

  # Used for scraping element properties
  class Scraper

    def self.load_elements
      doc = self.get_page('https://en.wikipedia.org/wiki/List_of_chemical_elements')
      table = doc.css("table.wikitable tbody tr")

      # skip the header elements
      4.times { table.shift }

      # remove footer
      table.pop

      Element.all_from_table_doc(table)
    end

    def self.add_description(elem)
      doc = self.get_page("https://en.wikipedia.org/wiki/#{elem.name}")
      description = doc.css("table.infobox")[0].next_element.text.strip

      elem.description = description.gsub(/(\[*\d\])/, "")

      # possibly add values in which the elements properties are N/A
    end

    def self.get_page(url)
      Nokogiri::HTML(URI.open(url))
    end

  end
end
