Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  namespace :api do 
    get "/users_email" => "users_email#show", as: :users_email
    
    resources :favorites, only: [:create, :destroy]
  end

  get "/properites/search", to: "properties/search#index"

  resources :properties, only: :show do 
    resources :reservations, only: :new, controller: "properties/reservations"
  end

  resources :reservation_payments, only: :create

  resources :profiles, only: [:show, :update]

  resources :accounts, only: [:show, :update]

  resources :passwords, only: [:show, :update]

  resources :payments, only: :index

  put "/hostify/:user_id", to: "hosts#update", as: :hostify
  
  namespace :host do 
    get "/dashboard", to: "dashboard#index", as: :dashboard

    resources :properties, only: [:new, :create]

    resources :payments, only: :index
  end
end
 