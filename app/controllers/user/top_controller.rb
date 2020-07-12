class User::TopController < User::Base
  before_action :not_found, only: :details

  def index
  end

  def shop
    @all_store = Store.active
  end

  def details
    @plans = @store.plans
    @store_images = StoreImage.find_by(store_id: @store)
    unless @store_images.nil?
      @count_store_image = @store_images.store_image.count
    end
  end

  private

    # @storeのstore_managerが無料プラン契約中の場合404エラーを表示
    def not_found
      @store = Store.find(params[:id])
      if @store.store_manager.order_plan.nil?
        raise ActiveRecord::RecordNotFound, "こちらのページは現在表示することができません。"
      end
    end
end
