Rails.application.routes.draw do  
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  devise_for :users
  resources :categories
  resources :books
  resources :users

  namespace :admin do
    root 'categories#new'
    resources :categories 
    resources :books do
      resources :image_books
    end
  end
end
