class StoreManager::BusinessTripRangesController < StoreManager::Base
  
  include StoreManager::BusinessTripRangesHelper
  
  # before_action :corrrect_store_manager, only: [:edit, :update, :destroy]
  before_action :set_masseur, only: [:edit, :update]
  
  def index
    @store = current_store_manager.store
    @masseurs = @store.masseurs
  end
  
  def edit
  end
  
  def update
  end
  
  private
  
  def set_masseur
    @current_masseur = Masseur.find(params[:masseur_id])
  end
    
end
