class StoreManager::StoreController < StoreManager::Base
  def new

  end

  def create
  end

  def edit
    @store = current_store_manager.store
  end

  def update
    @store = current_store_manager.store
    if @store.update(store_params)
      redirect_to store_manager_url(current_store_manager)
    else
      redirect_to store_manager_url(current_store_manager)
    end
  end

  private

  def store_params
    params.require(:store).permit(:store_name, :adress, :store_phonenumber, :store_description, storeimages_attributes:[:id, {image: []},:remove_image ])
  end
end
