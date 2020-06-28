class StoreManager::TopPageController < StoreManager::Base

  def top
    @store_manager = current_store_manager
  end
end
