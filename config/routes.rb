Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  
  resources :rooms do
      post 'enter', on: :collection
    resources :users do
      resources :games do 
        member do
        get 'played_check' 
        patch 'played_update'
        end
      end
      resources :groupschedules
      resources :ownplans do
        collection do
          post :create_plan
        end
      end
    end
  end


  resources :users do
    member do
      get 'check' 
      get 'check_edit'
      patch 'check_update'
      patch 'clear_join'
    end
  end
  resources :games 
end