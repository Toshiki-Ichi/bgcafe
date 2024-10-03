Rails.application.routes.draw do
  devise_for :users
 root to: 'rooms#index'
 resources :rooms do
 resources :users
 resources :games
 end

end
