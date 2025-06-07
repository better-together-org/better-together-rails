# frozen_string_literal: true

Rails.application.routes.draw do
  get 'healthcheck', to: 'healthcheck#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope ':locale',
        locale: /#{I18n.available_locales.join('|')}/ do
    authenticated :user do # rubocop:todo Lint/EmptyBlock
    end
  end

  root to: redirect("/#{I18n.default_locale}")
  mount BetterTogether::Engine => '/'
end
