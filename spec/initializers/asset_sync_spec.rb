require 'spec_helper'
require 'active_model'

unless Object.const_defined?(:AssetSync)
  Object.const_set(:AssetSync, Module.new do
    def self.configure; end
  end)
end

class AssetSyncInitializerConfig
  attr_accessor :fog_provider, :run_on_precompile, :aws_access_key_id,
                :aws_secret_access_key, :aws_session_token, :aws_iam_roles,
                :fog_directory, :fog_region, :fog_host, :fog_options,
                :fog_scheme, :cdn_distribution_id, :fail_silently,
                :log_silently, :concurrent_uploads
end

RSpec.describe AssetSync do
  subject(:apply_initializer) { load File.expand_path('../../config/initializers/asset_sync.rb', __dir__) }

  let(:config) { AssetSyncInitializerConfig.new }

  around do |example|
    original_env = ENV.to_hash.slice(
      'ASSET_SYNC_ENABLED',
      'SKIP_ASSET_SYNC',
      'AWS_ACCESS_KEY_ID',
      'AWS_SECRET_ACCESS_KEY',
      'AWS_SESSION_TOKEN',
      'AWS_IAM_ROLES',
      'FOG_DIRECTORY',
      'FOG_REGION',
      'ASSET_SYNC_ENDPOINT',
      'CDN_DISTRIBUTION_ID'
    )

    %w[
      ASSET_SYNC_ENABLED
      SKIP_ASSET_SYNC
      AWS_ACCESS_KEY_ID
      AWS_SECRET_ACCESS_KEY
      AWS_SESSION_TOKEN
      AWS_IAM_ROLES
      FOG_DIRECTORY
      FOG_REGION
      ASSET_SYNC_ENDPOINT
      CDN_DISTRIBUTION_ID
    ].each { |key| ENV.delete(key) }

    example.run
  ensure
    %w[
      ASSET_SYNC_ENABLED
      SKIP_ASSET_SYNC
      AWS_ACCESS_KEY_ID
      AWS_SECRET_ACCESS_KEY
      AWS_SESSION_TOKEN
      AWS_IAM_ROLES
      FOG_DIRECTORY
      FOG_REGION
      ASSET_SYNC_ENDPOINT
      CDN_DISTRIBUTION_ID
    ].each { |key| ENV.delete(key) }
    original_env.each { |key, value| ENV[key] = value }
  end

  before do
    allow(described_class).to receive(:configure).and_yield(config)
  end

  it 'runs asset sync on precompile by default' do
    apply_initializer

    expect(config.run_on_precompile).to be(true)
  end

  it 'uses ASSET_SYNC_ENABLED when provided' do
    ENV['ASSET_SYNC_ENABLED'] = 'true'

    apply_initializer

    expect(config.run_on_precompile).to be(true)
  end

  it 'allows ASSET_SYNC_ENABLED to disable publication explicitly' do
    ENV['ASSET_SYNC_ENABLED'] = 'false'

    apply_initializer

    expect(config.run_on_precompile).to be(false)
  end

  it 'allows SKIP_ASSET_SYNC to disable publication explicitly' do
    ENV['SKIP_ASSET_SYNC'] = 'true'

    apply_initializer

    expect(config.run_on_precompile).to be(false)
  end

  it 'sets the configured S3-compatible endpoint as the fog host' do
    ENV['ASSET_SYNC_ENDPOINT'] = 'https://garage.internal'

    apply_initializer

    expect(config.fog_host).to eq('https://garage.internal')
  end

  it 'uses path-style requests for non-AWS S3-compatible endpoints' do
    ENV['ASSET_SYNC_ENDPOINT'] = 'https://garage.internal'

    apply_initializer

    expect(config.fog_options).to eq(path_style: true)
  end
end
