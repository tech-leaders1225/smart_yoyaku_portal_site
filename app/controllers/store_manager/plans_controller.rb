class StoreManager::PlansController < StoreManager::Base
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
<<<<<<< HEAD
  require "uri"
  require "net/http"
=======
>>>>>>> 102613fe7422f7d4f543469d2a795f0cf8abee5e

  def index
    @plans = current_store_manager.store.plans
  end

  def new
    @plan = Plan.new
  end

  def create
<<<<<<< HEAD
    @plan = current_store_manager.store.plan.build(plan_params)
    ActiveRecord::Base.transaction do
      response_parse = SmartYoyakuApi::Task.task_create(@plan)
      if response_parse['status'] == "200"
        @plan.course_id = response_parse['data']['id']
        @plan.save!
        flash[:success] = '新規作成に成功しました。'
        redirect_to store_manager_plans_url
      else
        flash[:danger] = "技術的な問題が発生しました管理者にエラー番号とメッセージを連絡してください。#{response_parse['status']},#{response_parse['message']}"
        render :new
      end
      # @plan.update!(course_id: response_parse['data']['id'])
      # flash[:success] = '新規作成に成功しました。'
      # redirect_to store_manager_plans_url
    end
    rescue StandardError
=======
    @plan = current_store_manager.store.plans.build(plan_params)
    if @plan.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to store_manager_plans_url
    else
>>>>>>> 102613fe7422f7d4f543469d2a795f0cf8abee5e
      flash.now[:danger] = '入力情報に誤りがありました。もう一度入力情報を確認して下さい。'
      render :new
  end

  def show
  end

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      response_parse = SmartYoyakuApi::Task.task_update(@plan)
      if response_parse['status'] == "200"
        @plan.update!(plan_params)
        flash[:success] = "#{@plan.plan_name}の情報を更新しました。"
        redirect_to store_manager_plans_url
      else
        flash[:danger] = "技術的な問題が発生しました管理者にエラー番号とメッセージを連絡してください。#{response_parse['status']},#{response_parse['message']}"
        render :edit
      end
      # @plan.update!(plan_params)
      # SmartYoyakuApi::Task.task_update(@plan)
      # flash[:success] = "#{@plan.plan_name}の情報を更新しました。"
      # redirect_to store_manager_plans_url
    end
    rescue StandardError
      flash.now[:danger] = "入力内容に誤りがあったため更新できませんでした。"
      render :edit
  end


  def destroy
    # ActiveRecord::Base.transaction do
    #   response_parse = SmartYoyakuApi::Task.task_delete(@plan)
    #   if response_parse['status'] == "200"
    #     @plan.destroy
    #     flash[:success] = "プランを削除しました。"
    #   else
    #     flash[:danger] = "技術的な問題が発生しました管理者にエラー番号とメッセージを連絡してください。#{response_parse['status']},#{response_parse['message']}"
    #     redirect_to store_manager_plans_url(current_store_manager)
    #   end
    # rescue StandardError
    #   flash[:danger] = '削除に失敗しました。再度やり直してください。'
    # end

    if @plan.destroy
      SmartYoyakuApi::Task.task_delete(@plan)
      flash[:success] = "プランを削除しました。"
    else
      flash[:danger] = '削除に失敗しました。再度やり直してください。'
    end
<<<<<<< HEAD
  redirect_to store_manager_plans_url(current_store_manager)
=======
    redirect_to store_manager_plans_url(current_store_manager)
>>>>>>> 102613fe7422f7d4f543469d2a795f0cf8abee5e
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:store_id, :plan_name, :plan_content, :plan_time, :plan_price)
  end
end
