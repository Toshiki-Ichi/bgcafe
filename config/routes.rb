Rails.application.routes.draw do
  devise_for :users
 root to: 'rooms#index'
 resources :rooms do
 resources :users, only: [:edit, :update,:show]
 resources :games, only: [:new, :create, :edit,:update,:show,:destroy]
 end

end
