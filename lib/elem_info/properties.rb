# frozen_string_literal: true

module ElemInfo

  # Holds the basic properties of an element
  class Properties
    attr_accessor :atomic_weight, :etymology, :group, :period, :melting_point,
                  :boiling_point, :density, :heat_capacity, :electronegativity, :abundance
    def display
      puts "Etymology: #{etymology}"
      puts "Atomic Weight: #{atomic_weight} Da"
      puts "Density: #{density} (g / cm^3)"
      puts "Group: #{@group}, Period: #{period}"
      puts "Melting Point: #{melting_point} K,  Boiling Point: #{boiling_point} K"
      puts "Heat Capacity: #{heat_capacity} (J / g * K), Electro-Negativity: #{electronegativity}"
      puts "Abundance in Earth's Crust: #{abundance} (mg / kg)"
    end

    def self.from_row(elem)
      props = new

      props.etymology = elem[3].text.strip
      props.group = elem[4].text.strip.to_i
      props.period = elem[5].text.strip.to_i
      props.atomic_weight = fix_digit(elem[6])
      props.density = fix_digit(elem[7])
      props.melting_point = fix_digit(elem[8])
      props.boiling_point = fix_digit(elem[9])
      props.heat_capacity = fix_digit(elem[10])
      props.electronegativity = fix_digit(elem[11])
      props.abundance = fix_digit(elem[12])

      props
    end

    def self.fix_digit(str)
      str = str.text.strip
      if str == "–"
        return "N/A"
      end

      str.tr("^0-9.", "").to_i
    end

  end

end