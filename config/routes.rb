Ck::Application.routes.draw do

  root :to => 'pages#index'

  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  post 'check' => 'sessions#create', :as => :check
  get 'profil' => 'users#show', :as => :account

  resources :users
  resources :pages
  resources :videos

  resources :forums do
    resources :posts
  end
  
  resources :events do
    resources :members
    resources :posts
  end
end
