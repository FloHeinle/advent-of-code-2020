# frozen_string_literal: true

class Day13F
  FILE = 'lib/day13/test_input'

  class << self
    def part1(file: FILE)
      earliest_departure = lines(file)[0].to_i
      bus_ids = (lines(file)[1].split(',').uniq - ['x']).map(&:to_i).sort
      closest = closest_deps(bus_ids, earliest_departure).min_by { |_k, v| v }

      closest[0] * (closest[1] - earliest_departure)
    end

    def part2(file: FILE)
      busses = lines(file)[1].split(',').map(&:to_i).map.with_index { |id, i| [id, i] if id.positive? }.compact
      closest_time = 0
      index = 1

      busses.each do |id, offset|
        closest_time += index while (closest_time + offset) % id != 0

        index *= id
      end
      closest_time
    end

    private

    def closest_deps(bus_ids, earliest_departure)
      bus_ids.each_with_object({}) do |id, hash|
        index = 1
        x = id
        until x >= earliest_departure
          x = index * id
          index += 1
        end
        hash[id] = x
      end
    end

    def lines(file)
      File.read(file).lines.map(&:strip)
    end
  end
end
