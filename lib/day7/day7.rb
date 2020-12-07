# frozen_string_literal: true

require 'awesome_print'

class Day7
  FILE = 'lib/day7/test_input'
  COLOR = 'shiny gold'

  class << self
    def part1(file: FILE)
      lines = lines(file)
      hash = to_hash(lines)

      bags_for_color(hash, COLOR).uniq.size
    end

    def part2(file: FILE)
      lines = lines(file)
      hash = to_hash(lines)

      total_bags(hash, COLOR) - 1
    end

    private

    def total_bags(hash, color)
      total = 1

      hash[color].each do |child_bags|
        total += child_bags.values.first.to_i * total_bags(hash, child_bags.keys.first) if child_bags != {}
      end

      total
    end

    def bags_for_color(hash, color)
      output = []

      hash.each do |bag, child_bags|
        child_bags.reject(&:empty?).each do |child_bag|
          if child_bag.key?(color)
            output << bag
            output.concat bags_for_color(hash, bag)
          end
        end
      end

      output
    end

    def to_hash(lines)
      hash = {}
      lines.each do |line|
        bag = line.match(/(^\w+\s\w+)\sbags/)[1]
        inner_bags = line.split('contain')[1].split(',')
        hash[bag] = inner_bags.map do |inner_bag|
          parse_bag(inner_bag)
        end
      end
      hash
    end

    def parse_bag(bag)
      if bag.include?('no other bags')
        {}
      else
        { bag.strip.match(/(\w+\s\w+)\sbag/)[1] => bag.strip.match(/^\d+/)[0] }
      end
    end

    def lines(file)
      File.read(file).lines.map(&:strip)
    end
  end
end
