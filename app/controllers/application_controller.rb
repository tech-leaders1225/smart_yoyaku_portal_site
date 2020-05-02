class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  #userの更新、store_managerの更新 共通
  def configure_permitted_parameters
    added_attrs = [ :name, :nickname, :email, :address, :gender, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
