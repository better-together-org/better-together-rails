# frozen_string_literal: true

module RequestSpecHelper
  include Rails.application.routes.url_helpers
  include BetterTogether::Engine.routes.url_helpers

  # Ensure route helpers use default locale
  def default_url_options
    { locale: I18n.default_locale }
  end

  def json
    JSON.parse(response.body)
  end

  def login(email, password)
    post better_together.user_session_path(locale: I18n.locale || I18n.default_locale), params: {
      user: { email: email, password: password }
    }
  end

  def configure_host_platform # rubocop:todo Metrics/MethodLength
    host_platform = BetterTogether::Platform.find_by(host: true) ||
                    BetterTogether::Platform.find_by(community_host: true) ||
                    create(:better_together_platform, :host, privacy: 'public')
    wizard = BetterTogether::Wizard.find_or_create_by(identifier: 'host_setup')
    wizard.mark_completed
    unless BetterTogether::User.exists?(email: 'manager@example.test')
      create(:user, :confirmed, :platform_manager,
             email: 'manager@example.test',
             password: 'xkcd4559!&@G')
    end
    host_platform
  end
end
