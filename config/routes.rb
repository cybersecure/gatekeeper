CsTalk::Application.routes.draw do
  resources :users
  resources :sessions
  resources :password_resets
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'signup' => 'users#new', :as => :signup
  root :to => 'home#index'
  
  match "/oauth/authorize", :via => :get, :to => "authorization#new"
  match "/oauth/authorize", :via => :post, :to => "authorization#create"
end
