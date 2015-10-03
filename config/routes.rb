Rails.application.routes.draw do
  get 'course/index'

  mount_devise_token_auth_for 'User', at: 'auth'

  resources :courses
end
