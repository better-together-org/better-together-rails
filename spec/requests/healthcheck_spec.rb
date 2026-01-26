# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Healthcheck', type: :request do
  include RequestSpecHelper

  before do
    configure_host_platform
  end

  describe 'GET /healthcheck' do
    # rubocop:todo RSpec/MultipleExpectations
    it 'returns ok JSON and 200' do # rubocop:todo RSpec/MultipleExpectations
      # rubocop:enable RSpec/MultipleExpectations
      get '/healthcheck'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to include('status' => 'ok')
    end
  end
end
