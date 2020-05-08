class StoreManager::Base < ApplicationController
  before_action :sign_in_store_manager, only:[:top]
  before_action :correct_store_manager, only:[:top]
  layout 'store_manager'

  private
  # アクセスしたマッサージ師が現在ログインしているユーザーか確認します。
  def correct_store_manager
    unless StoreManager.find_by(id: params[:id]) == current_store_manager
      flash[:danger] = "アクセス権限がありません。"
      redirect_to store_manager_path(current_store_manager)
    end
  end
  # ログインしているかどうかの判定
  def sign_in_store_manager
    unless store_manager_signed_in?
      flash[:danger] = "ログインしてください。"
      redirect_to store_manager_session_path
    end
  end
end