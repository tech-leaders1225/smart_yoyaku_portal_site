class User::TopController < User::Base
  def index
  end

  def shop
    @all_store = Store.all
  end

  def details
    @store = Store.find(params[:id])
    @plans = @store.plans
  end
end
