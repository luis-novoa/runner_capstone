Rails.application.routes.draw do
  root 'users#new'
  get '/sessions' => redirect('/')
  get '/users' => redirect('/')
  get '/transactions' => redirect('/transactions/new')
  get '/create_group', to: 'groups#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:create, :destroy]
  resources :transactions, only: [:new, :create]
  resources :groups, only: [:index, :show]
  resources :groups, path: "create_group", as: :groups, only: [:create]
  resources :groups do
    resources :transactions
  end
end
