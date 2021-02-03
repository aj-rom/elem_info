# frozen_string_literal: true

require 'colorize'

module ElemInfo

  # Main CLI class for ElemInfo
  class CLI

    def initialize
      print_welcome
      load_all_elements
      display_all_elements
      prompt_to_create_compound
    end

    def load_all_elements
      Scraper.new.load_elements
    end

    def display_all_elements
      puts 'Here are all of the currently known elements sorted by atomic number:'.yellow
      map = Element.all.map do |e|
        num = e.atomic_number
        name = e.name.red
        "#{num.to_s.white}. #{name} (#{e.symbol.blue})#{(num % 7).zero? ? "\n" : ', '}"
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

    def prompt_to_create_compound
      compound = Compound.new
      prompt_add_element_to_compound(compound)
    end

    def prompt_add_element_to_compound(compound)
      x = prompt("Please enter the name, symbol, or atomic number of the Element you would like to add to your compound:")
      found = Element.get_from_any(x)

      unless found
        prompt_add_element_to_compound(compound)
      end

      prompt_amount_to_add(compound, found)

      x = prompt("Would you like to add another element? (Y / N)").downcase

      x.start_with?("y") ? prompt_add_element_to_compound(compound) : compound.calculate_and_display
    end

    def prompt_amount_to_add(compound, element)
      amt = prompt("How many #{element.name} atoms should we add to the compound?").to_i

      unless amt > 0
        prompt_amount_to_add(compound, element)
      end

      compound.add_element(element, amt)
    end

    def prompt_choose_element
      x = prompt("Please enter an element you would like to view more on: (Symbol, Name, or Atomic Number)")

      found = Element.get_from_any(x)

      if !found
        prompt_choose_element
      else
        found.display
        puts ""
      end

    end

    def prompt(question)
      puts ''
      puts question.yellow
      gets.chomp
    end

  end

end
