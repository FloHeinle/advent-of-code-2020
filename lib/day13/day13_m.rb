# frozen_string_literal: true

class Day13M
  FILE = 'lib/day13/test_input'

  class << self
    def part1(file: FILE) # rubocop:disable Metrics/AbcSize
      departure = lines(file).first.to_i
      schedule = (lines(file).last.split(',') - ['x']).map(&:to_i)

      @buses_departing = {}

      schedule.each do |bus|
        @buses_departing[bus] = departure - (departure % bus) + bus
      end

      earliest_bus = @buses_departing.min_by { |_k, v| v }[0]
      waiting_time = @buses_departing[earliest_bus] - departure

      waiting_time * earliest_bus
    end

    def part2(file: FILE); end

    private

    def lines(file)
      File.read(file).lines.map(&:strip)
    end
  end
end
