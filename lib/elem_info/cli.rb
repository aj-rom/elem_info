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
      Element.all.each_with_index { |e, i| puts `#{i + 1}`.white + e.name.blue }
    end

    def execute_command_from_input(input)
      # execute
    end

    def print_welcome
      puts 'Welcome to'.yellow + ' ElemInfo'.blue + ' ( Element Information )'.yellow
    end

    def prompt(question)
      puts ''
      puts question.yellow
      gets.chomp
    end

  end

end
