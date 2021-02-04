# frozen_string_literal: true

require 'colorize'

module ElemInfo

  # Main CLI class for ElemInfo
  class CLI

    def initialize
      print_welcome
      load_all_elements
      start
    end

    def load_all_elements
      Scraper.load_elements
    end

    def display_all_elements
      Element.display_all
    end

    def start
      x = prompt('What would you like to do? (Sort, Inspect, Compound, Exit)').downcase

      execute_command(x)
    end

    def execute_command(input)
      i = input[0]
      if i == 'e'
        puts 'Goodbye!'.blue
      else
        case i
        when 's'
          prompt_to_sort
        when 'i'
          display_all_elements
          prompt_choose_element
        when 'c'
          display_all_elements
          prompt_to_create_compound
        else
          puts 'Invalid option!'.red
        end
        start
      end
    end

    def print_welcome
      puts 'Welcome to'.yellow + ' ElemInfo'.blue + ' ( Element Information )'.yellow
    end

    def prompt_to_sort
      x = prompt('How would you like to sort by? (Name, Group, Period, Weight)').downcase

      display_sort(x)
    end

    def display_sort(type)
      case type[0]
      when 'n'
        Element.display_by_name
      when 'g'
        prompt_sort_by_group
      when 'p'
        prompt_sort_by_period
      when 'w'
        Element.display_by_weight
      else
        prompt_to_sort
      end
    end

    def prompt_sort_by_group
      x = prompt('Please enter the number of the group to sort by:').to_i

      x < 1 || x > 18 ? prompt_sort_by_group : Element.display_by_group(x)
    end

    def prompt_sort_by_period
      x = prompt('Please enter the number of the group to sort by:').to_i

      x < 1 || x > 7 ? prompt_sort_by_group : Element.display_by_period(x)
    end

    def prompt_to_create_compound
      compound = Compound.new
      prompt_add_element_to_compound(compound)
    end

    def prompt_add_element_to_compound(compound)
      x = prompt('Please enter the name, symbol, or atomic number of the Element you would like to add to your compound:')
      found = Element.get_from_any(x)

      prompt_add_element_to_compound(compound) unless found

      prompt_amount_to_add(compound, found)

      x = prompt('Would you like to add another element? (Y / N)').downcase

      x[0] == 'y' ? prompt_add_element_to_compound(compound) : compound.calculate_and_display
    end

    def prompt_amount_to_add(compound, element)
      amt = prompt("How many #{element.name} atoms should we add to the compound?").to_i

      prompt_amount_to_add(compound, element) unless amt.positive?

      compound.add_element(element, amt)
    end

    def prompt_choose_element
      x = prompt('Please enter an element you would like to view more on: (Symbol, Name, or Atomic Number)')

      found = Element.get_from_any(x)
      prompt_choose_element unless found

      found.display
    end

    def prompt(question)
      puts ''
      puts question.yellow
      gets.chomp
    end

  end

end
