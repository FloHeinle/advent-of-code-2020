# frozen_string_literal: true

class Day12M # rubocop:disable Metrics/ClassLength
  FILE = 'lib/day12/test_input'

  @print_progress = false # verbose output of the progress

  @facing = 'east'
  @north  = 0
  @east   = 0
  @south  = 0
  @west   = 0

  @waypoint_navigation = false
  @waypoint_north = 1
  @waypoint_east  = 10
  @waypoint_south = 0
  @waypoint_west  = 0

  class << self
    def part1(file: FILE)
      print_position if @print_progress

      lines(file).each do |instruction|
        move(instruction)
        print_position if @print_progress
      end

      manhattan_distance
    end

    def part2(file: FILE)
      @waypoint_navigation = true

      reset_ships_position

      print_position if @print_progress

      lines(file).each do |instruction|
        move(instruction)
        print_position if @print_progress
      end

      manhattan_distance
    end

    private

    def lines(file)
      File.read(file).lines.map(&:strip)
    end

    def move(instruction) # rubocop:disable Metrics/MethodLength,Metrics/CyclomaticComplexity
      puts "Instruction: #{instruction}" if @print_progress

      direction = instruction[0]
      units     = instruction[1..].to_i

      case direction
      when 'F'
        forward(units)
      when 'N'
        north(units)
      when 'E'
        east(units)
      when 'S'
        south(units)
      when 'W'
        west(units)
      when 'L'
        turn_left(units)
      when 'R'
        turn_right(units)
      end
    end

    def print_position
      puts "Facing: #{@facing}, Position: #{horizontal_position(:ship)}, #{vertical_position(:ship)} (Manhattan distance = #{manhattan_distance})" # rubocop:disable Layout/LineLength
      puts "Waypoint: #{horizontal_position(:waypoint)}, #{vertical_position(:waypoint)}" if @waypoint_navigation
    end

    def manhattan_distance
      horizontal_position(:ship).split[1].to_i + vertical_position(:ship).split[1].to_i
    end

    def horizontal_position(subject)
      east_var = subject == :waypoint ? '@waypoint_east' : '@east'
      west_var = subject == :waypoint ? '@waypoint_west' : '@west'
      horizontal = instance_variable_get(east_var) - instance_variable_get(west_var)
      if horizontal.zero?
        'east 0'
      elsif horizontal.positive?
        "east #{horizontal}"
      else
        "west #{horizontal.abs}"
      end
    end

    def vertical_position(subject)
      north_var = subject == :waypoint ? '@waypoint_north' : '@north'
      south_var = subject == :waypoint ? '@waypoint_south' : '@south'
      horizontal = instance_variable_get(north_var) - instance_variable_get(south_var)
      if horizontal.zero?
        'north 0'
      elsif horizontal.positive?
        "north #{horizontal}"
      else
        "south #{horizontal.abs}"
      end
    end

    %i[north east south west].each do |direction|
      define_method(direction) do |units|
        dir = @waypoint_navigation ? "waypoint_#{direction}" : direction
        instance_variable_set("@#{dir}", instance_variable_get("@#{dir}") + units)
      end
    end

    def forward(units) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      if @waypoint_navigation
        horizontal_var = horizontal_position(:waypoint).split[0]
        horizontal_units = horizontal_position(:waypoint).split[1].to_i
        vertical_var = vertical_position(:waypoint).split[0]
        vertical_units = vertical_position(:waypoint).split[1].to_i

        instance_variable_set("@#{horizontal_var}",
                              instance_variable_get("@#{horizontal_var}") + horizontal_units * units)
        instance_variable_set("@#{vertical_var}",
                              instance_variable_get("@#{vertical_var}") + vertical_units * units)
      else
        instance_variable_set("@#{@facing}", instance_variable_get("@#{@facing}") + units)
      end
    end

    def turn_left(units) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      if @waypoint_navigation
        horizontal_var = horizontal_position(:waypoint).split[0]
        horizontal_units = horizontal_position(:waypoint).split[1].to_i
        vertical_var = vertical_position(:waypoint).split[0]
        vertical_units = vertical_position(:waypoint).split[1].to_i

        horizontal_rotation = { 'east' => %w[east north west south],
                                'west' => %w[west south east north] }[waypoint_east_west.split[0]][units / 90]
        vertical_rotation = { 'north' => %w[north west south east],
                              'south' => %w[south east north west] }[waypoint_north_south.split[0]][units / 90]

        instance_variable_set("@waypoint_#{horizontal_var}",
                              instance_variable_get("@waypoint_#{horizontal_var}") - horizontal_units)
        instance_variable_set("@waypoint_#{vertical_var}",
                              instance_variable_get("@waypoint_#{vertical_var}") - vertical_units)
        instance_variable_set("@waypoint_#{horizontal_rotation}",
                              instance_variable_get("@waypoint_#{horizontal_rotation}") + horizontal_units)
        instance_variable_set("@waypoint_#{vertical_rotation}",
                              instance_variable_get("@waypoint_#{vertical_rotation}") + vertical_units)
      else
        @facing = { 'north' => %w[north west south east],
                    'east' => %w[east north west south],
                    'south' => %w[south east north west],
                    'west' => %w[west south east north] }[@facing][units / 90]
      end
    end

    def turn_right(units) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      if @waypoint_navigation
        horizontal_var = horizontal_position(:waypoint).split[0]
        horizontal_units = horizontal_position(:waypoint).split[1].to_i
        vertical_var = vertical_position(:waypoint).split[0]
        vertical_units = vertical_position(:waypoint).split[1].to_i

        horizontal_rotation = { 'east' => %w[east south west north],
                                'west' => %w[west north east south] }[horizontal_var][units / 90]
        vertical_rotation = { 'north' => %w[north east south west],
                              'south' => %w[south west north east] }[vertical_var][units / 90]

        instance_variable_set("@waypoint_#{horizontal_var}",
                              instance_variable_get("@waypoint_#{horizontal_var}") - horizontal_units)
        instance_variable_set("@waypoint_#{vertical_var}",
                              instance_variable_get("@waypoint_#{vertical_var}") - vertical_units)
        instance_variable_set("@waypoint_#{horizontal_rotation}",
                              instance_variable_get("@waypoint_#{horizontal_rotation}") + horizontal_units)
        instance_variable_set("@waypoint_#{vertical_rotation}",
                              instance_variable_get("@waypoint_#{vertical_rotation}") + vertical_units)
      else
        @facing = { 'north' => %w[north east south west],
                    'east' => %w[east south west north],
                    'south' => %w[south west north east],
                    'west' => %w[west north east south] }[@facing][units / 90]
      end
    end

    def reset_ships_position
      @facing = 'east'
      @north  = 0
      @east   = 0
      @south  = 0
      @west   = 0
    end
  end
end
