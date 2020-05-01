class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # deviceを使用したuserのsign_upに使用
  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation, :nickname, :address, :gender ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
