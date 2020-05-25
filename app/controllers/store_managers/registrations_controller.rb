# frozen_string_literal: true

class StoreManagers::RegistrationsController < Devise::RegistrationsController
  before_action :sign_in_store_manager, only:[:show, :index]
  before_action :correct_store_manager, only:[:show, :index]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def show
    @store = current_store_manager.store
  end

  def index
  end

  def details
  end

  # GET /resource/sign_up
  def new
    @store_manager = StoreManager.new
    @store = @store_manager.build_store
    @image = @store.storeimages.build
  end

  # POST /resource
  def create
    super
  end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  #If you have extra params to permit, append them to the sanitizer.
  #def configure_sign_up_params
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  #end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  #アカウント登録後のリダイレクト先
  def after_sign_up_path_for(resource)
    store_manager_path(current_store_manager)
  end

  #アカウント編集後のリダイレクト先
  def after_update_path_for(resource)
    store_manager_path(current_store_manager)
  end

  private
  # アクセスしたマッサージ師が現在ログインしているユーザーか確認します。
  def correct_store_manager
    unless StoreManager.find_by(id: params[:id]) == current_store_manager
      flash[:danger] = "アクセス権限がありません。"
      redirect_to store_manager_url(current_store_manager)
    end
  end

  # ログインしているかどうかの判定
  def sign_in_store_manager
    unless store_manager_signed_in?
      flash[:danger] = "ログインしてください。"
      redirect_to store_manager_session_url
    end
  end
end
