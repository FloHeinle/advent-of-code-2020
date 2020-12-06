# frozen_string_literal: true

require_relative '../../../lib/day2/day2'

RSpec.describe Day2 do
  context 'when Ruby' do
    it 'Part 1: 2' do
      expect(described_class.part1).to eq(2)
    end

    it 'Part 2: 1' do
      expect(described_class.part2).to eq(1)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day2' }
    let(:awk) { `gawk -f #{path}/day2.awk #{described_class::FILE}`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: 2' do
      expect(awk[0]).to eq(2)
    end

    it 'Part 2: 1' do
      expect(awk[1]).to eq(1)
    end
  end
end
