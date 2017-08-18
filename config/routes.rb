Rails.application.routes.draw do
  scope :api do
    mount ActionCable.server => '/cable'

    namespace :users do
      post 'sign_up',                 to: 'registrations#create'
      post 'sign_in',                 to: 'sessions#create'
      post 'facebook/login',          to: 'facebook_logins#create'
      get ':username/posts',          to: 'posts#index',          as: 'public_profile_posts'
      get ':username/public_profile', to: 'public_profiles#show', as: 'public_profile'
      get ':username/followers',      to: 'followers#index'
      get ':username/following',      to: 'following#index'

      resources :notifications, only: [:index, :update]
      resources :notification_counts, only: [:show, :destroy]
    end

    patch 'me/avatar', to: 'avatar_images#update'
    patch 'me',        to: 'users#update'

    post 'follow/:user_id',     to: 'relationships#create'
    delete 'unfollow/:user_id', to: 'relationships#destroy'

    get 'posts/tags/:tag_name', to: 'tags/posts#index'
    resources :posts, only: [:index, :create] do
      resource :likes, only: [:create, :destroy], module: :posts
      resource :comments, only: [:index, :create, :destroy], module: :posts
    end
    resources :locations, only: [:show]
  end
end
