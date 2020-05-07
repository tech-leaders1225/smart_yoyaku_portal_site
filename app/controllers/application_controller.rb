class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # deviceを使用したuserのsign_upとupdateに使用
  # users/registrations_controllerに移すとログアウトできなくなる
  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation, :nickname, :address, :gender ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  # userのログイン後の画面を指定
  # users/registrations_controllerに移すと動作しなくなる
  def after_sign_in_path_for(users)
    user_path(current_user)
  end
end
