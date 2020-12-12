# frozen_string_literal: true

require_relative '../../../lib/day12/day12_m'

RSpec.describe Day12M do
  context 'when Ruby' do
    it 'Part 1: INSERT_EXPECTATION_PART_1' do
      expect(described_class.part1).to eq(1319)
    end

    it 'Part 2: INSERT_EXPECTATION_PART_2' do
      skip('Please implement Part 2')
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day12' }
    let(:awk) { `gawk -f #{path}/day12.awk #{described_class::FILE}`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: INSERT_EXPECTATION_PART_1' do
      skip('Please implement Part 1')
    end

    it 'Part 2: INSERT_EXPECTATION_PART_2' do
      skip('Please implement Part 2')
    end
  end
end
