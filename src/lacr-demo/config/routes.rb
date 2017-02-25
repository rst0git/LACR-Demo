Rails.application.routes.draw do

  devise_scope :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get 'login', to: 'devise/sessions#new'
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  end

  devise_for :users

  # Home page routes
  root to: 'home#index'
  get '/about', to: 'home#about'
  get '/contact', to: 'home#contact'

  # Documents page routes
  get 'doc', to: "documents#index"
  get 'doc/new', to: "documents#new"
  post 'doc/new', to: "documents#upload"
  get 'doc/show', to: "documents#show"
  get 'doc/page', to: "documents#page"
  get 'doc/page-s', to: "documents#page_simplified"
  delete 'doc/destroy', to: "documents#destroy"

  # Download
  get 'download/archive', to: "download#archive"

  # Ajax
  post 'ajax/download', to: "download#index"
  post 'ajax/doc/destroy', to: "documents#destroy"
  get 'ajax/doc/list', to: "documents#list"
  get 'ajax/search/autocomplete', to: 'search#autocomplete'

  # Search routes
  get 'search', to: 'search#search'
  get 'advanced_search', to: 'search#advanced_search'
end
