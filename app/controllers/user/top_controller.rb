class User::TopController < User::Base
  include SmartYoyakuApi::User
  
  before_action :set_categories
  before_action :not_found, only: :details

  def index
  end

  def shop
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @all_store = Store.categorized(params[:category_id]).active
    else
      @all_store = Store.active
    end
  end

  def details
    @reserve_app_url = reserve_app_url
    @plans = @store.plans
    @store_images = StoreImage.find_by(store_id: @store)
    unless @store_images.nil?
      @count_store_image = @store_images.store_image.count
    end
  end

  private

    def set_categories
      @categories = Category.all
    end

    # @storeのstore_managerが無料プラン契約中の場合404エラーを表示
    def not_found
      @store = Store.find(params[:id])
      if @store.store_manager.order_plan.nil?
        raise ActiveRecord::RecordNotFound, "こちらのページは現在表示することができません。"
      end
    end
end
