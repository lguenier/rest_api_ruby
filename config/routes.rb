Rails.application.routes.draw do
  get '/inventory', to: "inventories#index"
  post '/inventory', to: "inventories#create"
end
