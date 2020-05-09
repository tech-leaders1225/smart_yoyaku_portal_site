Rails.application.routes.draw do

  namespace :store_manager do
    get 'top_page/new'
  end
  # User↓========================================================================================
    root            to: "user/top#index"
    get "/shop",    to: "user/top#shop"
    get "/details", to: "user/top#details"
  # devise↓ =====================================================================================
    devise_for :admins, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :masseurs
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_scope :user do
      get "/user/:id", :to => "users/registrations#show"
    end

    devise_for :users, controllers: {
      sessions:      'users/sessions',
      passwords:     'users/passwords',
      registrations: 'users/registrations'
    }

    devise_scope :user do
      get "/users/:id", :to => "users/registrations#show", as: :user
    end

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
      get "/store_manager/top", to: 'top_page#top'
    end
end
