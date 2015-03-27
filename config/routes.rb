Rails.application.routes.draw do  
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  devise_for :users
  resources :categories
  resources :users
  resources :book_states
  resources :favorites, only: :create
  resources :requests, except: :show
  resources :books do
    resources :reviews, except: [:show, :destroy, :index]
  end  
  resources :reviews, only: [:show, :destroy] do
    resources :comments, only: [:index, :create, :destroy]
  end

  namespace :admin do
    root 'requests#index'
    resources :categories 
    resources :books do
      resources :image_books
    end
    resources :requests, only: [:index, :update]
  end
end
