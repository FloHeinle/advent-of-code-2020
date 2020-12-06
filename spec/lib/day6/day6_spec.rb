# frozen_string_literal: true

require_relative '../../../lib/day6/day6'

RSpec.describe Day6 do
  context 'when Ruby' do
    it 'Part 1: 11' do
      expect(described_class.part1).to eq(11)
    end

    it 'Part 2: 6' do
      expect(described_class.part2).to eq(6)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day6' }
    let(:awk) { `gawk -f #{path}/day6.awk #{described_class::FILE}`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: 11' do
      expect(awk[0]).to eq(11)
    end

    it 'Part 2: 6' do
      expect(awk[1]).to eq(6)
    end
  end
end
