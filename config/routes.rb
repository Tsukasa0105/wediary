Rails.application.routes.draw do

  get 'group_users/create'
  get 'group_users/destroy'
  get 'addresses/create'
  get 'addresses/destroy'
  get 'maps/index'
  get 'maps/create'
  root to: 'groups#index'
  
  get 'contact', to: 'toppages#contact'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users do
    collection do
      get :search
    end 
    member do
      get :followings
      get :followers
      get :friends
      get :join_groups
    end
  end
  
  resources :groups do
    collection do
      get :search
    end 
    
    member do
      get :group_users
      get :request_users
    end
    
    resources :events do
      resources :photos
      resources :pay_records, only: [:index, :new, :create]
    end
  end
  
  resources :initial_pay_relationships, only: [:create, :destroy]
  resources :pay_relationships, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :user_to_groups, only: [:create, :destroy]
  resources :group_to_users, only: [:create, :destroy]
  
  resources :maps, only: [:index, :create]
  
  
  
end
