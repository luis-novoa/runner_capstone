Rails.application.routes.draw do
  root 'users#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:create, :destroy]
  resources :transactions, only: [:new, :create]
  resources :groups, only: [:new, :create, :index, :show]
  resources :groups do
    resources :transactions
  end
end
