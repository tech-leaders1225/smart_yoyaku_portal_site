class StoreManager::PlansController < StoreManager::Base
  before_action :set_paln, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_store_manager.store.plan.build(plan_params)
    if @plan.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to store_manager_plans_path
    else
      flash[:danger] = '入力情報に誤りがありました。もう一度入力情報を確認して下さい。'
      render :new
    end
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      flash[:success] = "#{@plan.plan_name}の情報を更新しました。"
      redirect_to store_manager_plans_url
    else
      flash[:danger] = "入力内容に誤りがあったため更新できませんでした。"
      render :edit
    end
  end


  def destroy
    if @plan.destroy
      flash[:success] = "プランを削除しました。"
      redirect_to store_manager_plans_url(current_store_manager)
    else
      flash[:danger] = '削除に失敗しました。再度やり直してください。'
      redirect_to store_manager_plans_url(current_store_manager)
    end
  end

  private

  def set_paln
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:store_id, :plan_name, :plan_content, :plan_time, :plan_price)
  end
end
