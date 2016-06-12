Rails.application.routes.draw do

  post  '/rate'              => 'rater#create', as: 'rate'
  mount RailsAdmin::Engine   => '/admin',       as: 'rails_admin'
  mount ShoppingCart::Engine => "/"

  devise_for :users, controllers: {:omniauth_callbacks => 'omniauth_callbacks'}

  root to: "main#index"

  resources :shop,     controller: 'category', only: [:index, :show]
  resources :products, controller: 'book',     only: [:index, :show]
  resources :reviews,  controller: 'review',   only: [:new, :create]

end