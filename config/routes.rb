Rails.application.routes.draw do
  scope :api do
    namespace :users do
      post 'sign_up', to: 'registrations#create'
    end
  end
end
