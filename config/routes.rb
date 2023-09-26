Rails.application.routes.draw do

  get 'books/index'
  get 'books/show'
  get 'books/edit'
  devise_for :users
  root to: 'homes#top'
  get 'homes/top'
  get 'homes/about', to: 'homes#about', as: 'about'
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [ :index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
