Rails.application.routes.draw do
  get 'search/search'
  get 'users/show'
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get '/search' => 'search#search'

  resources :books, only: [:create,:index,:show,:edit,:update,:destroy] do
    resource :favorites, only:[:create, :destroy]
    resources :post_comments, only:[:create, :destroy]
    end
  resources :users, only: [:index,:show, :edit, :update] do
    # フォロー機能↓↓↓↓
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

end
