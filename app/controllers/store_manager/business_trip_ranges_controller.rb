class StoreManager::BusinessTripRangesController < StoreManager::Base
  
  include StoreManager::BusinessTripRangesHelper
  
  # before_action :corrrect_store_manager, only: [:edit, :update]
  before_action :set_masseur, only: [:edit, :update, :show]
  
  def index
    @store = current_store_manager.store
    @masseurs = @store.masseurs
  end
  
  
  
  def edit
    @prefectures = Prefecture.all
    @ranges = @current_masseur.business_trip_ranges
  end
  
  def update
    # チェックがあった場合
    if params[:masseur].present?
      @current_masseur.update(city_business_trip_range_params)
      flash[:success] = "出張範囲を更新しました。"
      redirect_to store_manager_masseurs_business_trip_ranges_url
    # 一つもチェックがなかった場合
    else
      flash[:success] = "出張範囲を選択してください。"
      redirect_to store_manager_masseurs_business_trip_ranges_url
    end
  end
  
  def show
    @business_trip_ranges = @current_masseur.business_trip_ranges
    # 閲覧中のマッサージ師が持っている出張範囲(市町村)が属している都道府県IDを配列にして取得
    @prefecture_ids = @current_masseur.business_trip_ranges.pluck(:city_id).map {|id| City.find_by(id: id).prefecture_id } 
    # 閲覧中のマッサージ師が持っているcity_idを配列で取得
    @city_ids = @current_masseur.business_trip_ranges.pluck(:city_id)
  end
  
  private
  
  def set_masseur
    @current_masseur = Masseur.find(params[:masseur_id])
  end
  
  def city_business_trip_range_params
    if params[:masseur].present?
      params.require(:masseur).permit(city_ids: [])
    end
  end

end
