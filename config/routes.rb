Rails.application.routes.draw do


  # devise↓ =====================================================================================
  devise_for :admins
  get 'admins/top', to: 'admins#top'
  devise_for :masseurs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }


  # User↓========================================================================================
  root "top#index"
  get "/shop", to: "top#shop"
  get "/details", to: "top#details"

  

  # Admin↓========================================================================================
  

  # Masseur↓========================================================================================

end
