# frozen_string_literal: true

require_relative '../../../lib/day6/day6'

RSpec.describe Day6 do
  it 'Part 1: 6633' do
    expect(described_class.answers_summed).to eq(6633)
  end

  it 'Part 2: 3202' do
    expect(described_class.all_answers_summed).to eq(3202)
  end
end
