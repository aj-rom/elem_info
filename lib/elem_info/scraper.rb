# frozen_string_literal: true
require 'pry'
require 'nokogiri'
require 'open-uri'

module ElemInfo

  # Used for scraping element properties from ptable.com
  class Scraper

    def initialize
      @doc = Nokogiri::HTML(URI.open('https://ptable.com/#'))
      load_elements
    end

    def load_elements
      Element.all_from_table_doc(@doc.css("ol li"))
    end

  end
end
