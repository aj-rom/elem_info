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
      @all
    end

    def self.all_from_ptable_doc(doc)
      doc.each { |e| from_ptable_element(e) }
    end

    def self.from_ptable_element(e)
      an = e.css("b").text
      aw = e.css("data").text
      n = e.css("em")
      s = e.css("abbr")
      new(n, an, aw, s)
    end

  end

end
