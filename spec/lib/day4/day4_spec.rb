# frozen_string_literal: true

require_relative '../../../lib/day4/day4'

RSpec.describe Day4 do
  context 'when Ruby' do
    it 'Part 1: 2' do
      expect(described_class.valid_passports).to eq(2)
    end

    it 'Part 2: 2' do
      expect(described_class.valid_passports(validate_attrs: true)).to eq(2)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day4' }
    let(:awk_part1) { `gawk -f #{path}/day4.awk -v PART_1=1 #{described_class::FILE}`.strip.to_i }
    let(:awk_part2) { `gawk -f #{path}/day4.awk -v PART_1=0 #{described_class::FILE}`.strip.to_i }

    it 'Part 1: 2' do
      expect(awk_part1).to eq(2)
    end

    it 'Part 2: 2' do
      expect(awk_part2).to eq(2)
    end
  end
end
