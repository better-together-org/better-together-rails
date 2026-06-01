# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BetterTogether error reporting' do
  let(:reporter) { BetterTogether.adapter_for(:error_reporting, :bts_local) }
  let(:logger) { instance_double(ActiveSupport::Logger, error: true) }

  before do
    allow(Rails).to receive(:logger).and_return(logger)
  end

  it 'registers the local BTS reporter at boot' do
    expect(reporter).to be_present
  end

  # rubocop:disable RSpec/ExampleLength
  it 'emits a structured CE exception event for the local observability stack' do
    payload = nil
    allow(logger).to receive(:error) { |value| payload = JSON.parse(value) }

    reporter.fetch(:adapter).call(
      StandardError.new("boom\nline 2"),
      context: {
        request_id: 'req-123',
        request_method: 'GET',
        path: '/en/posts/example',
        controller: 'posts',
        action: 'show',
        platform_id: 'platform-1',
        community_id: 'community-1',
        user_id: 'anonymous'
      }
    )

    expect(payload).to include(
      'event_type' => 'ce.exception',
      'severity' => 'error',
      'handled' => true,
      'app' => 'communityengine',
      'service_name' => 'communityengine.app',
      'environment' => 'test',
      'request_id' => 'req-123',
      'request_method' => 'GET',
      'path' => '/en/posts/example',
      'controller' => 'posts',
      'action' => 'show',
      'platform_id' => 'platform-1',
      'community_id' => 'community-1',
      'user_id' => 'anonymous',
      'exception_class' => 'StandardError',
      'exception_message' => 'boom line 2'
    )
  end
  # rubocop:enable RSpec/ExampleLength
end
