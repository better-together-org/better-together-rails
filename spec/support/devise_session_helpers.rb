# frozen_string_literal: true

module DeviseSessionHelpers
  include FactoryBot::Syntax::Methods
  include Rails.application.routes.url_helpers
  include BetterTogether::Engine.routes.url_helpers

  def login_as_platform_manager
    user = create(:nl_venues_user, :confirmed, :platform_manager)
    visit new_user_session_url(locale: I18n.locale)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    user
  end

  def configure_host_platform
    host_platform = create(:better_together_platform, :host, privacy: 'public')
    wizard = BetterTogether::Wizard.find_or_create_by(identifier: 'host_setup')
    wizard.mark_completed
    host_platform
  end
end
