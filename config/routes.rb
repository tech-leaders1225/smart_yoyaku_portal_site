Rails.application.routes.draw do

  # User↓========================================================================================
    root            to: "user/top#index"
    get "/shop",    to: "user/top#shop"
    get "/details", to: "user/top#details"

  # devise↓ =====================================================================================
    devise_for :admins, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :masseurs
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :users, controllers: {
      sessions:      'users/sessions',
      passwords:     'users/passwords',
      registrations: 'users/registrations'
    }

  # Admin↓========================================================================================
    namespace :admin do
    #  get '/top', to: 'admins#top'
    end

  # Masseur↓========================================================================================
    namespace :masseur do

    end

  # Store_manager↓========================================================================================
    devise_for :store_managers

    namespace :store_manager do

    end
end
