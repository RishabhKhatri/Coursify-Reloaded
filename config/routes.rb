Rails.application.routes.draw do

  #######################################################################################################################
  # User Routes                                                                                                         #
  #######################################################################################################################
  get '/profile', to: 'users#show', constraints: { subdomain: 'dashboard' }

  get '/institutes', to: 'users#manage_institutes', as: 'manage_institutes', constraints: { subdomain: /(^$|^www$)/ }

  devise_for :users, skip: 'registrations', controllers: { confirmations: 'confirmations', omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  devise_scope :user do
    post '/get_started', to: 'registrations#create'
    get '/users/edit', to: 'registrations#edit', constraints: { subdomain: 'dashboard' }
    patch '/users/edit', to: 'registrations#update', as: 'users_patch', constraints: { subdomain: 'dashboard' }
    put '/users/edit', to: 'registrations#update', as: 'users_put', constraints: { subdomain: 'dashboard' }
    delete '/users', to: 'registrations#destroy', constraints: { subdomain: 'dashboard' }
    post '/get_started/teacher', to: 'registrations#create_teacher'
    get '/get_started/teacher', to: 'registrations#new_teacher'
  end

  #######################################################################################################################
  # Institute Routes                                                                                                    #
  #######################################################################################################################

  match '/', to: 'institutes#show', as: 'show_institute', constraints: { subdomain: /.+/ }, via: :get
  match '/edit', to: 'institutes#edit', as: 'edit_institute', constraints: { subdomain: /.+/ }, via: :get
  match '/edit', to: 'institutes#update', as: 'update_institute', constraints: { subdomain: /.+/ }, via: [:put, :patch]

  scope '/institutes' do
    get '/create', to: 'institutes#new', as: 'new_institute'
    post '/create', to: 'institutes#create', as: 'create_institute'
  end

  #######################################################################################################################
  # Static Routes                                                                                                       #
  #######################################################################################################################

  get '/home', to: 'static#home'
  get '/about', to: 'static#about'
  get '/contact', to: 'static#contact'
  get '/get_started', to: 'static#get_started'

  #######################################################################################################################
  
  root 'static#home'
end
