class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # adminでログイン後のリダイレクト先を指定
  def after_sign_in_path_for(resource)
    admin_top_path
  end
end
