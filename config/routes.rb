Rails.application.routes.draw do

  resources :players
  resources :articles
  resources :profile
  resources :teams
  resources :media
  

  get 'auth', to: 'auth#validate_token'
  post 'users', to: 'user#create'
  post 'login', to: 'user#login'
  get 'user/create'
  get 'user/udpdate'
  get 'user/destroy'

  # get 'articles', to: 'job_listing#index'
  # post 'listing', to: 'job_listing#create'
  
 
  
  # get 'search', to: 'search#api'
  # get 'user/index'
  # get 'user/show'
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
