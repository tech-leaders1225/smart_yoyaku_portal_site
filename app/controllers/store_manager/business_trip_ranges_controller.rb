class StoreManager::BusinessTripRangesController < StoreManager::Base
  
  include StoreManager::BusinessTripRangesHelper
  
  # before_action :corrrect_store_manager, only: [:edit, :update, :destroy]
  before_action :set_masseur, only: [:edit, :update]
  # before_action :set_prefectures, only: [:edit]
  
  attr_accessor :city_ids
  
  def index
    @store = current_store_manager.store
    @masseurs = @store.masseurs
  end
  
  def edit
    @prefectures = Prefecture.all
    @ranges = @current_masseur.business_trip_ranges
  end
  
  def update
    # ストロングパラメーターの方法
    @current_masseur.update(city_business_trip_range_params)
    flash[:success] = "出張範囲を更新しました。"
    redirect_to store_manager_masseurs_business_trip_ranges_url
  end
  
  private
  
  def set_masseur
    @current_masseur = Masseur.find(params[:masseur_id])
  end
  
  def prefecture_business_trip_range_params
    params.require(:prefecture).permit(prefecture_ids: [])
  end
  
  def city_business_trip_range_params
    params.require(:masseur).permit(city_ids: [])
  end

end
