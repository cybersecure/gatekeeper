Gatekeeper::Application.routes.draw do
  resources :users
  match 'signup' => 'users#new', :as => :signup

  match '/user' => 'users#show'

  root :to => 'home#index'

  scope :module => 'authentication' do
    resources :sessions
    resources :password_resets
    
    match 'login' => 'sessions#new', :as => :login
    match 'logout' => 'sessions#destroy', :as => :logout
  end

  namespace :oauth do
    match "authorize" => "auth_requests#new"
    match "access_token" => "access_tokens#new"
    match "logout" => "sessions#destroy"
  end
end
