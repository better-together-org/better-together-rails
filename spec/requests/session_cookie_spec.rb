# frozen_string_literal: true

require 'rails_helper'

# Every extra session cookie is repeated on every response. Two extra copies plus a large CSP pushed logged-in
# responses past nginx's default 4k proxy buffer, which Dokku turned into its generic 502 page.
RSpec.describe 'Session cookie', type: :request do
  it 'installs exactly one cookie-store session middleware' do
    stores = Rails.application.middleware.select { |m| m.klass.is_a?(Class) && m.klass <= ActionDispatch::Session::CookieStore }

    expect(stores.size).to eq(1)
  end

  it 'names the session cookie _better_together_session' do
    expect(Rails.application.config.session_options[:key]).to eq('_better_together_session')
  end

  it 'sets at most one session cookie on a public response' do
    get '/en'

    session_cookies = Array(response.headers['Set-Cookie']).flat_map { |h| h.to_s.split("\n") }
                                                           .grep(/\A_\w*session=/)

    expect(session_cookies.size).to be <= 1
  end
end
