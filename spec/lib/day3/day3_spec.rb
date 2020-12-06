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

    it 'Part 1: 7' do
      expect(b).to eq(7)
    end

    it 'Part 2: 336' do
      expect(sum).to eq(336)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day3' }
    let(:awk) { `gawk -f #{path}/day3.awk #{described_class::FILE}`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: 7' do
      expect(awk[0]).to eq(7)
    end

    it 'Part 2: 336' do
      expect(awk[1]).to eq(336)
    end
  end
end
