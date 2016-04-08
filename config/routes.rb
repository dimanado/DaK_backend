Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :courses
  resources :comments, only: [ :index, :destroy, :create]
  resources :video
  resources :categories, only: [ :index ]
  resources :users, only: [:show]
  put 'users/vote', to: 'users#vote'
  post 'users/get_id', to: 'users#get_id'
  resources :tasks, only: [:destroy, :create]
  resources :subscriptions, only: [] do
    member do
      post 'add_course'
      get 'check_status'
    end
  end
end
