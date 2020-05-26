class StoreManager::StoreController < StoreManager::Base
  def new

  end

  def create
  end

  def edit
    @store = Store.find(current_store_manager.store.id)
  end

  def update
    @store = Store.find(current_store_manager.store.id)
    if @store.update(store_params)
      flash[:success] = "#{@store.store_name}の情報を更新しました。"
      redirect_to store_manager_url(current_store_manager)
    else
      flash[:danger] = "入力内容に誤りがあったため更新できませんでした。"
      render :edit
    end
  end

  private

  def store_params
    params.require(:store).permit(:store_name, :adress, :store_phonenumber, :store_description, storeimages_attributes:[:id, {image: []},:remove_image ])
  end
end
