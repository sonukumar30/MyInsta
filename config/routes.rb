Rails.application.routes.draw do

 

  use_doorkeeper  do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

   #doorkeeper
   namespace :api do
    
      resources :posts
    
  end

  # API
  namespace :api do
    namespace :v1 do
      resources :communities
    end
  end



  namespace :api do
    namespace :v1 do
      resources :likes do
        collection do
          get :comment_likes
          get :post_likes
        end
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :comments
    end
  end

  namespace :api do
    namespace :v1 do
      resources :accounts
    end
  end

  namespace :api do
    namespace :v1 do
      resources :posts do
        member do
          get :post_title
          get :post_likes
          get :post_comments
        end
      end
  end
end
  

 #main routes

  resources :memberships
  resources :groups  

  resources :communities

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  
  resources :accounts
  # get '/accounts', to: 'accounts#index'

 
  devise_for :users
  
  resources :likes, only: [:create, :destroy]
  
  root "posts#index"

  get 'home/about'

  resources :posts do
    resources :comments
  end
 
end
