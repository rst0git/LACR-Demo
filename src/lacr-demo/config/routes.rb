Rails.application.routes.draw do
  get 'search', to: 'search#search'

  resources :documents

  # Home page routes
  root 'home#index'
  get '/about', to: 'home#about'
  get '/contact', to: 'home#contact'

  # Documents routes
  get 'doc', to: "documents#index"
  get 'doc/new', to: "documents#new" # Must be accessible only from Admin
  get 'doc/edit', to: "documents#edit" # Must be accessible only from Admin
  get 'doc/example', to: "documents#example" # Only for the prototype
  post 'doc/new', to: "documents#create"
  get 'doc/show', to: "documents#show"

  # Download routes
  get 'download/zipped'
  get 'download/img'
  get 'download/tr', to: 'donwload#trancr'

  # Admin routes
  devise_scope :user do
    get "/admin" => "devise/sessions#new"
  end


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
