# frozen_string_literal: true

require_relative '../../../lib/day13/day13_f'

RSpec.describe Day13F do
  context 'when Ruby' do
    it 'Part 1: 295' do
      expect(described_class.part1).to eq(295)
    end

    it 'Part 2: 1068781' do
      expect(described_class.part2).to eq(1_068_781)
    end
  end
end
