Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  get 'signup', to: 'users#new'
  resources :users, except: :new do
    resources :categories
    resources :tasks
  end
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
end
