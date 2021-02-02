# frozen_string_literal: true

require 'colorize'

module ElemInfo

  # Main CLI class for ElemInfo
  class CLI

    def initialize
      print_welcome
      load_all_elements
      display_all_elements
    end

    def load_all_elements
      Scraper.new.load_elements
    end

    def display_all_elements
      puts 'Here are all of the currently known elements sorted by atomic number:'.yellow
      map = Element.all.map do |e|
        num = e.atomic_number
        name = e.name.red
        "#{num.white}. #{name} (#{e.symbol.blue})#{(num.to_i % 7).zero? ? "\n" : ', '}"
      end
      puts map.uniq.join
    end

    def execute_command_from_input(input)
      # execute
    end

    def print_welcome
      puts 'Welcome to'.yellow + ' ElemInfo'.blue + ' ( Element Information )'.yellow
      puts "\n"
    end

    def prompt(question)
      puts ''
      puts question.yellow
      gets.chomp
    end

  end

end
