# frozen_string_literal: true

require 'rails_helper'

# The host app supplies what the Community Engine billing stack expects of it: encryption keys, the Pay
# gems, and billing that stays closed until a host switches it on and names itself.
RSpec.describe 'Billing host configuration' do # rubocop:disable RSpec/DescribeClass
  let(:ready_env) do
    { 'BT_BILLING_ENABLED' => 'true', 'PAY_BUSINESS_NAME' => 'Host', 'PAY_BUSINESS_ADDRESS' => '1 Main St',
      'PAY_SUPPORT_EMAIL' => 'help@example.test' }
  end

  it 'has Active Record encryption keys for the engine encrypted fields' do
    encryption = ActiveRecord::Encryption.config

    expect([encryption.primary_key, encryption.deterministic_key, encryption.key_derivation_salt]).to all(be_present)
  end

  it 'loads Pay' do
    expect(defined?(Pay)).to be_truthy
  end

  it 'loads receipts' do
    expect(defined?(Receipts)).to be_truthy
  end

  it 'stays off until the host switches it on' do
    expect(BetterTogether::Billing::Configuration.requested?({})).to be(false)
  end

  it 'names the identity keys a host must set' do
    expect(BetterTogether::Billing::Configuration.missing_keys({}))
      .to include('PAY_BUSINESS_NAME', 'PAY_BUSINESS_ADDRESS')
  end

  it 'is ready once the host sets its identity' do
    expect(BetterTogether::Billing::Configuration.ready?(ready_env)).to be(true)
  end
end
