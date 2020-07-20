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
    params[:masseur][:city_ids].each {|id| @current_masseur.business_trip_ranges.create(city_id: id)}
    flash[:success] = "出張範囲を更新しました。"
    redirect_to store_manager_masseurs_business_trip_ranges_url
    
    
    
    # if params[:prefecture][:prefecture_ids].present? && 
    #   city_ids = params[:prefecture][:prefecture_ids].each {|id| Prefecture.find_by(id: id).cities.ids}
    #   city_ids.each {|id| @current_masseur.business_trip_ranges.create(city_id: id)} 
    #   params[:masseur][:city_ids].each {|id| @current_masseur.business_trip_ranges.create(city_id: id)}
    #   flash[:success] = "出張範囲を更新しました。"
    #   redirect_to store_manager_masseurs_business_trip_ranges_url
    # else
    # if params[:masseur].present?
    #   params[:masseur][:city_ids].each {|id| @current_masseur.business_trip_ranges.update(city_id: id)}
    # end
    #   flash[:success] = "出張範囲を更新しました。"
    #   redirect_to store_manager_masseurs_business_trip_ranges_url
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
