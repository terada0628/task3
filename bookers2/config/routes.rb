Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root 'homes#top'
  get 'homes/about'
  resources :books, only: [:create,:index,:show,:edit,:update,:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index,:show, :edit, :update]
end
