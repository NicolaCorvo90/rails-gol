Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "home#index"

  get "gol", to: "gol#index"

  post "gol", to: "gol#upload"

  get "gol#show", to: "gol#show"

  post "next", to: "gol#next"

end
