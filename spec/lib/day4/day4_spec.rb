# frozen_string_literal: true

require_relative '../../../lib/day4/day4'

RSpec.describe Day4 do
  it 'Part 1: 239' do
    expect(described_class.valid_passports).to eq(239)
  end

  it 'Part 2: 188' do
    expect(described_class.valid_passports(validate_attrs: true)).to eq(188)
  end
end
