# frozen_string_literal: true

class Day12M
  FILE = 'lib/day12/test_input'

  class << self
    def part1(file: FILE) # rubocop:disable Metrics/MethodLength
      @print_progress = false # verbose output of the progress
      @facing = 'east'
      @north  = 0
      @east   = 0
      @south  = 0
      @west   = 0

      lines(file).each do |instruction|
        move(instruction)
      end

      puts "\nPosition: #{position}"
      @manhattan_distance
    end

    def part2(file: FILE)
      puts file
    end

    private

    def lines(file)
      File.read(file).lines.map(&:strip)
    end

    def move(instruction) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity
      direction = instruction[0]
      units     = instruction[1..].to_i

      puts "Instruction: #{instruction}" if @print_progress

      case direction
      when 'F'
        instance_variable_set("@#{@facing}", instance_variable_get("@#{@facing}") + units)
      when 'N'
        @north += units
      when 'E'
        @east += units
      when 'S'
        @south += units
      when 'W'
        @west += units
      when 'L'
        @facing = { 'north' => %w[north west south east],
                    'east' => %w[east north west south],
                    'south' => %w[south east north west],
                    'west' => %w[west south east north] }[@facing][units / 90]
      when 'R'
        @facing = { 'north' => %w[north east south west],
                    'east' => %w[east south west north],
                    'south' => %w[south west north east],
                    'west' => %w[west north east south] }[@facing][units / 90]
      end

      puts "  Facing: #{@facing}, north: #{@north}, south: #{@south}, east: #{@east}, west: #{@west}" if @print_progress
    end

    def position # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      @manhattan_distance = (@east - @west).abs + (@north - @south).abs
      east_west = if (@east - @west).zero?
                    'east 0'
                  elsif (@east - @west).positive?
                    "east: #{@east}"
                  else
                    "west: #{(@east - @west).abs}"
                  end
      north_south = if (@north - @south).zero?
                      'north 0'
                    elsif (@north - @south).positive?
                      "north: #{@east}"
                    else
                      "south: #{(@north - @south).abs}"
                    end
      "#{east_west}, #{north_south} (Manhattan distance = #{@manhattan_distance})"
    end
  end
end
