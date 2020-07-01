class StoreManager::PlansController < StoreManager::Base
  before_action :sign_in_store_manager
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :corrrect_store_manager, only: [:edit, :update, :destroy]
  require "uri"
  require "net/http"

  def index
    @plans = current_store_manager.store.plans
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_store_manager.store.plans.build(plan_params)
    ActiveRecord::Base.transaction do
      response_parse = SmartYoyakuApi::TaskCourse.task_course_create(@plan)
      @plan.course_id = response_parse['data']['id']
      @plan.save
      if @plan.persisted?
        flash[:success] = '新規作成に成功しました。'
        redirect_to store_manager_plans_url
      else
        flash.now[:danger] = '入力情報に誤りがありました。もう一度入力情報を確認して下さい。'
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      if @plan.update(plan_params)
      response_parse = SmartYoyakuApi::TaskCourse.task_course_update(@plan)
        if response_parse['status'] == "200"
          flash[:success] = "#{@plan.plan_name}の情報を更新しました。"
          redirect_to store_manager_plans_url
        else
          raise RuntimeError
        end
      else
        flash.now[:danger] = "入力内容に誤りがあったため更新できませんでした。"
        render :edit
      end
    end
  end


  def destroy
    ActiveRecord::Base.transaction do
      if @plan.destroy
        response_parse = SmartYoyakuApi::TaskCourse.task_course_delete(@plan)
        if response_parse['status'] == "200"
          flash[:success] = "プランを削除しました。"
        else
          raise RuntimeError
        end
      else
        flash[:danger] = '削除に失敗しました。再度やり直してください。'
      end
    redirect_to store_manager_plans_url(current_store_manager)
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:store_id, :plan_name, :plan_content, :plan_time, :plan_price)
  end

  def sign_in_store_manager
    unless store_manager_signed_in?
      flash[:danger] = "ログインしてください。"
      redirect_to store_manager_session_url
    end
  end

  def corrrect_store_manager
    unless current_store_manager.store.plans.ids.include?params[:id].to_i
      flash[:danger] = "アクセス権限がありません。"
      redirect_to store_manager_url(current_store_manager)
    end
  end
end
