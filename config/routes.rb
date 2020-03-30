Rails.application.routes.draw do
  devise_for :masseurs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  root "top#index"
  get "/shop", to: "top#shop"
  get "/details", to: "top#details"
end
