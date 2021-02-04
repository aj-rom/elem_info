# frozen_string_literal: true

module ElemInfo

  # The Compound class for creating new chemical compounds
  class Compound
    attr_accessor :makeup
    attr_reader :elements

    @@all = []

    def initialize
      @elements = []
      @makeup = {}
    end

    def calculate_and_display
      calculate
      display
    end

    def name
      @elements.map { |e| "#{e.symbol}#{@makeup[e.symbol][:amount]}"}.join
    end

    def display
      puts "#{'Compound'.blue}: #{name.yellow}"
      puts "#{'Total Mass'.blue}: #{total_mass} Da"
      @elements.each do |e|
        sym = e.symbol
        puts " #{e.name.blue} (#{sym.blue}) "
        puts "  #{'Atoms'.blue}: #{get_num_atoms(sym)}"
        puts "  #{'Atomic Weight'.blue}: #{e.properties.atomic_weight} Da"
        puts "  #{'Percent Mass'.blue}: #{get_mass_percent_of(sym).round(4)}%"
      end
    end

    def total_mass
      @total_mass = 0.0
      @makeup.each do |sym, v|
        @total_mass += (v[:weight] * v[:amount]).to_f
      end

      @total_mass
    end

    def calculate
      t_mass = total_mass
      @makeup.each do |sym, v|
        mass = @makeup[sym][:mass]
        set_mass_percent_of(sym, (mass / t_mass) * 100)
      end

      t_mass
    end

    def get_num_atoms(sym)
      @makeup[sym][:amount]
    end

    def set_mass_percent_of(symbol, percent)
      @makeup[symbol][:mass_percent] = percent
    end

    def get_mass_percent_of(symbol)
      @makeup[symbol][:mass_percent]
    end

    def add_element(element, num)
      @makeup[element.symbol] ||= {}
      e = @makeup[element.symbol]
      e[:weight] = element.properties.atomic_weight
      e[:amount] = num
      e[:mass] = element.properties.atomic_weight * num

      @elements << element unless @elements.include?(element)
    end

    def save
      @@all << self
    end

    def self.all
      @@all
    end

  end

end
