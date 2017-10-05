Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations', omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'static/home'

  get 'static/about'

  get 'static/contact'

  get '/get_started', to: 'static#get_started'

  root 'static#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end