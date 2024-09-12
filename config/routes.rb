# frozen_string_literal: true

Rails.application.routes.draw do
  get 'healthcheck', to: 'healthcheck#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'better_together/pages#show', defaults: { path: 'home-page' }, as: :home_page

  scope ':locale', # rubocop:todo Metrics/BlockLength
        locale: /#{I18n.available_locales.join('|')}/,
        defaults: { locale: I18n.locale } do
    resources :partners
  end

  mount BetterTogether::Engine => '/'
end
