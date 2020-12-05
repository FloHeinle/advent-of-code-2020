# frozen_string_literal: true

class Day2
  class << self
    def valid_passwords
      valid_passwords = 0
      lines.each do |line|
        first, second = get_string_postions_from(line)
        char = line.scan(/\w:/).first.gsub(':', '')
        password = line.scan(/\w+/)[3]

        valid_passwords += 1 if (password[first] == char) ^ (password[second] == char)
      end
      valid_passwords
    end

    def valid_passwords_old_policy
      valid_passwords = 0
      lines.each do |line|
        range = line.scan(/^\d+-\d+/).first
        range = Range.new(*range.split('-').map(&:to_i))

        char = line.scan(/\w:/).first.gsub(':', '')

        password = line.scan(/\w+/)[3]

        amount = password.count(char)
        valid_passwords += 1 if range.include?(amount)
      end
      valid_passwords
    end

    private

    def file
      @file ||= read_file
    end

    def lines
      @lines ||= load_lines
    end

    def load_lines
      file.lines.map(&:strip)
    end

    def read_file
      File.read('lib/day2/input')
    end

    def get_string_postions_from(line)
      res = line.scan(/^\d+-\d+/).first
      res.split('-').map(&:to_i).map { |num| num - 1 }
    end
  end
end
