Ck::Application.routes.draw do

  root :to => 'pages#index'

  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  post 'check' => 'sessions#create', :as => :check
  get 'profil' => 'users#show', :as => :account
  get 'movies/search' => 'search#movies', :as => :search_movies

  resources :users
  resources :pages
  resources :videos
  resources :movies

  resources :forums do
    resources :posts
  end
  
  resources :events do
    resources :members
    resources :posts
  end
end
