# frozen_string_literal: true

class StoreManagers::RegistrationsController < Devise::RegistrationsController
  require 'json'

  before_action :sign_in_store_manager, only:[:show, :index]
  before_action :correct_store_manager, only:[:show, :index]
  after_action :update_user, only: [:update]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # 登録内容の編集
  def show
    @store = current_store_manager.store
  end

  # 予約の確認
  def index
  end

  # 予約の詳細
  def details
  end

  # 新規登録画面
  def new
    @store_manager = StoreManager.new
    @store = @store_manager.build_store
    @image = @store.storeimages.build
    @plan = @store.plans.build
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    
    # StoreManagerのsaveが成功した場合
    if resource.persisted?
      @masseur = create_masseur
      # 予約システム側でUser, Caledar, TaskCourseを作成
      set_store_and_plan
      @response = create_user(@store_manager, @store, @plan)

      begin
        @parsed_json = JSON.parse(@response)
      rescue JSON::ParserError => e
        puts "[ERROR: No Response From ReserveApp, #{e}]"
        system_error_response
        return
      end
      if @parsed_json["status"] == "200" #レスポンスが返らない場合(予約システムのサーバーダウンなど)ここでJSON::ParserErrorが出る
        # @responseに含まれるtokenと各idを登録
        organize_response     
        update_resourses
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        redirect_to reserve_app_url
      else
        # StoreManagerの登録を含め全て取り消して500エラーを出す？
        system_error_response   
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  #If you have extra params to permit, append them to the sanitizer.
  #def configure_sign_up_params
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  #end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  # アカウント登録後のリダイレクト先
  # def after_sign_up_path_for(resource)
  #   store_manager_path(current_store_manager)
  # end

  #アカウント編集後のリダイレクト先
  def after_update_path_for(resource)
    store_manager_path(current_store_manager)
  end


  private

    # アクセスしたマッサージ師が現在ログインしているユーザーか確認します。
    def correct_store_manager
      unless StoreManager.find_by(id: params[:id]) == current_store_manager
        flash[:danger] = "アクセス権限がありません。"
        redirect_to store_manager_url(current_store_manager)
      end
    end

    # ログインしているかどうかの判定
    def sign_in_store_manager
      unless store_manager_signed_in?
        flash[:danger] = "ログインしてください。"
        redirect_to store_manager_session_url
      end
    end

    def create_masseur
      @store_manager.store.masseurs.create!(
        masseur_name: @store_manager.name,
        email: @store_manager.email,
        password: "password"
      )
    end

    # 予約システム側で保持するtoken, idをポータルサイト側で保存
    def update_resourses
      begin
        @store_manager.update!(smart_token: @user_token)
        @store.update!(calendar_id: @calendar_public_uid)
        @plan.update!(course_id: @task_course_id)
        @masseur.update!(staff_id: @staff_id)
      rescue => e
        puts "[ERROR: #{e}]"
        system_error_response
        return
      end
    end

    def set_store_and_plan
      @store = @store_manager.store
      @plan = @store.plans.first
    end

    # 予約システム側でUserの登録を行う
    def create_user(store_manager, store, plan)
      url = reserve_app_url + "api/v1/users"
      `curl -v POST "#{url}" \
      -d '{"user":{"store_manager_id":"#{store_manager.id}","name":"#{store_manager.name}","email":"#{store_manager.email}","password":"#{store_manager.password}"},\
      "calendar":{"calendar_name":"#{store.store_name}","address":"#{store.adress}","phone":"#{store.store_phonenumber}"},\
      "task_course":{"title":"#{plan.plan_name}","description":"#{plan.plan_content.gsub(/(\r\n|\r|\n)/, "")}","course_time":"#{plan.plan_time}","charge":"#{plan.plan_price}"}}' \
      -H 'Accept: application/json' \
      -H 'Content-Type:application/json'`
    end
    
    # 予約システム側でUserの更新を行う
    def update_user
      url = reserve_app_url + "api/v1/users/#{current_store_manager.id}"
      `curl -v -X PATCH "#{url}" \
      -d '{"user":{"name":"#{current_store_manager.name}","email":"#{current_store_manager.email}","password":"#{current_store_manager.password}"}}' \
      -H 'Accept: application/json' \
      -H 'Content-Type:application/json' \
      -H 'Authorization: Bearer #{current_store_manager.smart_token}'`
    end

    def reserve_app_url
      reserve_app_url =
        if Rails.env.development?
          "http://localhost:3000/"
        else
          # production環境のurlが入る
          # "http://stage-smartyoyaku-env.ap-northeast-1.elasticbeanstalk.com/"
        end
    end

    # 受け取ったresponseからupdate_resoursesに必要な情報のみを整形
    def organize_response
      @user_token = @parsed_json["user"]["token"]
      @calendar_public_uid = @parsed_json["user"]["calendars"][0]["public_uid"]
      @task_course_id = @parsed_json["user"]["calendars"][0]["task_courses"][0]["id"]
      @staff_id = @parsed_json["staff"]["id"]
    end

    def system_error_response
      flash[:notice] = "システムトラブルが発生しました。大変恐れ入りますがポータルサイト管理者まで一度お問合わせくださいませ。"
      redirect_to root_url
    end
end
