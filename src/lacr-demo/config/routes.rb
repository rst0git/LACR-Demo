Rails.application.routes.draw do

  # Home page routes
  root to: 'home#index'
  get '/about', to: 'home#about'
  get '/contact', to: 'home#contact'

  # Documents page routes
  get 'doc', to: "documents#index"
  get 'doc/new', to: "documents#new"
  post 'doc/new', to: "documents#upload"
  get 'doc/show', to: "documents#show"
  delete 'doc/destroy', to: "documents#destroy"

  # Ajax
  get 'ajax/doc/list', to: "documents#list"
  get 'ajax/search/autocomplete', to: 'search#autocomplete'

  # Search routes
  get 'search', to: 'search#search'
  get 'advanced_search', to: 'search#advanced_search'
  post 'advanced_search', to: 'search#filter'
end
