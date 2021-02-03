# frozen_string_literal: true

module ElemInfo

  # Holds basic element information and has some class methods to find other useful information
  class Element
    attr_reader :name, :atomic_number, :atomic_weight, :symbol, :etymolygy, :group, :period, :melting_point,
    :boiling_point, :density, :heat_cap, :electro_negativity, :abundance

    @@all = []

    def initialize(name, symbol, etymolygy, atomic_number, atomic_weight, group, period,
                   density, melting_point, boiling_point, heat_cap, electro_negativity, abundance)
      @name = name
      @symbol = symbol
      @etymolygy = etymolygy
      @atomic_number = atomic_number
      @atomic_weight = atomic_weight
      @group = group
      @period = period
      @density = density
      @melting_point = melting_point
      @boiling_point = boiling_point
      @heat_cap = heat_cap
      @electro_negativity = electro_negativity
      @abundance = abundance
    end

    def save
      @@all << self
    end

    def display
      puts "#{name} - #{symbol} : #{etymolygy}"
      puts "Atomic Number: #{atomic_number}, Atomic Weight: #{atomic_weight} Da"
      puts "Density: #{density} (g / cm^3)"
      puts "Group: #{@group}, Period: #{period}"
      puts "Melting Point: #{melting_point} K,  Boiling Point: #{boiling_point} K"
      puts "Heat Capacity: #{heat_cap} (J / g * K), Electro-Negativity: #{electro_negativity}"
      puts "Abundance in Earth's Crust: #{abundance} (mg / kg)"
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
      etym = elem[3].text.strip
      group = elem[4].text.strip.to_i
      period = elem[5].text.strip.to_i
      atomic_w = fix_digit(elem[6])
      density = fix_digit(elem[7])
      melting = fix_digit(elem[8])
      boiling = fix_digit(elem[9])
      heat_cap = fix_digit(elem[10])
      elec_neg = fix_digit(elem[11])
      abundance = fix_digit(elem[12])

      new(name, symbol, etym, atomic_n, atomic_w, group, period, density, melting,
          boiling, heat_cap, elec_neg, abundance).save
    end

    def self.fix_digit(str)
      str = str.text.strip
      if str == "–"
        return "N/A"
      end

      str.tr("^0-9.", "").to_i
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
