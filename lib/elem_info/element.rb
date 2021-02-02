# frozen_string_literal: true

module ElemInfo

  # Holds basic element information and has some class methods to find other useful information
  class Element
    attr_accessor :name, :atomic_number, :atomic_weight, :symbol

    @@all = []

    def initialize(name, atomic_number, atomic_weight, symbol)
      @name = name
      @atomic_number = atomic_number
      @atomic_weight = atomic_weight
      @symbol = symbol
      @@all << self
    end

    def protons
      atomic_number
    end

    def self.all
      @@all
    end

    def self.all_from_table_doc(doc)
      doc.each do |e|
        from_table_element(e) unless e.attributes.length.zero?
      end
    end

    def self.from_table_element(e)
      an = e.css("b").text
      aw = e.css("data").text
      n = e.css("em").text
      s = e.css("abbr").text
      new(n, an, aw, s)
    end

    def self.get_from_name(name)
      all.detect { |e| e.name.casecmp?(name) }
    end

    def self.get_from_symbol(symbol)
      all.detect { |e| e.symbol.casecmp?(symbol) }
    end

    def self.get_from_atomic_number(num)
      all.detect { |e| e.atomic_number.casecmp?(num) }
    end

  end

end
