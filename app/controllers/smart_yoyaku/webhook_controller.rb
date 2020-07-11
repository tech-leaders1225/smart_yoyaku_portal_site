class SmartYoyaku::WebhookController < ApplicationController
  protect_from_forgery except: [:update_order_plan] 
 
  def update_order_plan
    token = params["user"]["token"]
    store_manager = StoreManager.find_by(smart_token: token)
    store_manager.update!(order_plan: order_plan)
  end

  private

    def order_plan
      if params["order_plan"]["status"] == "ongoing"
        params["order_plan"]["id"]      
      else
        nil
      end  
    end
end