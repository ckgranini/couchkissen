Ck::Application.routes.draw do
  root :to => 'events#index'

  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  post 'check' => 'sessions#create', :as => :check

  resources :users

  resources :forums do
    resources :posts
  end
  
  resources :events do
    resources :members
    resources :posts
  end
end
