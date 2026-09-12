# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BetterTogether telemetry boot wiring' do
  it 'keeps the OpenTelemetry initializer file in place for env-gated boot wiring' do
    expect(Rails.root.join('config/initializers/opentelemetry.rb')).to exist
  end

  it 'keeps the Pyroscope initializer file in place for env-gated boot wiring' do
    expect(Rails.root.join('config/initializers/pyroscope.rb')).to exist
  end
end
