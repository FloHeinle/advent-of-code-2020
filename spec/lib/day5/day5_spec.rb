# frozen_string_literal: true

require_relative '../../../lib/day5/day5'

RSpec.describe Day5 do
  context 'when Ruby' do
    it 'Part 1: 930' do
      expect(described_class.highest_seat_id).to eq(930)
    end

    it 'Part 2: 515' do
      expect(described_class.get_my_seat_id).to eq(515)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day5' }
    let(:awk_part1) { `awk -f #{path}/day5.awk #{path}/input | grep 'part1'`.strip.split(':')[1].to_i }
    let(:awk_part2) do
      # rubocop:disable Layout/LineLength
      `awk -f #{path}/day5.awk #{path}/input | grep 'seatID=' | awk '{print $NF}' | sort -n | uniq | awk -f #{path}/day5_part2.awk`.strip.split(':')[1].to_i
      # rubocop:enable Layout/LineLength
    end

    it 'Part 1: 930' do
      expect(awk_part1).to eq(930)
    end

    it 'Part 2: 515' do
      expect(awk_part2).to eq(515)
    end
  end
end
