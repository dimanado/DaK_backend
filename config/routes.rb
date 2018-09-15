Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :courses
  resources :comments, only: [ :index, :destroy, :create]
  resources :video
  resources :categories, only: [ :index ]
  resources :users, only: [ :show, :update, :index ]
  post 'users/vote', to: 'users#vote'
  post 'users/get_id', to: 'users#get_id'
  resources :tasks, only: [:destroy, :create]
  resources :subscriptions, only: [ :destroy ] do
    member do
      post 'add_course'
      get 'check_status'
    end
  end
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end
  resources :messages, only: [:new, :create]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :sessions
  
  namespace :admin do
    resources :categories
    resources :users
    root to: 'users#index', as: '/'
  end
end
