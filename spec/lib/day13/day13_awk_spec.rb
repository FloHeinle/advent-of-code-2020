# frozen_string_literal: true

RSpec.describe 'Day13' do
  context 'when AWK' do
    let(:path) { 'lib/day13' }
    let(:awk) { `gawk -f #{path}/day13.awk #{described_class::FILE}`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: 295' do
      skip('Please implement Part 1')
    end

    it 'Part 2: INSERT_EXPECTATION_PART_2' do
      skip('Please implement Part 2')
    end
  end
end
