class StoreManager::TopPageController < StoreManager::Base
  def top
    @store_manager = current_store_manager
    store = @store_manager.store
    masseur = Masseur.find_by(store_id: store.id)
    if masseur.blank?
      Masseur.create(masseur_name: @store_manager.name,
                     email: @store_manager.email,
                     password: "password",
                     store_id: store.id)
    end
  end
end
