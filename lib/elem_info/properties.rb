# frozen_string_literal: true

module ElemInfo

  # Holds the basic properties of an element
  class Properties
    attr_accessor :atomic_weight, :etymology, :group, :period, :melting_point,
                  :boiling_point, :density, :heat_capacity, :electronegativity, :abundance

    def display
      puts "#{"Etymology".blue}: #{etymology.yellow}"
      puts "#{"Atomic Weight".blue}: #{atomic_weight.to_s.yellow} Da"
      puts "#{"Density".blue}: #{density.to_s.yellow} (g / cm^3)"
      puts "#{"Group".blue}: #{@group.to_s.yellow}"
      puts "#{"Period".blue}: #{period.to_s.yellow}"
      puts "#{"Melting Point".blue}: #{melting_point.to_s.yellow} K"
      puts "#{"Boiling Point".blue}: #{boiling_point.to_s.yellow} K"
      puts "#{"Heat Capacity".blue}: #{heat_capacity.to_s.yellow} (J / g * K)"
      puts "#{"Electronegativity".blue}: #{electronegativity.to_s.yellow}"
      puts "#{"Abundance in Earth's Crust".blue}: #{abundance.to_s.yellow} (mg / kg)"
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
      i = str.text.strip.tr('^0-9.', '').to_f
      i.positive? ? i : 'N/A'
    end

  end

end