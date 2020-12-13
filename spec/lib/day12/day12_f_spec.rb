# frozen_string_literal: true

require_relative '../../../lib/day12/day12_f'

RSpec.describe Day12F do
  context 'when Ruby' do
    it 'Part 1: 25' do
      expect(described_class.part1).to eq(25)
    end

    it 'Part 2: 286' do
      expect(described_class.part2).to eq(286)
    end
  end
end
