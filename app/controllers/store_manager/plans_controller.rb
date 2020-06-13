class StoreManager::PlansController < StoreManager::Base
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def index
    @plans = current_store_manager.store.plans
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_store_manager.store.plans.build(plan_params)
    if @plan.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to store_manager_plans_url
    else
      flash.now[:danger] = '入力情報に誤りがありました。もう一度入力情報を確認して下さい。'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      flash[:success] = "#{@plan.plan_name}の情報を更新しました。"
      redirect_to store_manager_plans_url
    else
      flash.now[:danger] = "入力内容に誤りがあったため更新できませんでした。"
      render :edit
    end
  end


  def destroy
    if @plan.destroy
      flash[:success] = "プランを削除しました。"
    else
      flash[:danger] = '削除に失敗しました。再度やり直してください。'
    end
    redirect_to store_manager_plans_url(current_store_manager)
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:store_id, :plan_name, :plan_content, :plan_time, :plan_price)
  end
end
