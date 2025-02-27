Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'items#index'
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :items do
    resources :orders, only:[:index, :create]
  end
end
