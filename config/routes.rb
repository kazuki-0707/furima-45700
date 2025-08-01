Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :items do
    resources :orders, only: [:index, :create]
  end
end
