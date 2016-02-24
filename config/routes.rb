Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :courses
  resources :video do
    member do
      put 'vote', to: 'video#vote'
    end
  end
  resources :users, only: [:show]
  resources :subscriptions, only: [] do
    member do
      post 'add_course'
      get 'check_status'
    end
  end
end
