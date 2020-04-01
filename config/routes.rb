Rails.application.routes.draw do
  
  # devise↓ =====================================================================================
    devise_for :admins
    devise_for :masseurs
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :users, controllers: {
      sessions:      'users/sessions',
      passwords:     'users/passwords',
      registrations: 'users/registrations'
    }


  # User↓========================================================================================
    namespace :user do
      root "top#index"
      get "/shop", to: "top#shop"
      get "/details", to: "top#details"
    end

  

  # Admin↓========================================================================================
    namespace :admin do
      get 'admins/top', to: 'admins#top'
    end

  # Masseur↓========================================================================================
    namespace :masseur do

    end
end
