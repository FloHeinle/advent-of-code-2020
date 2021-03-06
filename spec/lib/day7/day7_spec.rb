# frozen_string_literal: true

require_relative '../../../lib/day7/day7'

RSpec.describe Day7 do
  context 'when Ruby' do
    it 'Part 1: 4' do
      expect(described_class.part1).to eq(4)
    end

    it 'Part 2: 32' do
      expect(described_class.part2).to eq(32)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day7' }
    let(:awk) { `gawk -f #{path}/day7.awk #{described_class::FILE}`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: 4' do
      expect(awk[0]).to eq(4)
    end

    it 'Part 2: 32' do
      expect(awk[1]).to eq(32)
    end
  end
end
