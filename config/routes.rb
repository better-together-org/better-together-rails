Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'better_together/static_pages#community_engine'
  mount BetterTogether::Engine => "/"
end
