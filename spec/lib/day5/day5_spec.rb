# frozen_string_literal: true

require_relative '../../../lib/day5/day5'

RSpec.describe Day5 do
  it 'Part 1: 930' do
    expect(described_class.highest_seat_id).to eq(930)
  end

  it 'Part 2: 515' do
    expect(described_class.get_my_seat_id).to eq(515)
  end
end
