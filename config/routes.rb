# frozen_string_literal: true

Rails.application.routes.draw do
  get 'healthcheck', to: 'healthcheck#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  scope ':locale', # rubocop:todo Metrics/BlockLength
        locale: /#{I18n.available_locales.join('|')}/,
        defaults: { locale: I18n.locale } do
    resources :partners
    resources :resources do
      member do
        get :download
      end
    end
  end

  root to: redirect("/#{I18n.default_locale}")
  mount BetterTogether::Engine => '/'
end
