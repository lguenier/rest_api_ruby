Rails.application.routes.draw do
  get '/inventory', to: "inventories#index"
  post '/inventory', to: "inventories#create"

  get '/orders', to: "reservations#index"
  post '/reservations', to: "reservations#create"
end
