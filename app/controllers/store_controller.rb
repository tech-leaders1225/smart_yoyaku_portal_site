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
      redirect_to store_manager_path(current_store_manager)
    else
      redirect_to store_manager_path(current_store_manager)
    end
  end

  private

  def store_params
    params.require(:store).permit(:store_name, :adress, :store_phonenumber, :store_description, storeimages_attributes:[:id, {image: []},:remove_image ])
  end
end
