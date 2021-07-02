Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books, only: [:create,:index,:show,:edit,:update,:destroy] do
    resource :favorites, only:[:create, :destroy]
    resources :post_comments, only:[:create, :destroy]
    end
  resources :users, only: [:index,:show, :edit, :update]
end
