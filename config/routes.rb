Rails.application.routes.draw do
  scope :api do
    namespace :users do
      post 'sign_up',                 to: 'registrations#create'
      post 'sign_in',                 to: 'sessions#create'
      get ':username/posts',          to: 'posts#index',          as: 'public_profile_posts'
      get ':username/public_profile', to: 'public_profiles#show', as: 'public_profile'
      get ':username/followers',      to: 'followers#index'
      get ':username/following',      to: 'following#index'
    end

    patch 'me/avatar', to: 'avatar_images#update'
    patch 'me',        to: 'users#update'

    post 'follow/:user_id',     to: 'relationships#create'
    delete 'unfollow/:user_id', to: 'relationships#destroy'

    resources :posts, only: [:index, :create] do
      resource :likes, only: [:create, :destroy], module: :posts
      resource :comments, only: [:create], module: :posts
    end
    resources :locations, only: [:show]
  end
end
