# frozen_string_literal: true

Rails.application.routes.draw do
  get 'healthcheck', to: 'healthcheck#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  scope ':locale', # rubocop:todo Metrics/BlockLength
        locale: /#{I18n.available_locales.join('|')}/,
        defaults: { locale: I18n.locale } do
    resources :partners
    root to: 'better_together/pages#show', defaults: { path: 'home-page' }, as: :home_page
  end

  mount BetterTogether::Engine => '/'
end
