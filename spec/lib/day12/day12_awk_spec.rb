# frozen_string_literal: true

require_relative '../../../lib/day12/day12_m'

RSpec.describe 'Day 12 AWK' do
  context 'when AWK' do
    let(:path) { 'lib/day12' }
    let(:awk) { `gawk -f #{path}/day12.awk #{described_class::FILE}`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: 25' do
      skip('Please implement Part 1')
    end

    it 'Part 2: 286' do
      skip('Please implement Part 2')
    end
  end
end
