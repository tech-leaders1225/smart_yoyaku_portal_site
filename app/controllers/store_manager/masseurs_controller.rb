class StoreManager::MasseursController < StoreManager::Base
  include SmartYoyakuApi::Staff

  before_action :authenticate_store_manager!
  before_action :corrrect_store_manager, only: [:edit, :update, :destroy]
  before_action :set_masseur, only: [:edit, :update, :destroy] 

  #def new
  #  @massuer = Masseur.new
  #end

  #def create
  #  @masseur = Masseur.new(masseur_create_params)
  #  if @masseur.save
  #    flash[:success] = "新規マッサージ師を登録しました。"
  #    redirect_to store_manager_masseurs_url
  #  else
  #    flash[:danger] = "入力内容に誤りがあったため登録できませんでした。"
  #    render :new
  #  end
  #end

  def index
    @store = current_store_manager.store
    @masseurs = @store.masseurs
  end

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      if @masseur.update_attributes(masseur_update_params)
        flash[:success] = "#{@masseur.masseur_name}の情報を更新しました。"
        redirect_to store_manager_masseurs_url
        # 予約システムのStaff情報を更新
        @response = update_staff(@masseur)
        unless JSON.parse(@response)["status"] == "200"
          # 例外を発生させる
          raise StandardError, "予約システムでstaffのupdateに失敗しました。"
        end 
      else
        flash[:danger] = "入力内容に誤りがあったため更新できませんでした。"
        render :edit
      end
    end
  end

  #def destroy
  #  if @masseur.destroy
  #   flash[:success] = "#{@masseur.masseur_name}を削除しました。"
  #    redirect_to store_manager_masseurs_url
  #  else
  #    flash[:danger] = "#{@masseur.masseur_name}を削除することができませんでした。"
  #    redirect_to store_manager_masseurs_url
  #  end
  #end

  private

    # masseurをcreateする際のストロングパラメーター
    #def masseur_create_params
    #  if params[:masseur]
    #    params.require(:masseur).permit(:masseur_name, :email, :adress, :phone_number, :password,
    #                                    :password_confirmation).merge(store_id: current_store_manager.store.id)
    #  else
    #    params.permit(:masseur_name, :email, :adress, :phone_number, :password,
    #                  :password_confirmation).merge(store_id: current_store_manager.store.id)
    #  end
    #end

    # masseurをupdateする際のストロングパラメーター
    def masseur_update_params
      if params[:masseur][:password].blank? && params[:masseur][:password_confirmation].blank?
        params[:masseur].delete(:password)
        params[:masseur].delete(:password_confirmation)
      end
        params.require(:masseur).permit(:masseur_name, :email, :adress, :phone_number, :password, :password_confirmation)
    end

    def set_masseur
      @masseur = Masseur.find(params[:id])
    end

    # current_store_managerと紐づいていないmasseurの操作は不可
    def corrrect_store_manager
      unless current_store_manager.store.masseurs.ids.include?params[:id].to_i
        flash[:danger] = "アクセス権限がありません。"
        redirect_to store_manager_url(current_store_manager)
      end
    end
end