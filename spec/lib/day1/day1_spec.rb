# frozen_string_literal: true

require_relative '../../../lib/day1/day1'

RSpec.describe Day1 do
  it 'Part 1: 935419' do
    expect(described_class.find_multiple_for_sum_of_two).to eq(935_419)
  end

  it 'Part 2: 49880012' do
    expect(described_class.find_multiple_for_sum_of_three).to eq(49_880_012)
  end
end
