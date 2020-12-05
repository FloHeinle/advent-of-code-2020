# frozen_string_literal: true

class Day3
  class << self
    def trees(step: 1, only_odd: false, file: 'lib/input')
      @lines = get_lines(file)
      @position = 0
      @trees = 0
      @multiplier = @lines.length

      calculate_trees(only_odd, step)
      @trees
    end

    def calculate_trees(only_odd, step)
      @lines.each_with_index do |_line, index|
        next if only_odd && index.even?

        next_line = @lines[index + 1]
        break unless next_line

        long_next_line = String.new
        @position += step

        @multiplier.times { long_next_line << next_line }

        @trees += 1 if long_next_line[@position] == '#'
      end
    end

    def get_lines(_file = 'lib/input')
      File.read('lib/day3/input').lines.map(&:strip)
    end
  end
end
