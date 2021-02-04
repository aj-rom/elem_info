# frozen_string_literal: true

module ElemInfo

  # Holds basic element information and has some class methods to find other useful information
  class Element
    attr_reader :name, :atomic_number, :symbol, :properties
    attr_accessor :description

    @@all = []

    def initialize(name, symbol, atomic_number, properties)
      @name = name
      @symbol = symbol
      @atomic_number = atomic_number
      @properties = properties
    end

    def save
      @@all << self
    end

    def display
      puts "#{name.blue} ( #{symbol.yellow} )"
      properties.display

      unless description
        Scraper.add_description(self)
      end

      puts "#{"Summary".blue}: #{description}"
    end

    def protons
      atomic_number
    end

    def self.all
      @@all
    end

    def self.all_from_table_doc(doc)
      doc.each do |e|
        from_table_element(e) unless e.children.length <= 1
      end
    end

    def self.from_table_element(e)
      elem = e.css("td")

      atomic_n = elem[0].text.strip.to_i
      symbol = elem[1].text.strip
      name = elem[2].text.strip
      props = Properties.from_row(elem)
      new(name, symbol, atomic_n, props).save
    end

    def self.get_from_name(name)
      all.detect { |e| e.name.casecmp?(name) }
    end

    def self.get_from_symbol(symbol)
      all.detect { |e| e.symbol.casecmp?(symbol) }
    end

    def self.get_from_atomic_number(num)
      all.detect { |e| e.atomic_number == num.to_i }
    end

    def self.get_from_any(e)
      if e.to_i > 0
        get_from_atomic_number(e)
      else
        e.length < 3 ? get_from_symbol(e) : get_from_name(name)
      end
    end

  end

end
