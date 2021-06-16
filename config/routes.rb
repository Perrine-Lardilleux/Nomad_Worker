Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root to: 'pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :cities, only: [:show, :index] do
    resources :reviews, only: [:create, :update, :destroy]
    resources :wishlists, only: [:create, :destroy]
    get '/cost-of-living-estimator', to: 'pages#estimator', as: 'estimator'
    post 'send_city_email', to: 'cities#send_details'
    post 'send_city_offers_email', to: 'cities#send_offers'
  end

  resources :wishlists, only: [:index]

  get 'my_profile', to: 'pages#my_profile', as: 'my_profile'

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  require 'sidekiq/web'
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
