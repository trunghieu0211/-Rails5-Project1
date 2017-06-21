Rails.application.routes.draw do
  root "posts#index"
  get "/signup", to: "users#new"
  get "/login",   to: "sessions#new"
  post "/signup",  to: "users#create"
  post "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users, only: [:create, :show]
  resources :posts do
    resources :comments
  end
end
