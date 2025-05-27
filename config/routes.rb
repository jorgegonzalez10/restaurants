Rails.application.routes.draw do
  get 'carts/show'
  devise_for :users
  get '/products/owner', to: "products#owner"
  get '/products/best', to: "products#best"
  resources :products do
    resources :reviews, only: %i[create new show destroy index]
  end
  namespace :users do
    get '/products/cards', to: "products#cards"
    resources :products
  end

  resources :carts, only: %i[create show]
  resources :line_items, only: %i[create destroy show] do
    member do
      patch :increment
      patch :decrement
    end
  end
  resources :orders, only: %i[create destroy show edit index] do
    member do
      post :payment
    end
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
   root "pages#home"
end
