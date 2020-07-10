class User::TopController < User::Base
  def index
  end

  def shop
    @all_store = Store.all
    
  end

  def details
    @store = Store.find(params[:id])
    @plans = @store.plans
    @store_images = StoreImage.find_by(store_id: @store)
    unless @store_images.nil?
      @count_store_image = @store_images.store_image.count
    end
  end
end
