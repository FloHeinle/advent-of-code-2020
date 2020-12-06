# frozen_string_literal: true

require 'thor'
require 'fileutils'

class Setup < Thor
  desc 'day NUMBER_OF_DAY', 'Sets up everything for a new Advent of Code puzzle.'
  option :f, type: :boolean, banner: 'Override existing files.'

  def day(num) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    unless num.is_a?(Integer)
      puts 'Error: NUMBER_OF_DAY must be an Integer.'
      return
    end

    puts "Setting up new puzzle for Advent of Code Day: #{num}."

    lib_path = "lib/day#{num}"

    if Dir.exist?(lib_path) && !options[:f]
      puts 'Directory already exists'
      puts 'In case you want to override existing files use the "-f" option'
      return
    end

    spec_path = "spec/lib/day#{num}"

    FileUtils.mkdir_p(lib_path)
    FileUtils.mkdir_p(spec_path)

    File.open("#{lib_path}/day#{num}.rb", 'w') do |f|
      f.puts '# frozen_string_literal: true'
      f.puts
      f.puts "class Day#{num}"
      f.puts "  FILE = '#{lib_path}/test_input'"
      f.puts
      f.puts '  class << self'
      f.puts '    def part1(file: FILE)'
      f.puts '    end'
      f.puts
      f.puts '    def part2(file: FILE)'
      f.puts '    end'
      f.puts
      f.puts '    private'
      f.puts
      f.puts '    def lines(file)'
      f.puts '      File.read(file).lines.map(&:strip)'
      f.puts '    end'
      f.puts '  end'
      f.puts 'end'
    end

    File.new("#{lib_path}/test_input", 'w')
    File.new("#{lib_path}/README.md", 'w')

    File.open("#{spec_path}/day#{num}_spec.rb", 'w') do |f| # rubocop:disable Metrics/BlockLength
      f.puts '# frozen_string_literal: true'
      f.puts
      f.puts "require_relative '../../../lib/day#{num}/day#{num}'"
      f.puts
      f.puts "RSpec.describe Day#{num} do"
      f.puts "  context 'when Ruby' do"
      f.puts "    it 'Part 1: INSERT_EXPECTATION_HERE' do"
      f.puts "      skip('Please implement me')"
      f.puts '    end'
      f.puts
      f.puts "    it 'Part 2: INSERT_EXPECTATION_HERE' do"
      f.puts "      skip('Please implement me')"
      f.puts '    end'
      f.puts '  end'
      f.puts
      f.puts "  context 'when AWK' do"
      f.puts "    let(:path) { 'lib/day#{num}' }"
      # rubocop:disable Style/StringConcatenation, Layout/LineLength
      f.puts "    let(:awk) { `gawk -f \#{path}/day#{num}.awk \#{described_class::FILE}`.strip.split(/" + '\n/).map(&:to_i) }'
      # rubocop:enable Style/StringConcatenation, Layout/LineLength
      f.puts ''
      f.puts "    it 'Part 1: INSERT_EXPECTATION_HERE' do"
      f.puts "      skip('Please implement me')"
      f.puts '    end'
      f.puts
      f.puts "    it 'Part 2: INSERT_EXPECTATION_HERE' do"
      f.puts "      skip('Please implement me')"
      f.puts '    end'
      f.puts '  end'
      f.puts 'end'
    end
  end
end

Setup.start(ARGV)
