# frozen_string_literal: true

class Day6
  FILE = 'lib/day6/test_input'

  class << self
    def part1(file: FILE)
      answers = summed_answers_from(lines(file))
      answers.values.sum
    end

    def part2(file: FILE)
      answers = all_summed_answers_from(lines(file))

      summed_answers = 0
      answers.each_value do |val|
        summed_answers += val.size
      end

      summed_answers
    end

    private

    def all_summed_answers_from(lines, index = 0)
      lines.each_with_object({}) do |line, answers|
        line = line.chars.uniq

        if line.empty?
          index += 1
          next
        end

        answers[index] = answers[index] ? answers[index] & line : line
      end
    end

    def summed_answers_from(lines, index = 0)
      lines.each_with_object({}) do |line, answers|
        line = line.chars

        if line.empty?
          index += 1
          next
        end

        answers[index] = answers[index] ? answers[index] += line : line
      end.transform_values(&:uniq).transform_values(&:size)
    end

    def lines(file)
      File.read(file).lines.map(&:strip)
    end
  end
end
