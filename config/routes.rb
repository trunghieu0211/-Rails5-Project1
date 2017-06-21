Rails.application.routes.draw do
  root "posts#index"
  get "/signup", to: "users#new"
  get "/login",   to: "sessions#new"
  post "/signup",  to: "users#create"
  post "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users
  resources :posts do
    resources :comments
  end

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
