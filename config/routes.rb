Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'better_together/static_pages#home'
  mount BetterTogether::Engine => "/"
end
