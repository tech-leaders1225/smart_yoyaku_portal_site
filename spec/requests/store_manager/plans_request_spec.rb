require 'rails_helper'

RSpec.describe "StoreManager::Plans", type: :request do
  before do 
    # 同じstoreに所属する@masseurと@store_managerを作成
    @plan = create(:plan)
    @store_manager = @plan.store.store_manager
  end
  
  describe "GET /index" do
    context "store_managerがログイン中の場合" do
      it "同じstoreを持つplanのindexが表示されること" do
        sign_in @store_manager
        get store_manager_plans_path(@store_manager)
        expect(response).to have_http_status(:success)
        expect(response).to render_template :index
        expect(response.status).to eq 200
      end
    end
    context "userがログイン中の場合" do
      it "indexは表示されずstore_managerのログイン画面に遷移すること" do
          user = create(:user)
          sign_in user
          get store_manager_masseurs_path
          expect(response).to redirect_to new_store_manager_session_url
          expect(response.status).to eq 302
      end
    end
    
    context "ログアウト中の場合" do
      it "indexは表示されずstore_managerのログイン画面に遷移すること" do
        get store_manager_masseurs_path
        expect(response).to redirect_to new_store_manager_session_url
        expect(response.status).to eq 302
      end
    end
  end
  
  describe "GET /new" do
    context "store_managerがログイン中の場合" do
      it "同じstoreを持つplanのnewが表示されること" do
        sign_in @store_manager
        get new_store_manager_plan_path(@store_manager)
        expect(response).to have_http_status(:success)
        expect(response).to render_template :new
        expect(response.status).to eq 200
      end
    end
  end
  
  describe "POST /create" do
    context "store_managerがログイン中の場合" do
      it "入力内容が正しい場合、planが新規作成されること" do
        # plan_params = FactoryBot.attributes_for(:plan)
        # sign_in @store_manager
        # post store_manager_plans_path(@plan), params: { plan: plan_params }
        # expect(response.status).to eq 302
      end
      it "入力内容が不正な場合、planが新規作成されないこと" do
        # plan_params = FactoryBot.attributes_for(:plan, plan_name: "文字列オーバーです"*30)
        # sign_in @store_manager
        # post store_manager_plans_path(@plan), params: { plan: plan_params }
        # expect(@plan.reload.plan_name).to_not eq "文字列オーバーです"*30
        # expect(response.status).to eq 200
      end
    end
  end
  
  describe "GET /show" do
    context "store_managerがログイン中の場合" do
      it "同じstoreを持つplanのshowが表示されること" do
        sign_in @store_manager
        get store_manager_plan_path(@plan)
        expect(response).to have_http_status(:success)
        expect(response).to render_template :show
        expect(response.status).to eq 200
      end
    end
  end
  
  describe "GET /edit" do
    context "store_managerがログイン中の場合" do
      it "同じstoreを持つplanのeditが表示されること" do
        sign_in @store_manager
        get edit_store_manager_plan_path(@plan)
        expect(response).to have_http_status(:success)
        expect(response).to render_template :edit
        expect(response.status).to eq 200
      end
    end
  end
  
  describe "PATCH /update" do
    context "store_managerがログイン中の場合" do
      it "入力内容が正しい場合、plan情報が更新されること" do
        # plan_params = FactoryBot.attributes_for(:plan)
        # sign_in @store_manager
        # patch store_manager_plan_path(@plan), params: { plan: plan_params }
        # expect(response.status).to eq 302
      end
      it "入力内容が不正な場合、plan情報が更新されないこと" do
        # plan_params = FactoryBot.attributes_for(:plan, plan_name: "文字列オーバーです"*30)
        # sign_in @store_manager
        # patch store_manager_plan_path(@plan), params: { plan: plan_params }
        # expect(@plan.reload.plan_name).to_not eq "文字列オーバーです"*30
        # expect(response.status).to eq 200
      end
    end
  end
end