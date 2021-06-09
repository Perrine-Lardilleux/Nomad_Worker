Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cities, only: [:show, :index] do
    resources :reviews, only: [:create, :update, :destroy]
    resources :wishlists, only: [:create, :destroy]
    get '/economical', to: 'pages#economical', as: 'economical'
    get '/expensive', to: 'pages#expensive', as: 'expensive'
  end
  resources :wishlists, only: [:index]
  get 'my_profile', to: 'pages#my_profile', as: 'my_profile'
end
