# frozen_string_literal: true

require_relative '../../../lib/day3/day3'

RSpec.describe Day3 do
  context 'when Ruby' do
    let(:a) { described_class.trees }
    let(:b) { described_class.trees(step: 3) }
    let(:c) { described_class.trees(step: 5) }
    let(:d) { described_class.trees(step: 7) }
    let(:e) { described_class.trees(only_odd: true) }

    def sum
      a * b * c * d * e
    end

    it 'Part 1: 230' do
      expect(b).to eq(230)
    end

    it 'Part 2: 9533698720' do
      expect(sum).to eq(9_533_698_720)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day3' }
    let(:awk) { `gawk -f #{path}/day3.awk #{path}/input`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: 230' do
      expect(awk[0]).to eq(230)
    end

    it 'Part 2: 9533698720' do
      expect(awk[1]).to eq(9_533_698_720)
    end
  end
end
