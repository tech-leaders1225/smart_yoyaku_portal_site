class StoreManager::BusinessTripRangesController < StoreManager::Base
  
  include StoreManager::BusinessTripRangesHelper
  
  # before_action :corrrect_store_manager, only: [:edit, :update, :destroy]
  before_action :set_masseur, only: [:edit, :update]
  # before_action :set_prefectures, only: [:edit]
  
  def index
    @store = current_store_manager.store
    @masseurs = @store.masseurs
  end
  
  def edit
    @prefectures = Prefecture.all
    @ranges = @current_masseur.business_trip_ranges
  end
  
  def update
    # トランザクションで条件分岐予定/全てのチェックボックスを一括更新
    business_trip_range_params.each do |id, item|
      business_trip_range = BusinessTripRange.find(id)
      business_trip_range.update_attributes!(item)
    end
    flash[:success] = "出張範囲を更新しました。"
    redirect_to store_manager_masseurs_business_trip_ranges_url
  end
  
  private
  
  def set_masseur
    @current_masseur = Masseur.find(params[:masseur_id])
  end
  
  def business_trip_range_params
    params.require(:masseur).permit(business_trip_ranges: [:prefecture_name, :city_judge])[:business_trip_ranges]
  end
end
