Rails.application.routes.draw do
  root "weather#new"
  resources :weather, only: %i[new create show]
  post "/buscar", to: "weather#create", as: "buscar_weather"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
