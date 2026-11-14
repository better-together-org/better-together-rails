# frozen_string_literal: true

require 'rails_helper'
require Rails.root.join('config/initializers/storage_content_security_policy')

RSpec.describe HostStorageContentSecurityPolicy do
  describe '.storage_origin' do
    it 'uses the S3-compatible endpoint when one is configured' do
      expect(described_class.storage_origin('S3_ENDPOINT' => 'https://s3.btsdev.ca')).to eq('https://s3.btsdev.ca')
    end

    it 'falls back to the AWS bucket host' do
      env = { 'S3_BUCKET_NAME' => 'example-uploads', 'S3_REGION' => 'ca-central-1' }

      expect(described_class.storage_origin(env)).to eq('https://example-uploads.s3.ca-central-1.amazonaws.com')
    end

    it 'returns nothing without storage configuration' do
      expect(described_class.storage_origin({})).to be_nil
    end
  end

  describe '.register' do
    around do |example|
      registry = BetterTogether.registered_content_security_policy_sources
      original = registry.transform_values(&:dup)
      example.run
    ensure
      registry.clear
      original.each { |directive, sources| registry[directive].concat(sources) }
    end

    it 'registers the storage origin for images and direct uploads', :aggregate_failures do
      described_class.register('S3_ENDPOINT' => 'https://s3.btsdev.ca')

      registered = BetterTogether.registered_content_security_policy_sources
      expect(registered[:img_src]).to include('https://s3.btsdev.ca')
      expect(registered[:connect_src]).to include('https://s3.btsdev.ca')
    end

    it 'registers nothing without storage configuration' do
      BetterTogether.registered_content_security_policy_sources.clear

      described_class.register({})

      expect(BetterTogether.registered_content_security_policy_sources[:img_src]).to be_empty
    end
  end
end
