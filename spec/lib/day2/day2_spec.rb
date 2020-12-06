# frozen_string_literal: true

require_relative '../../../lib/day2/day2'

RSpec.describe Day2 do
  context 'when Ruby' do
    it 'Part 1: 645' do
      expect(described_class.valid_passwords_old_policy).to eq(645)
    end

    it 'Part 2: 737' do
      expect(described_class.valid_passwords).to eq(737)
    end
  end

  context 'when AWK' do
    let(:path) { 'lib/day2' }
    let(:awk) { `gawk -f #{path}/day2.awk #{path}/input`.strip.split(/\n/).map(&:to_i) }

    it 'Part 1: 645' do
      expect(awk[0]).to eq(645)
    end

    it 'Part 2: 737' do
      expect(awk[1]).to eq(737)
    end
  end
end
