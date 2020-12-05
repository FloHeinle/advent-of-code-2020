# frozen_string_literal: true

require_relative '../../../lib/day2/day2'

RSpec.describe Day2 do
  it 'Part 1: 645' do
    expect(described_class.valid_passwords_old_policy).to eq(645)
  end

  it 'Part 2: 737' do
    expect(described_class.valid_passwords).to eq(737)
  end
end
