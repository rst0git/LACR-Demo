Rails.application.routes.draw do

  controller :session do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'session/new'

  get 'session/create'

  get 'session/destroy'

  post 'users/permissions/:id' => 'users#permissions'
  resources :users

  get 'search', to: 'search#search'
  get 'search/autocomplete', to: 'search#autocomplete'

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
