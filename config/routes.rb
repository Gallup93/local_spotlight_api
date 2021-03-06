Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/users/login', to: 'users#login'

      resources :artists, only: [:index, :create]
    end
  end
end
