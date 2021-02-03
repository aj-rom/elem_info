# frozen_string_literal: true
require 'pry'
require 'nokogiri'
require 'open-uri'

module ElemInfo

  # Used for scraping element properties
  class Scraper

    def initialize
      @doc = Nokogiri::HTML(URI.open('https://en.wikipedia.org/wiki/List_of_chemical_elements'))
      load_elements
    end

    def load_elements
      table = @doc.css("table.wikitable tbody tr")

      # skip the header elements
      4.times { table.shift }

      # remove footer
      table.pop

      Element.all_from_table_doc(table)
    end

  end
end
