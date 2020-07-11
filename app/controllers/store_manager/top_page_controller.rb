class StoreManager::TopPageController < StoreManager::Base

  def top
    @store_manager = current_store_manager
    if @store_manager.order_plan.nil?
      flash.now[:notice] = "現在ご利用中のプランは【無料プラン】となっており、#{@store_manager.store.store_name}様のページは非公開となっております。<br>
                            「登録内容の編集」から有料プランをご契約いただきますとページが公開され、お客様からのご予約が可能となります。".html_safe
    end
  end
end