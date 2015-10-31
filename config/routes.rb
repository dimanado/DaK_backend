Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :courses
  resources :video
  resources :users, only: [:show]
end
