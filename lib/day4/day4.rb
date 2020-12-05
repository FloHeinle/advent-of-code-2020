# frozen_string_literal: true

class Day4
  KEYS = %w[byr iyr eyr hgt hcl ecl pid].freeze

  class << self
    def valid_passports(validate_attrs: false, file: 'lib/day4/input')
      lines = get_lines(file)
      passports = passports_from(lines)
      valid_passports = 0

      passports.each do |_keys, values|
        next if not_all_needed_keys_present?(values)

        next if validate_attrs && not_all_passport_attributes_valid?(values)

        valid_passports += 1
      end

      valid_passports
    end

    private

    def get_lines(file = 'lib/day4/ilnput')
      File.read(file).lines.map(&:strip)
    end

    def not_all_needed_keys_present?(values)
      !(KEYS - values.keys).empty?
    end

    def to_hash(line)
      line.split.each_with_object({}) do |item, hash|
        a, b = item.split(':')
        hash[a] = b
      end
    end

    def passports_from(lines)
      index = 0
      passports = {}

      lines.each do |line|
        index += 1 if line.empty?
        hash = to_hash(line)

        passports[index] ? passports[index].merge!(hash) : passports[index] = hash
      end
      passports
    end

    def not_all_passport_attributes_valid?(values)
      bool = byr_ok?(values) &&
             iyr_ok?(values) &&
             eyr_ok?(values) &&
             hgt_ok?(values) &&
             hcl_ok?(values) &&
             ecl_ok?(values) &&
             pid_ok?(values)
      !bool
    end

    def byr_ok?(values)
      values['byr'].to_i.between?(1920, 2002)
    end

    def iyr_ok?(values)
      values['iyr'].to_i.between?(2010, 2020)
    end

    def eyr_ok?(values)
      values['eyr'].to_i.between?(2020, 2030)
    end

    def hgt_ok?(values)
      value = values['hgt'].scan(/\d+/).first.to_i
      type = values['hgt'].scan(/\D+/).first

      type == 'cm' ? value.between?(150, 193) : value.between?(59, 76)
    end

    def hcl_ok?(values)
      values['hcl'].match("\#{1}[a-f0-9]{6}") ? true : false
    end

    def ecl_ok?(values)
      %w[amb blu brn gry grn hzl oth].include?(values['ecl'])
    end

    def pid_ok?(values)
      values['pid'].match('^\d{9}$') ? true : false
    end
  end
end
