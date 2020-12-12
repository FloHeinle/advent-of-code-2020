# frozen_string_literal: true

class Day12F
  FILE = 'lib/day12/test_input'

  class << self
    def part1(file: FILE) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity
      @position = { coords: { x: 0, y: 0 }, degrees: 0 }

      lines(file).each do |line| # rubocop:disable Metrics/BlockLength
        direction = line[0]
        value = line[1]

        case direction
        when 'E'
          @position[:coords][:x] += value
        when 'N'
          @position[:coords][:y] += value
        when 'W'
          @position[:coords][:x] -= value
        when 'S'
          @position[:coords][:y] -= value
        when 'L'
          @position[:degrees] = (@position[:degrees] + value) % 360
        when 'R'
          @position[:degrees] = (@position[:degrees] - value) % 360
        when 'F'
          case @position[:degrees]
          when 0
            @position[:coords][:x] += value
          when 90
            @position[:coords][:y] += value
          when 180
            @position[:coords][:x] -= value
          when 270
            @position[:coords][:y] -= value
          end
        end
      end

      @position[:coords][:x].abs + @position[:coords][:y].abs
    end

    def part2(file: FILE) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity
      @position = { coords: { x: 0, y: 0 }, degrees: 0 }
      waypoint = { coords: { x: 10, y: 1 } }

      lines(file).each do |line| # rubocop:disable Metrics/BlockLength
        direction = line[0]
        value = line[1]

        case direction
        when 'E'
          waypoint[:coords][:x] += value
        when 'N'
          waypoint[:coords][:y] += value
        when 'W'
          waypoint[:coords][:x] -= value
        when 'S'
          waypoint[:coords][:y] -= value
        when 'L', 'R'
          sign = direction == 'L' ? 1 : -1
          @position[:degrees] = (sign * value) % 360
          orig_x = waypoint[:coords][:x]
          orig_y = waypoint[:coords][:y]

          case @position[:degrees]
          when 90

            waypoint[:coords][:x] = orig_y * -1
            waypoint[:coords][:y] = orig_x
          when 180

            waypoint[:coords][:x] = orig_x * -1
            waypoint[:coords][:y] = orig_y * -1
          when 270

            waypoint[:coords][:x] = orig_y
            waypoint[:coords][:y] = orig_x * -1
          end
        when 'F'
          @position[:coords][:x] += value * waypoint[:coords][:x]
          @position[:coords][:y] += value * waypoint[:coords][:y]
        end
      end
      @position[:coords][:x].abs + @position[:coords][:y].abs
    end

    private

    def lines(file)
      File.read(file).lines.map { |line| [line[0], line[1..].strip.to_i] }
    end
  end
end
