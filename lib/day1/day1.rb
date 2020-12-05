# frozen_string_literal: true

class Day1
  TARGET = 2020

  class << self
    def find_multiple_for_sum_of_two
      @done = false
      @solution = 0

      determine_solution_part1

      @solution
    end

    def find_multiple_for_sum_of_three
      @done = false
      @solution = 0

      determine_solution_part2

      @solution
    end

    private

    def determine_solution_part1
      numbers.each_with_index do |number, index|
        left_nums = numbers - [numbers[index]]

        left_nums.each do |left_num|
          next unless number + left_num == TARGET

          @solution = number * left_num
          @done = true
          break
        end

        break if @done
      end
    end

    def determine_solution_part2
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

    def numbers
      @numbers ||= load_numbers
    end

    def load_numbers
      file = File.read('lib/day1/input')
      file.lines.map(&:to_i)
    end
  end
end
