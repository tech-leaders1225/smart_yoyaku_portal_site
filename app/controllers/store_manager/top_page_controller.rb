class StoreManager::TopPageController < StoreManager::Base
  def top
    @store_manager = StoreManager.find_by(id: current_store_manager)
    store = Store.find_by(id: @store_manager.id)
    masseur = Masseur.find_by(id: store.id)
    if masseur == nil
      Masseur.create(masseur_name: @store_manager.name,
                     email: @store_manager.email,
                     password: "password",
                     store_id: store.id)
    end
  end
end
