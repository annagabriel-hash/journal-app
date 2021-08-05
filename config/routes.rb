Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'categories#index'
  resources :categories
  resources :tasks
  get 'signup', to: 'users#new'
  resources :users, except: :new
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
end
