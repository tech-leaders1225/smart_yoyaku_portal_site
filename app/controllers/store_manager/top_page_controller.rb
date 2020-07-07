class StoreManager::TopPageController < StoreManager::Base

  def top
    @store_manager = current_store_manager
    if @store_manager.order_plan.nil?
      flash.now[:notice] = "現在ご利用中のプランは【無料プラン】となっております。「登録内容の編集」から有料プランをご契約いただきますと全ての機能をご利用いただくことができます。"
    end
  end
end