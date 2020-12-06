# frozen_string_literal: true

class Day1
  TARGET = 2020
  FILE = 'lib/day1/test_input'

  class << self
    def part1(file: FILE)
      @done = false
      @solution = 0

      determine_solution_part1(file)

      @solution
    end

    def part2(file: FILE)
      @done = false
      @solution = 0

      determine_solution_part2(file)

      @solution
    end

    private

    def determine_solution_part1(file)
      numbers = load_numbers(file)

      numbers.each_with_index do |number, index|
        left_nums = numbers - [numbers[index]]

        break unless left_nums.each do |left_num|
          next unless number + left_num == TARGET

          @solution = number * left_num
          @done = true
          break
        end
      end
    end

    def determine_solution_part2(file)
      numbers = load_numbers(file)

      numbers.each_with_index do |number, index|
        left_nums_first = numbers - [numbers[index]]

        left_nums_first.each_with_index do |left_num_first, index_first|
          left_nums_second = left_nums_first - [left_nums_first[index_first]]

          calculate_sum_of_three(number, left_num_first, left_nums_second)
        end

        break if @done
      end
    end

    def calculate_sum_of_three(number, left_num_first, left_nums_second)
      left_nums_second.each do |left_num_second|
        sum = number + left_num_first + left_num_second

        next unless sum == 2020

        @solution = number * left_num_first * left_num_second
        @done = true
        break
      end
    end

    def load_numbers(file)
      data = File.read(file)
      data.lines.map(&:to_i)
    end
  end
end
