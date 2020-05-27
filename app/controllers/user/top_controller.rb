class User::TopController < User::Base
  def index
  end

  def shop
    @all_store = Store.all
  end

  def details
    @store = Store.find(params[:id])
    # @masseur = Masseur.find(params[:id])
    @plans = @store.plan
    @masseurs = @store.masseur.all
    @reviews = Review.all
  end
end
