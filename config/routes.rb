Rails.application.routes.draw do
  get '/profile', to: 'users#show', constraints: { subdomain: 'dashboard' }

  get 'users/index'

  delete 'teacher/remove_picture', to: 'teacher#remove_picture'

  devise_for :users, skip: 'registrations', controllers: { confirmations: 'confirmations', omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  
  get '/home', to: 'static#home'

  get '/about', to: 'static#about'

  get '/contact', to: 'static#contact'

  get '/get_started', to: 'static#get_started'

  devise_scope :user do
    post '/get_started', to: 'registrations#create'
    get '/users/edit', to: 'registrations#edit', constraints: { subdomain: 'dashboard' }
    patch '/users/edit', to: 'registrations#update', as: 'users_patch', constraints: { subdomain: 'dashboard' }
    put '/users/edit', to: 'registrations#update', as: 'users_put', constraints: { subdomain: 'dashboard' }
    delete '/users', to: 'registrations#destroy', constraints: { subdomain: 'dashboard' }
    post '/get_started/teacher', to: 'registrations#create_teacher'
    get '/get_started/teacher', to: 'registrations#new_teacher'
  end
  
  root 'static#home'
end
