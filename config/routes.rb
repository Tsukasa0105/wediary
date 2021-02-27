# frozen_string_literal: true

Rails.application.routes.draw do
  get 'addresses/create'
  get 'addresses/destroy'
  root to: 'groups#index'

  get 'question', to: 'toppages#question'
  get 'how_to', to: 'toppages#how_to'

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
      get :invite_user
    end

    resources :events do
      resources :photos
      resources :pay_records, only: %i[index new create destroy] do
        member do
          get :pay_users
        end
      end
      resources :memos, only: %i[index new create destroy]
    end
  end

  resources :favorites, only: %i[create destroy]
  resources :initial_pay_relationships, only: %i[create destroy]
  resources :pay_relationships, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  resources :user_to_groups, only: %i[create destroy]
  resources :group_to_users, only: %i[create destroy]
  resources :notifications, only: %i[index] do
    collection do
      delete :destroy_all
    end
  end

  resources :maps, only: %i[index create]
end
