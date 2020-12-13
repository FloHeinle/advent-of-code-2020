# frozen_string_literal: true

require 'thor'
require 'fileutils'

class Setup < Thor
  desc 'day NUMBER_OF_DAY', 'Sets up everything for a new Advent of Code puzzle.'
  option :f, type: :boolean, banner: 'Override existing files.'

  def day(num) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
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
    File.new("#{lib_path}/test_input", 'w')
    File.new("#{lib_path}/README.md", 'w')

    %w[m f].each do |dude|
      File.open("#{lib_path}/day#{num}_#{dude}.rb", 'w') do |f|
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

      File.open("#{spec_path}/day#{num}_#{dude}_spec.rb", 'w') do |f| # rubocop:disable Metrics/BlockLength
        f.puts '# frozen_string_literal: true'
        f.puts
        f.puts "require_relative '../../../lib/day#{num}/day#{num}_#{dude}'"
        f.puts
        f.puts "RSpec.describe Day#{num}#{dude.capitalize} do"
        f.puts "  context 'when Ruby' do"
        f.puts "    it 'Part 1: INSERT_EXPECTATION_PART_1' do"
        f.puts "      skip('Please implement Part 1')"
        f.puts '    end'
        f.puts
        f.puts "    it 'Part 2: INSERT_EXPECTATION_PART_2' do"
        f.puts "      skip('Please implement Part 2')"
        f.puts '    end'
        f.puts '  end'
        f.puts 'end'
      end
    end

    File.open("#{spec_path}/day#{num}_awk_spec.rb", 'w') do |f| # rubocop:disable Metrics/BlockLength
      f.puts '# frozen_string_literal: true'
      f.puts
      f.puts "RSpec.describe 'Day#{num}' do"
      f.puts "  context 'when AWK' do"
      f.puts "    let(:path) { 'lib/day#{num}' }"
      # rubocop:disable Style/StringConcatenation, Layout/LineLength
      f.puts "    let(:awk) { `gawk -f \#{path}/day#{num}.awk \#{described_class::FILE}`.strip.split(/" + '\n/).map(&:to_i) }'
      # rubocop:enable Style/StringConcatenation, Layout/LineLength
      f.puts ''
      f.puts "    it 'Part 1: INSERT_EXPECTATION_PART_1' do"
      f.puts "      skip('Please implement Part 1')"
      f.puts '    end'
      f.puts
      f.puts "    it 'Part 2: INSERT_EXPECTATION_PART_2' do"
      f.puts "      skip('Please implement Part 2')"
      f.puts '    end'
      f.puts '  end'
      f.puts 'end'
    end
  end
end

Setup.start(ARGV)
