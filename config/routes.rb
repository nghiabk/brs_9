Rails.application.routes.draw do 
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  match '/users/:id/:type', to: 'users#show', via: :get

  devise_for :users

  resources :users, only: [:index, :show, :destroy]
  resources :activities, only: [] do
    resources :likes, only: [:create, :destroy]
  end

  resources :categories, only: [:index, :show]
  resources :book_states, only: [:create, :update]
  resources :favorites, only: :create
  resources :requests, except: :show
  resources :relationships, only: [:create, :destroy]
  resources :books, only: [:index, :show] do
    resources :reviews, except: [:show, :destroy, :index]
  end  
  resources :reviews, only: [:show, :destroy] do
    resources :comments, only: [:index, :create, :destroy]
  end

  namespace :admin do
    root 'requests#index'
    resources :categories, except: [:index, :show]
    resources :books, except: [:index, :show]
    resources :requests, only: [:index, :update]
  end
end
