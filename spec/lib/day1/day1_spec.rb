# frozen_string_literal: true

require_relative '../../../lib/day1/day1'

RSpec.describe Day1 do
  context 'when Ruby' do
    it 'Part 1: 514579' do
      expect(described_class.part1).to eq(514_579)
    end

    it 'Part 2: 241861950' do
      expect(described_class.part2).to eq(241_861_950)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day1' }
    let(:awk) { `gawk -f #{path}/day1.awk #{described_class::FILE}`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: 514579' do
      expect(awk[0]).to eq(514_579)
    end

    it 'Part 2: 241861950' do
      expect(awk[1]).to eq(241_861_950)
    end
  end
end
