Rails.application.routes.draw do

  resources :players
  # resources :articles
  resources :profile
  resources :teams
  resources :media
  resources :user
  resources :user_players
  resources :user_teams
  # resources :user_articles  

  get 'auth', to: 'auth#validate_token'

  get 'follow', to: 'user_joins#index'

  get 'follow/:id/followers', to: 'user#followers'
  get 'follow/:id/following', to: 'user#following'

  get 'follow/:id', to: 'user_joins#show'
  post 'follow', to: 'user_joins#create'
  delete 'follow', to: 'user_joins#destroy'
  
  post 'user', to: 'user#create'
  post 'login', to: 'user#login'

  get 'user/create'
  get 'user/index'
  get 'user/udpdate'
  get 'user/destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
