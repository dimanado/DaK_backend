Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :courses
  resources :video
  resources :users, only: [:show]
  resources :subscriptions, only: [] do
    collection do
      post 'add_course'
    end
  end
end
