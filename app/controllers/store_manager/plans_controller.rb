class StoreManager::PlansController < StoreManager::Base
    
    def index
    end
    
    def new
      @plan = Plan.new
    end
    
    def create
      @plan = Plan.new(plan_params)
      if @plan.save
        flash[:success] = '新規作成に成功しました。'
        redirect_to store_manager_plans_path
      else
        flash[:danger] = '入力情報に誤りがありました。もう一度入力情報を確認して下さい。'
        render :new
      end
    end
    
    private
  
    def plan_params
      params.require(:plan).permit(:store_id, :plan_name, :plan_content, :plan_time, :plan_price)
    end
        
    
end
