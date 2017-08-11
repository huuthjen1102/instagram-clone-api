Rails.application.routes.draw do
  scope :api do
    namespace :users do
      post 'sign_up', to: 'registrations#create'
      post 'sign_in', to: 'sessions#create'
    end

    patch 'me/avatar', to: 'avatar_images#update'

    resources :posts, only: [:index, :create]
  end
end
