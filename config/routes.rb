Rails.application.routes.draw do
  get '/inventory', to: "products#index"
  post '/inventory', to: "products#create"

  get '/orders', to: "reservations#index"
  post '/reservations', to: "reservations#create"
end
