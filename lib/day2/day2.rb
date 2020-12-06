# frozen_string_literal: true

class Day2
  FILE = 'lib/day2/test_input'

  class << self
    def part1(file: FILE)
      lines = load_lines(file)
      valid_passwords = 0

      lines.each do |line|
        range = line.scan(/^\d+-\d+/).first
        range = Range.new(*range.split('-').map(&:to_i))
        char = line.scan(/\w:/).first.gsub(':', '')
        password = line.scan(/\w+/)[3]

        valid_passwords += 1 if range.include?(password.count(char))
      end
      valid_passwords
    end

    def part2(file: FILE)
      lines = load_lines(file)
      valid_passwords = 0

      lines.each do |line|
        first, second = get_string_postions_from(line)
        char = line.scan(/\w:/).first.gsub(':', '')
        password = line.scan(/\w+/)[3]

        valid_passwords += 1 if (password[first] == char) ^ (password[second] == char)
      end
      valid_passwords
    end

    private

    def load_lines(file)
      data = File.read(file)
      data.lines.map(&:strip)
    end

    def get_string_postions_from(line)
      res = line.scan(/^\d+-\d+/).first
      res.split('-').map(&:to_i).map { |num| num - 1 }
    end
  end
end
