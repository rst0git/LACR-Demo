Rails.application.routes.draw do

  devise_for :users
  devise_for :admins, ActiveAdmin::Devise.config

  # below code to fix the active admin issue when table not exists in database as activeadmin tries to load every model.
  # for reference https://github.com/activeadmin/activeadmin/issues/783
  begin
    ActiveAdmin.routes(self)
  rescue Exception => e
    puts "ActiveAdmin: #{e.class}: #{e}"
  end
  # Home page routes
  root 'home#index'
  get '/about', to: 'home#about'
  get '/contact', to: 'home#contact'
  
  get 'search', to: 'search#search'

  # resources :documents

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
