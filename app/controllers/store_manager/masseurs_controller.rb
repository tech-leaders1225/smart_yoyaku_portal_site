class StoreManager::MasseursController < StoreManager::Base
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
  #    redirect_to store_manager_masseurs_path
  #  else
  #    flash[:danger] = "入力内容に誤りがあったため登録できませんでした。"
  #    render :new
  #  end
  #end

  def index
    @masseurs = Masseur.where(store_id: current_store_manager.store.id)
    @store = Store.find(current_store_manager.store.id)
  end

  def edit
  end

  def update
    if @masseur.update_attributes(masseur_update_params)
      flash[:success] = "#{@masseur.masseur_name}の情報を更新しました。"
      redirect_to store_manager_masseurs_path
    else
      flash[:danger] = "入力内容に誤りがあったため更新できませんでした。"
      render :edit      
    end
  end

  #def destroy
  #  if @masseur.destroy
  #   flash[:success] = "#{@masseur.masseur_name}を削除しました。"
  #    redirect_to store_manager_masseurs_path
  #  else
  #    flash[:danger] = "#{@masseur.masseur_name}を削除することができませんでした。"
  #    redirect_to store_manager_masseurs_path
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
      unless current_store_manager.store.masseur.ids.include?params[:id].to_i
        flash[:danger] = "アクセス権限がありません。"
        redirect_to store_manager_path(current_store_manager)
      end
    end
end