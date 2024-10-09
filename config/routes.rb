Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  
  resources :rooms do
    resources :users do
      resources :games
      resources :ownplans
    end
  end

  

  resources :users do
    member do
      get 'check' 
      get 'check_edit'
      patch 'check_update'
    end
  end
  resources :games do
    member do
      get 'played_check' 
      patch 'played_update'
    end
  end
end