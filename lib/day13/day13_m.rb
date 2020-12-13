# frozen_string_literal: true

class Day13M
  FILE = 'lib/day13/test_input'

  class << self
    def part1(file: FILE); end

    def part2(file: FILE); end

    private

    def lines(file)
      File.read(file).lines.map(&:strip)
    end
  end
end
