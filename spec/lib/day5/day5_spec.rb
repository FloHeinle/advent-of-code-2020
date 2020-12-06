# frozen_string_literal: true

require_relative '../../../lib/day5/day5'

RSpec.describe Day5 do
  context 'when Ruby' do
    it 'Part 1: 823' do
      expect(described_class.part1).to eq(823)
    end

    it 'Part 2: 821' do
      expect(described_class.part2).to eq(821)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day5' }
    let(:awk_part1) { `awk -f #{path}/day5.awk #{described_class::FILE} | grep 'part1'`.strip.split(':')[1].to_i }
    let(:awk_part2) do
      # rubocop:disable Layout/LineLength
      `awk -f #{path}/day5.awk #{described_class::FILE} | grep 'seatID=' | awk '{print $NF}' | sort -n | uniq | awk -f #{path}/day5_part2.awk`.strip.split(':')[1].to_i
      # rubocop:enable Layout/LineLength
    end

    it 'Part 1: 823' do
      expect(awk_part1).to eq(823)
    end

    it 'Part 2: 821' do
      expect(awk_part2).to eq(821)
    end
  end
end
