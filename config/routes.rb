Rails.application.routes.draw do
  devise_for :users
 root to: 'rooms#index'
 resources :rooms 
 resources :users, only: [:edit, :update,:show]

end
