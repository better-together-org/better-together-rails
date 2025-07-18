# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Venue, type: :model do
  it 'is a valid venue' do
    venue = build(:venue)
    expect(venue).to be_valid
  end

  it 'must have a name of at least 3 characters' do
    venue = build(:venue, name: 'NL')
    expect(venue).not_to be_valid
  end
end
