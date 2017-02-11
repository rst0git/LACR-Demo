Rails.application.routes.draw do

  # Home page routes
  root 'home#index'
  get '/about', to: 'home#about'
  get '/contact', to: 'home#contact'

  # Documents page routes
  get 'doc', to: "documents#index"
  get 'doc/new', to: "documents#new"
  post 'doc/new', to: "documents#upload"
  get 'doc/show', to: "documents#show"
  delete 'doc/destroy', to: "documents#destroy"

  # Search routes
  get 'search', to: 'search#search'
  get 'advanced_search', to: 'search#advanced_search'
end
