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

      Scraper.add_description(self) unless description

      puts "#{'Summary'.blue}: #{description}"
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
      elem = e.css('td')

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
      if e.to_i.positive?
        get_from_atomic_number(e)
      else
        e.length < 3 ? get_from_symbol(e) : get_from_name(e)
      end
    end

    def self.display_all
      puts 'Here are all of the currently known elements in order of atomic number:'.yellow
      display_elements(all)
    end

    def self.display_by_group(group)
      puts "#{'Group'.blue}: #{group}"
      display_elements get_by_group group
    end

    def self.display_by_period(period)
      puts "#{'Period'.blue}: #{period}"
      display_elements get_by_period period
    end

    def self.display_by_weight
      puts 'Here are all of the elements sorted by Atomic Weight:'.yellow
      puts sort_by_weight.map { |e| "#{e.name.red} (#{e.properties.atomic_weight.round(4).to_s.blue})"}.join(', ')
    end

    def self.display_by_name
      puts 'Here are all of the elements sorted by name:'.yellow
      puts sort_by_name.map { |e| "#{e.name.red} (#{e.symbol.blue})"}.join(', ')
    end

    def self.display_elements(elems)
      map = elems.map do |e|
        num = e.atomic_number
        name = e.name.red
        "#{num.to_s.white}. #{name} (#{e.symbol.blue})#{(num % 7).zero? ? "\n" : ', '}"
      end

      puts map.uniq.join
    end

    def self.get_by_group(group)
      all.select { |e| e.properties.group == group }
    end

    def self.get_by_period(period)
      all.select { |e| e.properties.period == period }
    end

    def self.sort_by_name
      all.sort { |a, b| a.name <=> b.name }
    end

    def self.sort_by_weight
      all.sort { |a, b| a.properties.atomic_weight <=> b.properties.atomic_weight }
    end

  end

end
