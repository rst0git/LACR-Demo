Rails.application.routes.draw do

  devise_for :patrons
  get 'search', to: 'search#search'

  # resources :documents

  # Home page routes
  root 'home#index'
  get '/about', to: 'home#about'
  get '/contact', to: 'home#contact'

  # Documents routes
  get 'doc', to: "documents#index"
  get 'doc/new', to: "documents#new" # Must be accessible only from Admin
  # get 'doc/edit', to: "documents#edit" # Must be accessible only from Admin
  get 'doc/example', to: "documents#example" # Only for the prototype
  post 'doc/new', to: "documents#upload"
  # post 'doc/edit', to: "documents#save"
  get 'doc/show', to: "documents#show"
  delete 'doc/destroy', to: "documents#destroy"

  # Download routes
  get 'download/zipped'
  get 'download/img'
  get 'download/tr', to: 'donwload#trancr'

end
