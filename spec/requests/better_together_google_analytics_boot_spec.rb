# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BetterTogether Google Analytics gem' do
  def with_gtag_id(value)
    original = ENV.fetch('GTAG_ID', nil)
    value.nil? ? ENV.delete('GTAG_ID') : ENV['GTAG_ID'] = value
    yield
  ensure
    original.nil? ? ENV.delete('GTAG_ID') : ENV['GTAG_ID'] = original
  end

  it 'loads with the host app' do
    expect(BetterTogether::GoogleAnalytics::VERSION).to be_present
  end

  it 'keeps the GTAG_ID environment value as the fallback when no platform is resolved' do
    with_gtag_id('G-TEST1234') do
      expect(BetterTogether::GoogleAnalytics::HeadTags.measurement_id(nil)).to eq('G-TEST1234')
    end
  end

  it 'ignores a malformed GTAG_ID' do
    with_gtag_id('not-an-id') do
      expect(BetterTogether::GoogleAnalytics::HeadTags.measurement_id(nil)).to be_nil
    end
  end
end
