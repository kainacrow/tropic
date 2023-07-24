Rails.application.routes.draw do

  resources :contracts
  get 'contracts_import/new'
  post 'contracts_import/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "contracts#index"

  resources :contracts, only: [:index]
end
